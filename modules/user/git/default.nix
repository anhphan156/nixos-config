{
	user,
	...
}:
{
	home-manager.users."${user.name}" = {
		programs.git = {
			enable = true;
			userName = user.git_name;
			userEmail = user.git_email;
		};
	};
}
