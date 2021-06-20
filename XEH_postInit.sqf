#include "\a3\ui_f\hpp\defineDIKCodes.inc"

if (!hasInterface) exitWith {};

Headlamps_ExtraCompatibleHeadwear = [];

if (Headlamps_Settings_ExtraCompatibleItems != '') then {
    try {
        _parsedExtraItems = parseSimpleArray Headlamps_Settings_ExtraCompatibleItems;
        if ((count _parsedExtraItems) > 0) then {
            Headlamps_ExtraCompatibleHeadwear = Headlamps_ExtraCompatibleHeadwear + _parsedExtraItems;
        };
    } catch {
        diag_log text "Headlamps Error: failed to parse the CBA Extra Items setting.";
        diag_log text str _exception;
    };
};

["Headlamps", 'Vestarr_Headlamps_ToggleOnOff', 'Toggle Headlamp On/Off', {
    [player] call Headlamps_fnc_toggleHeadlampOnOff;
}, {false}, [DIK_N, [true, false, false]], false] call CBA_fnc_addKeybind;

["Headlamps", 'Vestarr_Headlamps_ToggleColor', 'Toggle Headlamp Color', {
    [player] call Headlamps_fnc_toggleHeadlampColor;
}, {false}, [DIK_N, [false, true, false]], false] call CBA_fnc_addKeybind;
