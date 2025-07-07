{ pkgs, ... }:
{
  imports = [
    ./starship.nix
  ];

  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "you-should-use";
        src = pkgs.zsh-you-should-use;
        file = "share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh";
      }
      /*
        {
          name = "you-should-use";
          src = pkgs.fetchFromGitHub {
            owner = "MichaelAquilina";
            repo = "zsh-you-should-use";
            rev = "030ac861f5f1536747407ac7baf208fd3990602a";
            sha256 = "0gx7gs5ds35vw15ygp98m6v8ryzgd1b57fwwn60zf4svpka43xc8";
          };
        }
      */
    ];

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };

    sessionVariables = {
      COLORTERM = "truecolor";
      TERM = "xterm-256color";
      EDITOR = "nvim";
    };

    shellAliases = rec {
      v = "nvim";
      vim = "nvim";
      ls = "lsd";
      lst = "${ls} --tree";
      tree = "${ls} --tree";
      la = "${ls} --all";
      k = "kubectl";
      c = "clear";
      shell = "nix-shell --run \"zsh\"";
      ":wq" = "exit";
      reload = "~/afs/setup.sh";
    };

    initContent = ''
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    '';
  };
}
