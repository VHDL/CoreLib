-- Package author:    Patrick Lehmann - Patrick.Lehmann@tu-dresden.de
-- =============================================================================
-- Interface name:    Joint Test Action Group (JTAG)
-- Developed by:      Joint Test Action Group (JTAG)
-- Standard/Manual:   IEEE Standard 1149.1-1990 - Standard Test Access Port and Boundary-Scan Architecture
-- Further links:     https://en.wikipedia.org/wiki/JTAG
-- =============================================================================
-- 
package JTAG is
	type R_JTAG is record
		TestClock      : std_logic;  -- alternative names: TCK 
		TestReset      : std_logic;  -- alternative names: TRST
		TestModeSelect : std_logic;  -- alternative names: TMS 
		TestDataIn     : std_logic;  -- alternative names: TDI 
		TestDataOut    : std_logic;  -- alternative names: TDO 
	end record;

	view V_JTAG of R_JTAG is
		TestClock      : in;
		TestReset      : in;
		TestModeSelect : in;
		TestDataIn     : in;
		TestDataOut    : out;
	end view;
end package;
