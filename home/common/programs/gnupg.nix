_: {
  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ./nezia-public-key.asc;
        trust = 5;
      }
    ];
  };
}
