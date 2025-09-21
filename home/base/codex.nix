{
  programs.codex = {
    enable = true;

    settings = {
      model = "gpt-5-codex";

      tools.web_search = true;
    };
  };
}
