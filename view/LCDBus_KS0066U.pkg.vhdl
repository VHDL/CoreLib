-- Package author:    Patrick Lehmann - Patrick.Lehmann@tu-dresden.de
-- =============================================================================
-- Interface name:    LCDBus
-- Developed by:      ?? used by various dot-matrix LC displays
-- Standard/Manual:   http://pdf1.alldatasheet.com/datasheet-pdf/view/37318/SAMSUNG/KS0066.html
-- =============================================================================
-- 
use work.TriState.all;

package LCDBus is
	-- View from PCB needed in testbenches or to wire signals from a controller
	-- to a toplevel
	type R_LCDBus_PCB is record
		Enable         : std_logic;         -- alternative names: E
		ReadWrite      : std_logic;         -- alternative names: RW
		RegisterSelect : std_logic;         -- alternative names: RS, Address
		DataBus        : std_logic_vector;  -- alternative names: DB
	end record;

	view V_LCDBus_PCB of R_LCDBus_PCB is
		Enable         : out;
		ReadWrite      : out;
		RegisterSelect : out;
		DataBus        : inout;
	end view;
	
	-- View from within e.g. an FPGA before the IOBs (I/O blocks)
	type R_LCDBus is record
		Enable         : std_logic;
		OutputEnable   : std_logic;        -- this is needed to force 'Z' on DataBus for read operations
		ReadWrite      : std_logic;
		RegisterSelect : std_logic;
		DataBus        : std_logic_vector;
	end record;
	
	view V_LCDBus of R_LCDBus is
		Enable         : out;
		OutputEnable   : out;
		ReadWrite      : out;
		RegisterSelect : out;
		DataBus        : inout;
	end view;
end package;
