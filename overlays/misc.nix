_: prev: {
  ncmpcpp = prev.ncmpcpp.override {
    visualizerSupport = true;
    clockSupport = true;
  };

  cava = prev.cava.override {
    withSDL2 = true;
  };
}
