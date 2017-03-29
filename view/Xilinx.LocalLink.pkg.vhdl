-- Package author:    Patrick Lehmann - Patrick.Lehmann@tu-dresden.de
-- =============================================================================
-- Interface name:    Local-Link
-- Developed by:      Xilinx
-- Standard/Manual:   https://www.xilinx.com/aurora/aurora_member/sp006.pdf
-- =============================================================================
-- 
package Xilinx_LocalLink is
	type R_Xilinx_LocalLink_Simple is record
		SourceReady_n      : std_logic;
		Data               : std_logic_vector;
		DestinationReady_n : std_logic;
	end record;

	view V_Xilinx_LocalLink_Simple of R_Xilinx_LocalLink_Simple is
		SourceReady_n      : out;
		Data               : out;
		DestinationReady_n : in;
	end view;
	
	type R_Xilinx_LocalLink_w_Frame is record
		SourceReady_n      : std_logic;
		Data               : std_logic_vector;
		DestinationReady_n : std_logic;
		StartOfFrame_n     : std_logic;
		EndOfFrame_n       : std_logic;
	end record;

	view V_Xilinx_LocalLink_w_Frame of R_Xilinx_LocalLink_w_Frame is
		SourceReady_n      : out;
		Data               : out;
		DestinationReady_n : in;
		StartOfFrame_n     : out;
		EndOfFrame_n       : out;
	end view;
	
	type R_Xilinx_LocalLink_w_Payload is record
		SourceReady_n      : std_logic;
		Data               : std_logic_vector;
		DestinationReady_n : std_logic;
		StartOfFrame_n     : std_logic;
		EndOfFrame_n       : std_logic;
	end record;

	view V_Xilinx_LocalLink_w_Payload of R_Xilinx_LocalLink_w_Payload is
		SourceReady_n      : out;
		Data               : out;
		DestinationReady_n : in;
		StartOfFrame_n     : out;
		EndOfFrame_n       : out;
	end view;
end package;
