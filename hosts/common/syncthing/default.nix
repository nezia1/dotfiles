{
  config,
  username,
  hostname,
  ...
}:

let
  homeDir = "/home/${username}";
  devices = import ./devices.nix;
  otherDevices = builtins.removeAttrs devices [ hostname ];
in
{
  services = {
    syncthing = {
      enable = true;
      user = "${username}";
      dataDir = "${homeDir}/Documents";
      configDir = "${homeDir}/.config/syncthing"; # Folder for Syncthing's settings and keys
      key = "${config.sops.secrets."syncthing/${hostname}/key".path}";
      cert = "${config.sops.secrets."syncthing/${hostname}/cert".path}";
      settings = {
        devices = otherDevices;
        folders = {
          "Documents" = {
            path = "${homeDir}/Documents";
            devices = builtins.attrNames otherDevices;
          };
          "Pictures" = {
            path = "${homeDir}/Pictures";
            devices = builtins.attrNames otherDevices;
          };
          "Music" = {
            path = "${homeDir}/Music";
            devices = builtins.attrNames otherDevices;
          };
          "Videos" = {
            path = "${homeDir}/Videos";
            devices = builtins.attrNames otherDevices;
          };
          "Projects" = {
            path = "${homeDir}/Projects";
            devices = builtins.attrNames otherDevices;
          };
          "Notes" = {
            path = "${homeDir}/Notes";
            devices = builtins.attrNames otherDevices;
          };
        };
      };
    };
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
}
