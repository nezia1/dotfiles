{ pkgs, hostname, username, lib, ... }: {
  networking.hostName = hostname; 
  boot = {
    loader = {
      timeout = 0;
      systemd-boot = {
        enable = true;
        consoleMode = "2";
      };
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      extraConfig = ''
      [Daemon]
      DeviceScale=2
      '';
    };
    consoleLogLevel = 0;
    initrd.systemd.enable = true;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_CH.UTF-8";
    LC_IDENTIFICATION = "fr_CH.UTF-8";
    LC_MEASUREMENT = "fr_CH.UTF-8";
    LC_MONETARY = "fr_CH.UTF-8";
    LC_NAME = "fr_CH.UTF-8";
    LC_NUMERIC = "fr_CH.UTF-8";
    LC_PAPER = "fr_CH.UTF-8";
    LC_TELEPHONE = "fr_CH.UTF-8";
    LC_TIME = "fr_CH.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nezia = {
    isNormalUser = true;
    description = "Anthony Rodriguez";
    extraGroups = [ "networkmanager" "wheel" ];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
    curl
    tree
    python3
    lm_sensors
  ];

  # fix direnv integration with fish
  environment.pathsToLink = [ "/share/fish" ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };


  # setup printing service
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing.drivers = [ pkgs.gutenprint pkgs.hplip ];

  hardware.sane.enable = true; # enables support for SANE scanners
  hardware.sane.extraBackends = [ 
    pkgs.sane-airscan     # generic
    pkgs.hplip            # HP
    pkgs.epkowa           # Epson
    pkgs.utsushi          # other printers
  ];
  services.udev.packages = [ pkgs.sane-airscan pkgs.utsushi ];

  services.udisks2.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  environment.sessionVariables = {
    FLAKE = "/home/${username}/.dotfiles";
  };

  # Enable all packages
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
