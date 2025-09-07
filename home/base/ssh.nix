{
  lib,
  isDarwin,
  ...
}: {
  programs.ssh = {
    enable = true;

    # This option will become deprecated in the future.
    enableDefaultConfig = false;

    matchBlocks."*" = {
      forwardAgent = false;
      addKeysToAgent = "no";
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };

    # Include Orbstack config on macOS
    includes = lib.optional isDarwin "~/.orbstack/ssh/config";
  };
}
