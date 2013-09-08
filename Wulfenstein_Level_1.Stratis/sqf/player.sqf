player setIdentity "Wulfenstein";

removeAllWeapons player;
removeHeadgear player;
removeVest player;
removeBackPack player;

player addmagazine "30Rnd_9x21_Mag";
player addWeapon "hgun_Rook40_F";
player addmagazine "30Rnd_9x21_Mag";
player addmagazine "30Rnd_9x21_Mag";
player addWeapon "ItemCompass";

player unassignItem "NVGoggles";
player removeItem "NVGoggles";
player unassignItem "ItemMap";
player removeItem "ItemMap";
player unassignItem "ItemRadio";
player removeItem "ItemRadio";
player unassignItem "ItemCompass";
player removeItem "ItemCompass";
player unassignItem "ItemWatch";
player removeItem "ItemWatch";

celo_secret_doors = [secretDoor1,secretDoor2];
celo_init_secret_doors = {
	_unit = [ _this, 0, objNull, [objNull] ] call BIS_fnc_param;
	_doors = [ _this, 1, [], [[]] ] call BIS_fnc_param;
	{_unit disableCollisionWith _x} foreach _doors;
};

addMissionEventHandler ["loaded",{[player,celo_secret_doors] call celo_init_secret_doors}];
[player,celo_secret_doors] call celo_init_secret_doors;

0 spawn {
	sleep 0.5;
	_text = format [("<t align = 'center'>Enemy base<br />Try survive and escape")];
	[parseText _text, [safeZoneX + safeZoneW - 0.35 - 0.025, safeZoneY + safeZoneH - 0.25 - 0.05, 0.35, 0.10], [10, 3]] spawn BIS_fnc_textTiles;
};