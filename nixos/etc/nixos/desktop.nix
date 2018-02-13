{ config, pkgs, ... }:

{
  imports =
    [
    ];

  system.stateVersion = "17.09";
  system.autoUpgrade.enable = true;

  # grouped by singlelinedness
  security.sudo.extraConfig = "Defaults timestamp_timeout=30";
  boot.blacklistedKernelModules = [ "pcspkr" ];
  time.timeZone = "Europe/Riga";

  nix.package = pkgs.nixUnstable;
  nix.useSandbox = false;
  nix.binaryCaches = [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
  nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

  users.mutableUsers = false;
  users.extraUsers.s = {
    isNormalUser = true;
    uid = 1000;
    shell = pkgs.zsh;
    hashedPassword = "$6$VTWtU4GA$jXBRhB3sp1Odvr19HWUONYRnKud0INAblKebEF//.TpZgvb5lZ9LRGUsjiQ52k6RMiiI9gnMkqODIn9XkN3Un1";
    extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" "cdrom" ];
  };

  networking = {
    firewall.allowedTCPPorts = [ 22 80 8000 8080 65353 ];
    networkmanager.enable = true;
  };

  environment.systemPackages = (import ./package-sets.nix { inherit pkgs; }).everything;
  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      #enablePepperFlash = true;
      enablePepperPDF = true;
      #enableWideVine = true;
    };
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  services = {
    openssh.enable = true;
    cron.enable = true;

    xserver = {
      enable = true;
      layout = "lv";

      synaptics.enable = true;
      synaptics.twoFingerScroll = true;
    };

    syncthing = {
      enable = true;
      useInotify = true;
      user = "s";
      dataDir = "/home/s/.syncthing";
    };
  };

  programs = {
    bash.enableCompletion = true;

    ssh.knownHosts = [
      { hostNames = ["github.com"]; publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=="; }
      { hostNames = ["bitbucket.org"]; publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw=="; }
    ];

    chromium = {
      enable = true;

      extensions = [
        "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
        "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "jlgkpaicikihijadgifklkbpdajbkhjo" # mouse gestures
      ];
    };
  };

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    support32Bit = true;
    daemon.config = {
      flat-volumes = "no";
    };
  };

  fonts = {
    fontconfig.enable = true;
    fonts = with pkgs; [
      dejavu_fonts
      liberation_ttf
      material-icons
      source-code-pro
      source-sans-pro
    ];
  };
}
