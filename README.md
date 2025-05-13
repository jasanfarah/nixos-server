# nix
## Objective

Set up a server on Hetzner using Terraform.

### Server requirement:
- Initial Linux distribution: Ubuntu 22.04
- Configure the firewall to allow only the following open ports:
  - Port 22 for SSH
  - Ports 80 and 443 for HTTP and HTTPS

Use `nixos-anywhere` to install NixOS on the server with the provided NixOS configuration by using the flake feature.

