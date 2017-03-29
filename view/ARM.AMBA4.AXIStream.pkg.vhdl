-- Package author:    Patrick Lehmann - Patrick.Lehmann@tu-dresden.de
-- =============================================================================
-- Interface name:    AMBA 4 - AXI-Stream
-- Developed by:      ARM
-- Standard/Manual:   http://www.arm.com
-- =============================================================================
-- 
package ARM_AMBA4_AXIStream is
	type R_ARM_AMBA4_AXIStream_Simple is record
		TValid  : std_logic;
		TData   : std_logic_vector;
		TReady  : std_logic;
		TLast   : std_logic;
	end record;

	view V_ARM_AMBA4_AXIStream_Simple of R_ARM_AMBA4_AXIStream_Simple is
		TValid  : out;
		TData   : out;
		TReady  : in;
		TLast   : out;
	end view;
end package;
