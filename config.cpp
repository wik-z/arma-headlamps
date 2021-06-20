class CfgPatches {
    class Vestarr_Headlamps {
        author="Vestarr";
        versionStr = "0.2";
        name="Headlamps";
        units[] = {};
        requiredVersion = 2;
        requiredAddons[] = {};
    }
}


class Extended_PostInit_EventHandlers {
    class Vestarr_Headlamps {
        init = "call compile preprocessFileLineNumbers '\Vestarr_Headlamps\XEH_postInit.sqf'";
    };
};

class Extended_PreInit_EventHandlers {
    class Vestarr_Headlamps {
        init = "call compile preprocessFileLineNumbers '\Vestarr_Headlamps\XEH_preInit.sqf'";
    };
};


class CfgVehicles {
    class Lamps_base_F;
	class Headlamp_light_white_low: Lamps_base_F
	{
		scope=1;
		scopeCurator=1;
		displayName="Headlamp Light Object";
        model="Vestarr_Headlamps\data\models\Light.p3d";

		class Hitpoints {};
		class AnimationSources {};
		class Reflectors
		{
			class Light_1
			{
				color[]={180,156,120};
				ambient[]={0.89,0.78,0.6};
				intensity=8;
				size=1;
				innerAngle=45;
				outerAngle=85;
				coneFadeCoef=5;
				position="Light_1_pos";
				direction="Light_1_dir";
				hitpoint="";
				selection="";
				useFlare=1;
				flareSize=0.4;
				flareMaxDistance=150;
				class Attenuation
				{
					start=0.5;
					constant=0;
					linear=0;
					quadratic=1;
					hardLimitStart=45;
					hardLimitEnd=60;
				};
			};
		};
	};

    class Headlamp_light_red_low: Headlamp_light_white_low
    {
        class Reflectors: Reflectors 
        {
            class Light_1: Light_1
            {
                color[]={255,10,10};
                intensity=6.8;

                class Attenuation: Attenuation
                {
                    hardLimitStart=38;
                    hardLimitEnd=54;
                };
            };
        };
    };
    
    class Headlamp_light_blue_low: Headlamp_light_red_low
    {
        class Reflectors: Reflectors 
        {
            class Light_1: Light_1
            {
                color[]={10,10,255};
            };
        };
    };
};


class CfgFunctions
{
    class Headlamps
    {
        class Core 
        {
            class toggleHeadlampOnOff
            {
                file = "\Vestarr_Headlamps\functions\fnc_toggleHeadlampOnOff.sqf";
            };

            class toggleHeadlampColor
            {
                file = "\Vestarr_Headlamps\functions\fnc_toggleHeadlampColor.sqf";
            };
        };
    };
};



class Headlamps_Presets
{
    class Headlamps_Preset_Full
    {
        offset[] = {-0.5,0.06,0.13}; // Pretty much middle of the forehead
        colorCycle[] = {
            Headlamp_light_white_low, 
            Headlamp_light_red_low, 
            Headlamp_light_blue_low
        };
    };

    class Headlamps_Preset_Helmet_Surefire_HL1_Right: Headlamps_Preset_Full
    {
        offset[] = {0.04,0,0.15};
    };

    class Headlamps_Preset_Helmet_Surefire_HL1_Left: Headlamps_Preset_Helmet_Surefire_HL1_Right
    {
        offset[] = {-0.185,-0.08,0.09};
    };

    class Headlamps_Preset_Helmet_Surefire_HL1_Left_ARC: Headlamps_Preset_Helmet_Surefire_HL1_Left
    {
        offset[] = {-0.185,-0.08,0.15};
    };

    class Headlamps_Preset_Helmet_Surefire_HL1_Right_ARC: Headlamps_Preset_Helmet_Surefire_HL1_Left
    {
        offset[] = {0.04,0,0.19};
    };
};


class CfgWeapons {
    class H_HelmetB;
    class H_HelmetB_light : H_HelmetB {
        Headlamps_Preset=Headlamps_Preset_Helmet_Surefire_HL1_Left_ARC;
    };

    class H_HelmetB_plain_mcamo : H_HelmetB {};
    class H_HelmetSpecB : H_HelmetB_plain_mcamo {
        Headlamps_Preset=Headlamps_Preset_Helmet_Surefire_HL1_Left;
    };
};
