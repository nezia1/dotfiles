{ hostname, username, ... }:

{
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";

  sops.secrets."syncthing/${hostname}/key" = { };
  sops.secrets."syncthing/${hostname}/cert" = { };
}
