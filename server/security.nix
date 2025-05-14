{ config, pkgs, ... }: {
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

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };
}
