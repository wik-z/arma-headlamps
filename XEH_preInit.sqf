[
    'Headlamps_Settings_AllowAll',
    'CHECKBOX',
    ['Allow headlamps on all headgear?', 'Check if the players should be able to use the headlamps regardless of the headgear they are using'],
	'Headlamps',
    false
] call CBA_fnc_addSetting;

[
    'Headlamps_Settings_ExtraCompatibleItems',
    'EDITBOX',
    ['Extra compatible headwear', 'You can specify additional compatible headwear here as an array of tuples in the right format: [<CLASSNAME>, <PRESET>] divided by a comma'],
    'Headlamps',
    '[]'
] call CBA_fnc_addSetting;