{delib, ...}:
delib.module {
  name = "constants";

  options.constants = with delib; {
    username = readOnly (strOption "yuta");
    userfullname = readOnly (strOption "Yuta Kato");
    useremail = readOnly (strOption "64204135+yk4to@users.noreply.github.com");

    timeZone = readOnly (strOption "Asia/Tokyo");
    locale = readOnly (strOption "en_US.UTF-8");
  };
}
