{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "terraform-shell";

  buildInputs = [ pkgs.terraform ];

  shellHook = ''
    echo -e "\033[1;32m╔═════════════════╗\033[0m"
    echo -e "\033[1;32m║ Terraform Shell ║\033[0m"
    echo -e "\033[1;32m╚═════════════════╝\033[0m"
    version=$(terraform -version | head -n 1)
    echo -e "\033[1;32m$version\033[0m"
    echo -e "\033[1;32mYou can now run terraform commands! \033[0m" 
  '';

}
