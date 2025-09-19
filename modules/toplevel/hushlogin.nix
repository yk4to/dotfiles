{delib, ...}:
delib.module {
  name = "hushlogin";

  # Create an empty file `.hushlogin` to remove the first line message
  home.always.home.file.".hushlogin".text = "";
}
