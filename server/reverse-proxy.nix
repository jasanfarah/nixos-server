{ config, pkgs, ... }: {

  services.caddy = {
    enable = true;
    virtualHosts.":80" = {
      extraConfig = ''
        root * /var/www/html
        file_server
      '';
    };
  };

  #Note: this script basically creates the directory and the html that the reverse proxy points to
  system.activationScripts = {
    createWebDir = {
      text = ''
        mkdir -p /var/www/html
        echo "<html><body><h1>Hello from NixOS❄️</h1></body></html>" > /var/www/html/index.html
        chmod -R 755 /var/www/html
      '';
      deps = [ ];
    };
  };
}
