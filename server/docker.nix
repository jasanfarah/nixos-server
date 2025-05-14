{ config, pkgs, ... }: {
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  users.users.grug = {
    isNormalUser = true;
    description = "A Grugbrained user named grug";
    extraGroups = [ "networkmanager" "wheel" ];
    subUidRanges = [{
      startUid = 100000;
      count = 65536;
    }];
    subGidRanges = [{
      startGid = 100000;
      count = 65536;
    }];
  };
}
