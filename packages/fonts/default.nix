{
	pkgs,
	...
}:
{
	fonts.fonts = with pkgs; [
		(nerdfonts.override {fonts = ["FiraCode"];})
		ankacoder
		material-icons
		texlivePackages.typicons
	];
}
