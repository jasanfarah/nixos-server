# nixos-server
## Objective

Set up a server on Hetzner using Terraform.

### Server requirement:
- Initial Linux distribution: Ubuntu 24.04
- Configure the firewall to allow only the following open ports:
  - Port 22 for SSH
  - Ports 80 and 443 for HTTP and HTTPS

Use `nixos-anywhere` to install NixOS on the server with the provided NixOS configuration by using the flake feature.


## Setup

### 1. SSH key

First, we need to ensure that we have a public SSH key to provide to Terraform. This will ensure that only we (or those with the corresponding private key) can access our server.

You can create an SSH key pair using the following command, which will generate `server.pub` (public key) and `server` (private key):

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/server
```
If you use a different name or already have an SSH key, please update [server.tf](terraform/server.tf) to reflect the correct key name.



### 2. Terraform
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

#### Deploy server
First, make sure you have an API key for Hetzner. Read more [here](https://docs.hetzner.com/cloud/api/getting-started/generating-api-token/) on how to set one up


To deploy the server change directory to terraform

```bash
cd terraform
```

To see the planned deployment, run

```bash
terraform plan
```

You can now deploy a server by running 
```bash
terraform apply
```

The output should include the IPv4 adress of our newly created server like this

![Pic of terraform deployment](pics/output-terraform.png)

You can try to SSH to the server by running
```bash
ssh root@your-ipv4-adress
```


**Tip 1:** If you are tired of typing in the Hetzner API key, you can create a file named `terraform.tfvars` with your API credentials.

**Example:**

```terraform
hetzner_api_key = "your-api-key"
```

**Tip 2:** If you want to delete the deployment run 
```bash
terraform destroy
```

### 3. NixOS prep
As NixOS only remembers whats in the configuration. That also means that if we dont include our public key in the configuration then we cant really access the server anymore.

To keep things simple we wont really use any tools for managing secrets like [sops](https://github.com/getsops/sops), [age](https://github.com/FiloSottile/age) or  [agenix](https://github.com/ryantm/agenix), but you should know their value. 

To prepare our server and restrict SSH access to only us, please manually add your public ssh key in the [filewall](server/firewall.nix) configuration.
### 4. NixOS setup

```bash
nix run github:nix-community/nixos-anywhere -- --flake .#server --target-host root@your-ipv4-adress
```


### 5. NixOS deploy changes (Requires running NixOS)
```bash
nixos-rebuild switch --flake .#server --target-host root@your-ipv4-adress
```

Thoughts: 
* Maybe setup bastion host which runs nixos to be able to run the command? 
* Provide example of pull based approach and push based??
* Learn more about morph and Colmena


TODO:
* Disable ssh for root, add another user
* Add docker as non root
* Persistence
* More hardening

