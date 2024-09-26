{pkgs, ...}: {
  xdg.mimeApps = {
    enable = true;
    # TODO: make this a module (this is impractical, i should make it more generic)
    defaultApplications = {
      "default-web-browser" = ["floorp.desktop"];
      "text/html" = ["floorp.desktop"];
      "x-scheme-handler/http" = ["floorp.desktop"];
      "x-scheme-handler/https" = ["floorp.desktop"];
      "x-scheme-handler/about" = ["floorp.desktop"];
      "x-scheme-handler/unknown" = ["floorp.desktop"];
      "application/pdf" = ["org.gnome.Evince.desktop"];
      "audio/wav" = ["rhythmbox"];
    };
  };
}
