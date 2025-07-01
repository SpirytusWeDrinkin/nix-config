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
      {
        name = "you-should-use";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          rev = "030ac861f5f1536747407ac7baf208fd3990602a";
          sha256 = "0gx7gs5ds35vw15ygp98m6v8ryzgd1b57fwwn60zf4svpka43xc8";
        };
      }
      /*
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "c3d4e576c9c86eac62884bd47c01f6faed043fc5";
            sha256 = "1m8yawj7skbjw0c5ym59r1y88klhjl6abvbwzy6b1xyx3vfb7qh7";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "e0165eaa730dd0fa321a6a6de74f092fe87630b0";
            hash = "sha256-4rW2N+ankAH4sA6Sa5mr9IKsdAg7WTgrmyqJ2V1vygQ=";
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
