{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.dev.epita.java_workshop;
in 
  {
  options.dev.epita.java_workshop = {
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
    programs.neovim.extraLuaConfig = mkIf cfg.jdtls ''
      require('mason-lspconfig').setup({
        ensure_installed = {
          'jdtls',
        }
      })
    '';
  };
}
