{ modulesPath, lib, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  disko.devices = import ./filesystem.nix "/dev/sda";

    boot.loader.grub = {
    devices = [ "/dev/sda" ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    curl
    wget
    git
    clamav
    lynis

    neovim
    btop
  ];

  security = {
    auditd.enable = true;
    audit.enable = true;
    audit.rules = [ "-a exit,always -F arch=b64 -S execve" ];
    rtkit.enable = true;
    polkit.enable = true;
    protectKernelImage = true;
    allowUserNamespaces = true;
    unprivilegedUsernsClone = true;
  };

  networking.hostName = "root";

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "24h";
    ignoreIP = [ "127.0.0.1" ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
    logRefusedConnections = true;
    logRefusedPackets = true;
    logRefusedUnicastsOnly = true;
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFxD282w2u0D0S7vuUYSt1q4g8o+WQM3RO3GQ+V4iU0jLp+QaVdTEwyWQO48hgsd2fket9JHukLWK49bCj4hZM/PVpxssXw0XYLszCfv8uFRkwxNeOTJ34wyC9CPMOxJNk5piQD1lXYzlcX+P5jcODefhf1msyVZGHM7HKSSnsnFF/XSKLRa/OiI+SwlHbCRx+w7vTwmdvay57Yyc3AeuO57zkqaPwNnSk3GqAcDVSfkzFj3MMLNP6HVz+jUGyBqIV0iAmqU9IUPcS59ZmSavRvjY/SBuHfDVuwAIEHBua9VqovQ7h6E4PfGidGJUhpSK2PZE+ahBrxkYWfDaSxK6rKPICFUiyqPmdrWoZmhG+3WNKPwpIwvS7B7gKzlADaqLb2BlM3mhHdnhH+MMnqGTdrKcBjUpAaSqHq4lCtdmr80KQE+suQ0LzrMn6XiPdov9BkhkUrn1BMv3vFViFjGxLfAau3lrQGw9P4yKAyRigXWBnIpBAg1iMUBFkk9YvspEHGhx3sN9lh12yxPOYYSBho9VmudnRQH6ObcO9Ra/oZDSPyIqfkXIu94WmutulaUFOOT7Y2rf3mPn03NeQjeFnS/nLKTzEoqFyVBcmYKbg0GdGDtDYr2WBpZQQyxGXiQ1T6qwPDhJ8jIK1ltQmL1rHLTxiKiGkh1BMBVRETgy0mw== j@nixos"
  ];

  system.stateVersion = "24.11";

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };
}
