{
user,
lib,
...
}:
{
	networking.networkmanager.enable = true;
	users.users."${user.name}" = {
		extraGroups = lib.mkAfter ["networkmanager"];
	};
}
