# This file contains the main system configuration options
{ self, config, pkgs, lib, ... }: {
  imports = [ ./homebrew.nix ];

  nix.enable = false;
  nixpkgs.config.allowUnfree = true;
  networking.computerName = "mackhoa";
  networking.hostName = "mackhoa";
  # networking.knownNetworkServices = [ "Wi-Fi" ];
  # networking.dns = [ "100.100.100.100" "8.8.8.8" "8.8.4.4" ];
  environment.systemPackages = [
    pkgs.vim
    pkgs.mkalias
    pkgs.lazygit
    pkgs.lazydocker
    pkgs.btop
    pkgs.gh
    pkgs.neofetch
    pkgs.fzf
    pkgs.ripgrep
    pkgs.mkalias
    pkgs.fh
    pkgs.nil
    pkgs.cmake
    pkgs.nixfmt
    pkgs.nh
    pkgs.grpc-gateway
  ];

  environment.etc."nix/nix.custom.conf".text = pkgs.lib.mkForce ''
    lazy-trees = true
  '';
  # nix.package = pkgs.nix;
  fonts.packages = [
    # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # pkgs.nerd-fonts.JetBrainsMono
  ];

  # Necessary for using flakes on this system.
  # nix.settings.experimental-features = "nix-command flakes";
  security.pam.services.sudo_local.touchIdAuth = true;

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;

  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
      AppleShowAllFiles = true;
      ShowStatusBar = true;
    };
  };

  system.primaryUser = "mkhoatd";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
