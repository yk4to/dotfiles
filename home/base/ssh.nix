{
  lib,
  isDarwin,
  ...
}: {
  programs.ssh = {
    enable = true;

    # Include Orbstack config on macOS
    includes = lib.optional isDarwin "~/.orbstack/ssh/config";
  };
}
