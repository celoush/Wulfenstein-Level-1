["_units_sekce1","_units_sekce2","_units_sekce3","_units_sekce4","_null","_wp","_units_sekce","_max_add_skill"];

_units_sekce1 = [];
_units_sekce2 = [];
_units_sekce3 = [];
_units_sekce4 = [];

for "_sekce" from 1 to 4 do {
	_units_sekce = call compile format ["_units_sekce%1",_sekce];
	for "_i" from 1 to 17 do {
		if (!isNil format["sekce%1_%2",_sekce,_i]) then {
			_units_sekce set [count _units_sekce,call compile format["sekce%1_%2",_sekce,_i]];
		};
	};
};
_units_sekce4 set [count _units_sekce4,sekce4_gunner];

{_x setUnitPos "UP"} forEach _units_sekce1;
{_x setUnitPos "MIDDLE"} forEach _units_sekce2;
{_x setUnitPos "MIDDLE"} forEach _units_sekce3;
{_x setUnitPos "MIDDLE"} forEach _units_sekce4;

_null = 0 execVM "sqf\player.sqf";

{
	_x setcombatmode "RED";
	_x setskill ["general",1];
	_x setskill ["aimingShake",0.3];
	_max_add_skill = 0.2;
	if (_x in _units_sekce2) then {_max_add_skill = 0.3;};
	if (_x in _units_sekce3) then {_max_add_skill = 0.4;};
	if (_x in _units_sekce4) then {_max_add_skill = 0.5;};
	_x setskill ["aimingAccuracy",0.1 + random _max_add_skill];
	_x setskill ["aimingSpeed",0.2+random 0.4];
	
	group _x setBehaviour "COMBAT";
	if ((_x in (_units_sekce2+_units_sekce3)) and random 1 > 0.8) then {
		_wp = group _x addwaypoint [[position _x select 0,position _x select 1],0];
		_wp setwaypointtype "GUARD";
		_wp setwaypointcompletionradius 0;
		_wp setwaypointspeed "FULL";
		_wp setwaypointbehaviour "COMBAT";
	} else {
		_x disableAI "MOVE";
	};

	_x unassignItem "NVGoggles";
	_x removeItem "NVGoggles";
	_x unassignItem "NVGoggles_INDEP";
	_x removeItem "NVGoggles_INDEP";	
	_x unassignItem "ItemMap";
	_x removeItem "ItemMap";
	_x unassignItem "ItemRadio";
	_x removeItem "ItemRadio";
	_x unassignItem "ItemCompass";
	_x removeItem "ItemCompass";
	_x unassignItem "ItemWatch";
	_x removeItem "ItemWatch";

	removeAllWeapons _x;
	removeAllItems _x;
	removeHeadgear _x;
	removeVest _x;
	removeBackPack _x;


	if (_x in _units_sekce1) then {
		_x addmagazine "30Rnd_9x21_Mag";
		_x addWeapon "hgun_Rook40_F";
		_x addmagazine "30Rnd_9x21_Mag";
	};

	if (_x in _units_sekce2) then {
		_x addmagazine "30Rnd_556x45_Stanag";
		_x addWeapon "arifle_SDAR_F";
		_x addmagazine "30Rnd_556x45_Stanag";
	};

	if (_x in _units_sekce3) then {
		_x addVest "V_TacVest_oli";
		_x addmagazine "30Rnd_9x21_Mag";
		_x addWeapon "SMG_02_F";
		_x addmagazine "30Rnd_9x21_Mag";
		if (random 1 > 0.5) then {
			_x addmagazine "30Rnd_9x21_Mag";
		};
	};

	if (random 1 > 0.9) then {
		_x addItem "FirstAidKit";
	};

	if (_x in _units_sekce4) then {
		_x addmagazine "150Rnd_762x51_Box";
		_x addWeapon "LMG_Zafir_F";
		_x addmagazine "150Rnd_762x51_Box";
		_x addVest "V_TacVest_oli";
	};

	[_x,_units_sekce1] spawn {
		_unit = _this select 0;
		_units = _this select 1;
		waitUntil {sleep 0.5;_unit knowsAbout player > 1.49};
		_unit reveal [player,2.5];
		waitUntil {sleep 0.5;_unit knowsAbout player > 3};
		_unit doTarget player;
		_unit doFire player;
		if (_unit in _units) then {
			sleep 1.5 + random 1.5;
		};
		_unit enableAI "MOVE";
		_wp = group _unit addwaypoint [[position player select 0,position player select 1],0];
		_wp setwaypointtype "DESTROY";
		_wp setwaypointcompletionradius 0;
		_wp setwaypointspeed "FULL";
		_wp setwaypointbehaviour "COMBAT";


	};

} forEach _units_sekce1 + _units_sekce2 + _units_sekce3 + _units_sekce4;

0 spawn {

	clearMagazineCargo sekce1_ammo1;
	clearWeaponCargo sekce1_ammo1;
	clearMagazineCargo sekce1_ammo2;
	clearWeaponCargo sekce1_ammo2;
	clearMagazineCargo sekce1_ammo3;
	clearWeaponCargo sekce1_ammo3;

	sekce1_ammo1 addMagazineCargo ["30Rnd_556x45_Stanag",1];
	sekce1_ammo1 addMagazineCargo ["30Rnd_9x21_Mag",1];
	sekce1_ammo2 addMagazineCargo ["30Rnd_9x21_Mag",2];
	sekce1_ammo3 addMagazineCargo ["30Rnd_556x45_Stanag",2];

	sekce1_ammo1 addItemCargo ["FirstAidKit",1];
	sekce1_ammo1 addItemCargo ["optic_Hamr",1];
	sekce1_ammo1 addItemCargo ["optic_ACO_grn",1];
	sekce1_ammo2 additemCargo ["V_Rangemaster_belt",1];
	sekce1_ammo2 addItemCargo ["optic_tws_mg",1];
	sekce1_ammo3 addItemCargo ["FirstAidKit",1];	

};

0 spawn {
	
	clearMagazineCargo sekce2_ammo1;
	clearWeaponCargo sekce2_ammo1;
	sekce2_ammo1 addWeaponCargo ["launch_NLAW_F",1];

	sekce2_backpack1 addMagazineCargo ["MiniGrenade",1];
};

0 spawn {

	clearMagazineCargo sekce3_ammo1;
	clearWeaponCargo sekce3_ammo1;
	sekce3_ammo1 addMagazineCargo ["NLAW_F",1];

	clearMagazineCargo sekce3_ammo2;
	clearWeaponCargo sekce3_ammo2;
	//sekce3_ammo2 additemCargo ["V_HarnessO_gry",1];
	sekce3_ammo2 addMagazineCargo ["30Rnd_9x21_Mag",3];
	sekce3_ammo2 addMagazineCargo ["NLAW_F",1];

	sekce3_ammo2 addItemCargo ["FirstAidKit",1];

	sekce3_backpack1 addMagazineCargo ["MiniGrenade",1];

};

0 spawn {

 	titlecut ["","BLACK IN",5];

 	celo_color_mode = "BW"; 	

 	"colorCorrections" ppEffectAdjust [1, 1.04, -0.004, [0.5, 0.5, 0.5, 0.0], [0.5, 0.5, 0.5, 0.0],  [0.5, 0.5, 0.5, 0.0]]; 
	"colorCorrections" ppEffectCommit 0;    
	"colorCorrections" ppEffectEnable true;
};