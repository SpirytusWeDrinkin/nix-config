{ ... }:
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [ "--style minimal" ];
    colors = {
      # bg = "#363a4f";
      "bg+" = "#363a4f";
      spinner = "#f4dbd6";
      hl = "#ed8796";
      fg = "#cad3f5";
      header = "#ed8796";
      info = "#c6a0f6";
      pointer = "#f4dbd6";
      marker = "#b7bdf8";
      "fg+" = "#cad3f5";
      prompt = "#c6a0f6";
      "hl+" = "#ed8796";
      selected-bg = "#494d64";
    };
  };
}
