params ['_unit'];

// if it's already on, remove it and disable it
_curHeadlampObject = _unit getVariable ['Headlamps_LampObject', objNull];
if (!(isNull _curHeadlampObject)) then {
	_unit setVariable ['Headlamps_LampObject', objNull, true];
	detach _curHeadlampObject;
	deleteVehicle _curHeadlampObject;
} else {
	_headwearHeadlampPresetName = '';
	if (!Headlamps_Settings_AllowAll) then {
		_currentHeadwear = headgear _unit;
		_headwearHeadlampPresetName = [configFile >> 'CfgWeapons' >> _currentHeadwear, 'Headlamps_Preset', ''] call BIS_fnc_returnConfigEntry;
		
		// not found in the class? perhaps it can be found in the "mission-level" extension array...
		if (_headwearHeadlampPresetName == '') then {
			_foundIndex = Headlamps_ExtraCompatibleHeadwear findIf { (_x select 0) == _currentHeadwear };
			if (_foundIndex != -1) then {
				_headwearHeadlampPresetName = (Headlamps_ExtraCompatibleHeadwear select _foundIndex) select 1;
			};
		};
	} else {
		_headwearHeadlampPresetName = 'Headlamps_Preset_Full';
	};

	if (_headwearHeadlampPresetName == '') exitWith {};

	_preset = (configFile >> 'Headlamps_Presets' >> _headwearHeadlampPresetName);
	if (!(isClass _preset)) exitWith {};

	_colorCycle = getArray (_preset >> 'colorCycle');
	_currentLampVariant = _unit getVariable ['Headlamps_LampVariant', ''];
	if (_currentLampVariant == '') then {
		_currentLampVariant = _colorCycle select 0;
	};

	_offset = getArray (_preset >> 'offset');

	_curHeadlampObject = createVehicle [_currentLampVariant, [0,0,0], [], 0, 'CAN_COLLIDE'];

	// TODO: put it into a separate function
	if (isMultiplayer) then {
		// make it local to the unit
		[[_unit, _curHeadlampObject], {
			params ['_unit', '_headlamp'];
			_headlamp setOwner (owner _unit);
		}] remoteExec ['call', 2];
	};

	_curHeadlampObject setVectorDir (eyeDirection _unit);
	_curHeadlampObject attachTo [_unit, _offset, 'Head', true];

	_unit setVariable ['Headlamps_LampObject', _curHeadlampObject, true];
	_unit setVariable ['Headlamps_LampVariant', _currentLampVariant, true];
	_unit setVariable ['Headlamps_LampPreset', _headwearHeadlampPresetName, true];
}

