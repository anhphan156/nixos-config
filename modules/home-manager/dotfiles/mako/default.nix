{lib, ...}: {
  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      borderRadius = 12;
      borderSize = 2;
      borderColor = lib.mkDefault "#ce3454aa";
      backgroundColor = lib.mkDefault "#222222ff";
      progressColor = lib.mkDefault "over #ce3454aa";
      font = "AnkaCoder 10";
    };
  };
}
