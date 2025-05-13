# nix
## Objective

Set up a server on Hetzner using Terraform.

### Server requirement:
- Initial Linux distribution: Ubuntu 22.04
- Configure the firewall to allow only the following open ports:
  - Port 22 for SSH
  - Ports 80 and 443 for HTTP and HTTPS

Use `nixos-anywhere` to install NixOS on the server with the provided NixOS configuration by using the flake feature.


## Setup

### Terraform
If you haven't set Nix to allow unfree packages, please do so by running the following command:

```bash
export NIXPKGS_ALLOW_UNFREE=1
```

To enter the shell with terraform run

```bash
nix-shell terraform-shell.nix 
```

You should enter a shell that looks like this

![Pic of terraform shell](pics/shell-terraform.png)
