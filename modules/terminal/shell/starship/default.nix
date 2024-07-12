{
	user,
	lib,
	...
}:{
	home-manager.users."${user.name}" = {
		programs.starship = {
			enable = true;
			enableZshIntegration = true;
			settings = {
				add_newline = false;
				scan_timeout = 10;
				right_format = lib.concatStrings [
					"$c$rust$nix_shell$os"
				];
				format = lib.concatStrings [
					"$character $directory$git_branch$git_status"
				];
				character = {
					success_symbol = "[↪](bold green)";
					error_symbol = "[↪](bold red)";
				};
				hostname = {
					ssh_only = false;
					format = lib.concatStrings [
						"[$hostname](bold green)"
					];
				};
				username = {
					show_always = true;
					format = "[$user](bold green)";
				};
				os = {
					disabled = false;
				};
			};
		};
	};
}
