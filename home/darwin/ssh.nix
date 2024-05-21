_: let
  onePassPath = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
in {
  programs.ssh = {
    enable = true;

    includes = [ "~/.orbstack/ssh/config" ];

    matchBlocks = {
      "*".extraOptions = {
        IdentityAgent = "\"${onePassPath}\"";
      };
    };
  };
}