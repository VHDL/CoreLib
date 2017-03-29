-- Package author:    Patrick Lehmann - Patrick.Lehmann@tu-dresden.de
-- =============================================================================
-- Interface name:    PCI Express (PCIe)
-- Developed by:      PCI Special Interest Group (PCI-SIG)
-- Standard:          
-- Further links:     https://en.wikipedia.org/wiki/Three-state_logic
-- =============================================================================
-- 
library ieee;
use ieee.std_logic_1164.all;

use work.I2C.all;
use work.JTAG.all;
use work.LVDS.all;

package PCIe is
	generic (
		LANES : positive
	);

	type R_PCIe_PCB is record
		SMBus    : R_I2C_PCB;
		JTAG     : R_JTAG;
		PeRst_n  : std_logic;
		Wake_n   : std_logic;
		RefClk   : R_LVDS;
		Lanes    : T_Lane_Vector(LANES - 1 downto 0);
	end record;

	view V_PCIe_PCB of R_PCIe_PCB is
		SMBus    : view V_I2C_PCB;
		JTAG     : view V_JTAG;
		PeRst_n  : in;
		Wake_n   : out;
		RefClk   : view V_LVDS;
		Lanes    : view (V_Lane);
	end view;
	
	type R_PCIe is record
		SMBus    : R_I2C;
		JTAG     : R_JTAG;
		PeRst_n  : std_logic;
		Wake_n   : std_logic;
		RefClk   : R_LVDS;
		Lanes    : T_Lane_Vector(LANES - 1 downto 0);
	end record;

	view V_PCIe of R_PCIe is
		SMBus    : view V_I2C;
		JTAG     : view V_JTAG;
		PeRst_n  : in;
		Wake_n   : out;
		RefClk   : view V_LVDS;
		Lanes    : view (V_Lane);
	end view;
end package;
