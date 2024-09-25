{
  hostname,
  username,
  ...
}: {
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";

    secrets."syncthing/${hostname}/key" = {};
    secrets."syncthing/${hostname}/cert" = {};
  };
}
