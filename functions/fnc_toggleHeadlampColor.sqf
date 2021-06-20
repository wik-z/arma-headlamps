params ['_unit'];

_curHeadlampObject = _unit getVariable ['Headlamps_LampObject', objNull];
if (isNull _curHeadlampObject) exitWith {};

_presetName = '';
if (!Headlamps_Settings_AllowAll) then {
	_presetName = _unit getVariable ['Headlamps_LampPreset', ''];
} else {
	_presetName = 'Headlamps_Preset_Full';
};

if (_presetName == '') exitWith {};

_preset = (configFile >> 'Headlamps_Presets' >> _presetName);
if (!isClass _preset) exitWith {};

// TODO: Spawning lamps also should be abstracted out
_colorCycle = getArray (_preset >> 'colorCycle');
_currentLampVariant = _unit getVariable ['Headlamps_LampVariant', ''];
if (_currentLampVariant == '') then {
	_currentLampVariant = _colorCycle select 0;
};

_offset = getArray (_preset >> 'offset');

if (count _colorCycle == 1) exitWith {};

_currentCycleIndex = _colorCycle find _currentLampVariant;
_nextIndex = (_currentCycleIndex + 1) mod (count _colorCycle);
_currentLampVariant = _colorCycle select _nextIndex;

detach _curHeadlampObject;
deleteVehicle _curHeadlampObject;

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
