# This file contains the main system configuration options
{ config, pkgs, lib,... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  nix.enable = false;
  nixpkgs.config.allowUnfree = true;
  networking.computerName = "mackhoa";
  networking.hostName = "mackhoa";
  environment.systemPackages =
    [
      pkgs.vim
      pkgs.mkalias
      pkgs.bun
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
      pkgs.cloudflared
      pkgs.ngrok
      pkgs.poetry
      pkgs.zig_0_13
      pkgs.zls
      pkgs.cmake
    ];

  environment.etc."nix/nix.custom.conf".text = pkgs.lib.mkForce ''
    lazy-trees = true
  '';
  # nix.package = pkgs.nix;
  fonts.packages =; })
    # pkgs.nerd-fonts.JetBrainsMono
  ];

  # Necessary for using flakes on this system.
  # nix.settings.experimental-features = "nix-command flakes";
  security.pam.services.sudo_local.touchIdAuth = true;

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;

  homebrew = {
    enable = true;
    global = {
      autoUpdate = true;
    };
    onActivation = {
      cleanup = "uninstall";
    };
    brews = [
      "nushell" "eza" "go" "dlv" "rust" "mas" "opam" "hg" "darcs" "bun"
      "aria2" "fish" "carapace" "ffmpeg" "direnv" "terraform" "typst"
      "ncdu" "ninja" "turnkey" "neovim" "uv" "yt-dlp" "ipatool" "pyenv"
    ];
    casks = [
      "neovide" "1password-cli" "git-credential-manager" "steamcmd"
      "miniforge" "adguard" "applite" "arc" "cloudflare-warp" "discord"
      "firefox" "flowvision" "flutter" "google-chrome" "iina" "iterm2"
      "karabiner-elements" "kodi" "jetbrains-toolbox" "lookaway"
      "messenger" "microsoft-auto-update" "microsoft-remote-desktop"
      "microsoft-teams" "motrix" "mountain-duck" "netnewswire" "notion"
      "obs" "obsidian" "orbstack" "orion" "postman" "qq" "rapidapi"
      "cursor" "visual-studio-code" "raycast" "sf-symbols" "slack"
      "steam" "transmission" "wezterm@nightly" "zalo" "zed" "zoom"
      "cursor" "logi-options+" "ghostty" "tuist"
    ];
    taps = [
      "bufbuild/buf" "codecrafters-io/tap" "felixkratz/formulae"
      "homebrew/autoupdate" "homebrew/bundle" "homebrew/services"
      "mistertea/et" "netdcy/flowvision" "nikitabobko/tap" "oven-sh/bun"
      "stackedpr/stacker" "tkhq/tap" "tuist/tuist" "majd/repo"
    ];
  };

  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
      AppleShowAllFiles = true;
      ShowStatusBar = true;
    };
  };

  # Set Git commit hash for darwin-version.
  # 'self' is not available here, so we remove this line or pass 'self' if needed.
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  # If you need the revision here, you'd pass 'self' into the module via specialArgs

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}