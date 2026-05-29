{
  lib,
  isDarwin,
  ...
}: {
  programs.ssh = {
    enable = true;

    # Keep Home Manager from reintroducing the legacy default Host * block.
    # This option will become deprecated in the future.
    enableDefaultConfig = false;

    # Include Orbstack config on macOS
    includes = lib.optional isDarwin "~/.orbstack/ssh/config";
  };
}
