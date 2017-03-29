-- Package author:    Patrick Lehmann - Patrick.Lehmann@tu-dresden.de
-- =============================================================================
-- Interface name:    Tri-state
-- Alternative names: Three-state, 3-state
-- Further links:     https://en.wikipedia.org/wiki/Three-state_logic
-- =============================================================================
-- 
library ieee;
use ieee.std_logic_1164.all;

package TriState is
	type R_TriState is record
		Input        : std_logic;  -- alternative names: i
		Output       : std_logic;  -- alternative names: o
		OutputEnable : std_logic;  -- alternative names: oe, t
	end record;

	view V_TriState of R_TriState is
		Input        : in;
		Output       : out;
		OutputEnable : out;
	end view;
end package;

-- General Comments:
-- =====================================
-- * <Add your comment here>
