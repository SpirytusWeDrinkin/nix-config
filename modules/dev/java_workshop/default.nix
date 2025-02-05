{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.dev.java_workshop;
in 
  {
  options.dev.java_workshop = {
    enable = mkEnableOption "java_workshop dependencies";
    jdtls = mkEnableOption "jdtls";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jdk21_headless
      postgresql
      quarkus
      maven
      nodejs_22
    ];
    home.file.".config/nvim/scripts/run_java" = ./run_java_vim;
    programs.neovim.extraLuaConfig = mkIf cfg.jdtls ''
      require('mason').setup({
          ui = {
              border = 'rounded',
          }
      })
      require('mason-lspconfig').setup({
        ensure_installed = {
          'jdtls',
        }
      })
    '';
  };
}
