{pkgs, ...}: let
  onePassPath = if pkgs.stdenv.isDarwin then
    "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  else
    "~/.1password/agent.sock";

  includeConfig = if pkgs.stdenv.isDarwin then [ "~/.orbstack/ssh/config" ] else [];
in {
  programs.ssh = {
    enable = true;

    includes = includeConfig;

    matchBlocks = {
      "*".extraOptions = {
        IdentityAgent = "\"${onePassPath}\"";
      };
    };
  };
}