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
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/disk/by-id/ata-Samsung_SSD_860_PRO_256GB_S45GNF0K219130E"; # or "nodev" for efi only

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp5s0.useDHCP = true;
  #networking.interfaces.wlp1s0.useDHCP = true;
  networking.enableIPv6 = false;
  networking.hosts = {
    "127.0.0.1" = [ "local" "localhost" "schopenhauer" "nixos" ];
  };

  networking.hostId = "6eb9ae74";
  networking.resolvconf.useLocalResolver = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  i18n.inputMethod.enabled = "fcitx";
  i18n.inputMethod.fcitx.engines = with pkgs.fcitx-engines; [ anthy hangul libpinyin ];

  fonts.fonts = with pkgs; [
    carlito
    dejavu_fonts
    google-fonts
    ipafont
    kochi-substitute
    roboto
    roboto-mono
    source-code-pro
    ttf_bitstream_vera
  ];

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  nixpkgs.config.allowUnfree = true;

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
    chromiumDev
    clang_10
    clisp
    clojure
    cmake
    cointop
    coq
    dfc
    discord
    doas
    docker
    elmPackages.elm
    emacs
    fcitx
    fcitx-engines.anthy
    fcitx-engines.hangul
    fcitx-engines.libpinyin
    fd
    feh
    file
    fish
    fortune
    gcc10
    gforth
    gimp
    git
    go
    googleearth
    googler
    graphviz
    gzip
    hakuneko
    hashcat
    hashcat-utils
    htop
    hy
    idris
    inkscape
    jemalloc
    jetbrains.idea-community
    jq
    jre8_headless
    leiningen
    libzip
    linux.dev
    linuxPackages.zfs
    lld_10
    lldb_10
    llvm
    lua5_3
    luajit
    lz4
    lzma
    lzo
    lzop
    mariadb
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
    protobuf3_11
    pxz
    python38
    python38Packages.pip
    python38Packages.pkgconfig
    python38Packages.unicorn
    python38Packages.virtualenv
    qbittorrent
    qbittorrent-nox
    qtpass
    racket
    radeontop
    rc
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
    xorg.xcbutil
    xorg.xev
    xorg.xinput
    xorg.xkill
    xorg.xrandr
    yarn
    yasm
    ytop
    zfs
    zip
    zlib
    zmap
    zopfli
    zpaq
    zstd
  ];

  # Env system-wide settings
  environment.variables.QT_IM_MODULE = "fcitx";
  environment.variables.GTK_IM_MODULE = "fcitx";
  environment.variables."XMODIFIERS DEFAULT" = "@im=fcitx";
  environment.variables."XMODIFIER DEFAULT" = "@im=fcitx";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.postgresql.enable = true;
  services.bind.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  #networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.videoDrivers = [ "radeon" ];

  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sguzman = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
  system.autoUpgrade.enable = false;
  system.autoUpgrade.allowReboot = false;

}

