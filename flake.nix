{
  description = "mkhoatd Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, ... }: {
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
      fonts.packages = [
        # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
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
          "nushell"
          "eza"
          "go"
          "dlv"
          "rust"
          "mas"
          "opam"
          "hg"
          "darcs"
          "bun"
          "aria2"
          "fish"
          "carapace"
          "ffmpeg"
          "direnv"
          "terraform"
          "typst"
          "ncdu"
          "ninja"
          "turnkey"
          "neovim"
          "uv"
          "yt-dlp"
          "ipatool"
        ];
        casks = [
          "neovide"
          "1password-cli"
          "git-credential-manager"
          "steamcmd"
          "miniforge"
          "adguard"
          "applite"
          "arc"
          "cloudflare-warp"
          "discord"
          "firefox"
          "flowvision"
          "flutter"
          "google-chrome"
          "iina"
          "iterm2"
          "karabiner-elements"
          "kodi"
          "jetbrains-toolbox"
          "lookaway"
          "messenger"
          "microsoft-auto-update"
          "microsoft-remote-desktop"
          "microsoft-teams"
          "motrix"
          "mountain-duck"
          "netnewswire"
          "notion"
          "obs"
          "obsidian"
          "orbstack"
          "orion"
          "postman"
          "qq"
          "rapidapi"
          "cursor"
          "visual-studio-code"
          "raycast"
          "sf-symbols"
          "slack"
          "steam"
          "transmission"
          "wezterm@nightly"
          "zalo"
          "zed"
          "zoom"
          "cursor"
          "logi-options+"
          "ghostty"
          "tuist"
        ];


        taps = [
          "bufbuild/buf"
          "codecrafters-io/tap"
          "felixkratz/formulae"
          "homebrew/autoupdate"
          "homebrew/bundle"
          "homebrew/services"
          "mistertea/et"
          "netdcy/flowvision"
          "nikitabobko/tap"
          "oven-sh/bun"
          "stackedpr/stacker"
          "tkhq/tap"
          "tuist/tuist"
          "majd/repo"
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
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild switch --flake .#simple
    darwinConfigurations."mackhoa" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "mkhoatd";
            autoMigrate = true;
          };

        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mackhoa".pkgs;
  };
}
