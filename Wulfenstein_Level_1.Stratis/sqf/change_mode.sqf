if (celo_color_mode == "BW") then {
	"colorCorrections" ppEffectEnable false;
	celo_color_mode = "";
} else {
	"colorCorrections" ppEffectEnable true;
	celo_color_mode = "BW";
};
celo_color_mode