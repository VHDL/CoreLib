-- Package author:    Patrick Lehmann - Patrick.Lehmann@tu-dresden.de
-- =============================================================================
-- Interface name:    PoC.FIFO
-- Developed by:      VLSI-EDA
-- Standard/Manual:   http://poc-library.readthedocs.io/en/release/Interfaces/FIFO.html
-- =============================================================================
-- 
package PoC_FIFO is
	type R_FIFO_WritePort_Simple is record
		Put  : std_logic;
		Data : std_logic_vector;
		Full : std_logic;
	end record;

	view V_FIFO_WritePort_Simple of R_FIFO_WritePort_Simple is
		Put  : in;
		Data : in;
		Full : out;
	end view;
	
	type R_FIFO_WritePort is record
		Put        : std_logic;
		Data       : std_logic_vector;
		Full       : std_logic;
		EmptyState : std_logic_vector;
	end record;

	view V_FIFO_WritePort of R_FIFO_WritePort is
		Put        : in;
		Data       : in;
		Full       : out;
		EmptyState : out;
	end view;
	
	type R_FIFO_ReadPort_Simple is record
		Got       : std_logic;
		Data      : std_logic_vector;
		Valid     : std_logic;
	end record;
	
	view V_FIFO_ReadPort_Simple of R_FIFO_ReadPort_Simple is
		Got   : in;
		Data  : out;
		Valid : out;
	end view;
	
	type R_FIFO_ReadPort is record
		Got       : std_logic;
		Data      : std_logic_vector;
		Valid     : std_logic;
		FillState : std_logic_vector;
	end record;
	
	view V_FIFO_ReadPort of R_FIFO_ReadPort is
		Got       : in;
		Data      : out;
		Valid     : out;
		FillState : out;
	end view;
end package;
