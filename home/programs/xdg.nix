{config, ...}: {
  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps = {
      enable = true;
      defaultApplications = {
        "default-web-browser" = ["firefox.desktop"];
        "text/html" = ["firefox.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];
        "x-scheme-handler/about" = ["firefox.desktop"];
        "x-scheme-handler/unknown" = ["firefox.desktop"];
        "x-scheme-handler/chrome" = ["chromium-browser.desktop"];
        "inode/directory" = ["yazi.desktop"];
        "image/png" = ["org.gnome.Loupe.desktop"];
        "image/svg" = [" org.gnome.Loupe.desktop"];
        "image/jpeg" = ["org.gnome.Loupe.desktop"];
        "image/gif" = [" org.gnome.Loupe.desktop"];
      };
    };
  };
}