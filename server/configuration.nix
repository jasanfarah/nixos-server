{ modulesPath, lib, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./firewall.nix
    ./security.nix
    ./docker.nix
    ./reverse-proxy.nix
  ];

  disko.devices = import ./filesystem.nix "/dev/sda";

  boot.loader.grub = {
    devices = [ "/dev/sda" ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [ curl wget git clamav neovim btop ];

  networking.hostName = "server";

  system.stateVersion = "24.11";

}
