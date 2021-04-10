# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_5_4;
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  #networking.useDHCP = false;
  networking.interfaces.enp7s0.useDHCP = true;
  networking.enableIPv6 = false;
  networking.hosts = {
    "127.0.0.1" = [ "local" "localhost" "schopenhauer" "nixos" "hub" ];
  };

  networking.hostId = "6eb9ae74";
  networking.resolvconf.useLocalResolver = true;

  networking.hostName = "hub"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME 3 Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  
  services.xserver.videoDrivers = [ "nvidia" ];
  
  virtualisation.docker.enable = true;
  

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sguzman = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    amass
    anki
    ant
    aria
    audacity
    biber
    bind
    binutils
    blender
    bonnie
    brotli
    btfs
    bzip2
    capstone
    cayley
    clang_10
    clisp
    clojure
    cmake
    cointop
    coq
    darcs
    dfc
    discord
    doas
    docker
    elmPackages.elm
    fd
    feh
    file
    fish
    fortune
    gcc10
    gforth
    git
    go
    google-chrome
    googler
    graphviz
    gzip
    hakuneko
    hashcat
    hashcat-utils
    htop
    hy
    idris
    jemalloc
    jetbrains.jdk
    jetbrains.clion
    jetbrains.webstorm
    jetbrains.datagrip
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jq
    jre8_headless
    kotlin
    kubernetes
    lean2
    leiningen
    libzip
    linux.dev
    lld_11
    lldb_11
    llvm_11
    lua5_3
    luajit
    lz4
    lzma
    lzo
    lzop
    mariadb
    mathematica
    maven
    minecraft
    mpv
    mtm
    mupdf
    musl
    mycli
    nasm
    neovim
    nerdfonts
    newsboat
    nmap
    nodejs-13_x
    openarena
    openjdk8_headless
    openssh
    openssl
    openssl.dev
    pagemon
    parallel-rust
    pass
    pbzip2
    pgcli
    pigz
    pijul
    pipenv
    pkg-config
    ponysay
    postgresql_12
    pprof
    protobuf3_11
    pv
    pxz
    python39Full
    qbittorrent
    qbittorrent-nox
    qtpass
    racket
    radeontop
    rc
    red
    redshift
    rofi
    rofi-pass
    runelite
    rustup
    sccache
    screenfetch
    silver-searcher
    skim
    snappy
    sqlite
    sqlmap
    stack
    taskwarrior
    texlive.combined.scheme-full
    texstudio
    tmux
    translate-shell
    unicorn-emu
    unrar
    unzip
    visualvm
    vlc
    w3m
    wabt
    wasmer
    wasmtime
    watchexec
    wget
    wine
    xorg.xcbutil
    xorg.xev
    xorg.xinput
    xorg.xkill
    xorg.xrandr
    yarn
    yasm
    youtube-dl
    ytcc
    ytop
    zfs
    zip
    zlib
    zmap
    zopfli
    zpaq
    zstd
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.bind.enable = true;
  
  services.kubernetes.enable = true;
  services.kubernetes = {
    apiserver.enable = true;
    controllerManager.enable = true;
    scheduler.enable = true;
    addonManager.enable = true;
    proxy.enable = true;
    flannel.enable = true;
    dashboard.enable = true;
  };
  
  services.kubernetes.roles = [ "master" "node" ];

  services.kubernetes.apiserver.insecureBindAddress = "127.0.0.1";
  services.kubernetes.apiserver.insecurePort = 8080;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
  system.autoUpgrade.enable = false;
  system.autoUpgrade.allowReboot = false;

}

