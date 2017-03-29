-- Package author:    Patrick Lehmann - Patrick.Lehmann@tu-dresden.de
-- =============================================================================
-- Interface name:    Low Voltage Differential Signaling (LVDS)
-- Related names:     CML, SCL, (LV)PECL
-- Standard:          ANSI/TIA/EIA-644-1995
-- Further links:     https://en.wikipedia.org/wiki/Low-voltage_differential_signaling
-- =============================================================================
-- 
package LVDS is
	type R_LVDS is record
		P : std_logic;  -- alternative names: I,  O
		N : std_logic;  -- alternative names: IB, OB
	end record;

	view V_LVDS of R_LVDS is
		P : out;
		N : out;
	end view;
	
	type R_Lane is record
		TX : R_LVDS;
		RX : R_LVDS;
	end record;
	
	type T_Lane_Vector is array(natural range <>) of R_Lane;

	view V_Lane of R_Lane is
		TX : view V_LVDS;
		RX : view V_LVDS'converse;
	end view;
end package;
