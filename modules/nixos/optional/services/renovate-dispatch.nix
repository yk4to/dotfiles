{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  # GitHub's own schedule trigger runs hours late, so dispatch it from here.
  dispatch = pkgs.writeShellApplication {
    name = "renovate-dispatch";
    runtimeInputs = [pkgs.curl];
    text = ''
      curl --fail-with-body --silent --show-error -X POST \
        -H @<(printf 'Authorization: Bearer %s\n' "$(< "$CREDENTIALS_DIRECTORY/token")") \
        -H "Accept: application/vnd.github+json" \
        -d '{"ref":"main"}' \
        https://api.github.com/repos/yk4to/dotfiles/actions/workflows/renovate.yml/dispatches
    '';
  };
in {
  config = lib.mkIf config.optionalModules.nixos.services.enable {
    age.secrets.github-dispatch.file = "${inputs.secrets}/github-dispatch.age";

    systemd.services.renovate-dispatch = {
      wants = ["network-online.target"];
      after = ["network-online.target"];
      serviceConfig = {
        Type = "oneshot";
        DynamicUser = true;
        LoadCredential = "token:${config.age.secrets.github-dispatch.path}";
        ExecStart = lib.getExe dispatch;
      };
    };

    systemd.timers.renovate-dispatch = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "Fri *-*-* 03:00:00 UTC";
        Persistent = true;
      };
    };
  };
}
