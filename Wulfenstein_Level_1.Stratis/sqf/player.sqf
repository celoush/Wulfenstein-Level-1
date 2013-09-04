private["_create_doors"];

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

_create_doors = {
	_unit = [ _this, 0, objNull, [objNull] ] call BIS_fnc_param;
	_unit disableCollisionWith secretDoor1;
	_unit disableCollisionWith secretDoor2;
};

addMissionEventHandler ["loaded",{[player] call _create_doors}];
[player] call _create_doors;


["Enemy base", "Try survive and escape"] call BIS_fnc_infoText;