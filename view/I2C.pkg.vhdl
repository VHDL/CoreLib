-- Package author:    Patrick Lehmann - Patrick.Lehmann@tu-dresden.de
-- =============================================================================
-- Interface name:    I2C (Inter-Integrated Circuit)
-- Alternative names: Two-Wire-Interface (TWI)
-- Can be reused for: MDIO, PS/2, PMBus, SMBus
-- Developed by:      Philips / NXP Semiconductor
-- Standard/Manual:   http://www.nxp.com/documents/user_manual/UM10204.pdf
-- Further links:     https://en.wikipedia.org/wiki/I%C2%B2C
-- =============================================================================
-- 

library ieee;
use ieee.std_logic_1164.all;
use work.TriState.all;

package I2C is
	-- View from PCB needed in testbenches or to wire signals from a controller
	-- to a toplevel
	type R_I2C_PCB is record
		SerialClock : std_logic;  -- alternative names: scl
		SerialData  : std_logic;  -- alternative names: sda
	end record;

	view V_I2C_PCB of R_I2C_PCB is
		SerialClock : inout;
		SerialData  : inout;
	end view;
	
	-- View from within e.g. an FPGA
	type R_I2C is record
		SerialClock : R_TriState;  -- alternative names: scl
		SerialData  : R_TriState;  -- alternative names: sda
	end record;

	view V_I2C of R_I2C is
		SerialClock : view V_TriState;
		SerialData  : view V_TriState;
	end view;
end package;
