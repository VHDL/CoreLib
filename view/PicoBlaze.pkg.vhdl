-- Package author:    Patrick Lehmann - Patrick.Lehmann@tu-dresden.de
-- =============================================================================
-- Interface name:    PicoBlaze (Data bus of Ken Chapman's famous 8-bit programmable statemachine)
-- Developed by:      Ken Chapman; extended by Patrick Lehmann
-- Standard/Manual:   https://github.com/Paebbels/PicoBlaze-Library/blob/master/documentation%20(Xilinx)/KCPSM6%20-%20User%20Guide%20%5B2014.09.30%5D.pdf
-- Further links:     https://github.com/Paebbels/PicoBlaze-Library?ts=2
-- =============================================================================
--
-- Description:
-- The original data bus used by the PicoBlaze has 3 strobes (one for each
-- address space: read, write, write_k), an address called PortID, two data
-- ports and an interrupt/interrupt_ack pair.
--
-- I extended this by an interrupt message byte. All interrupt wires are latched
-- in an interrupt controller and stored with the corresponding error message.
-- 
library ieee;
use ieee.std_logic_1164.all;

package PicoBlaze is
  type R_DataBus is record
    ReadStrobe    : std_logic;
    WriteStrobe   : std_logic;
    WriteStrobe_K : std_logic;
    PortID        : std_logic_vector(7 downto 0);  -- aka Address
    DataIn        : std_logic_vector(7 downto 0);
    DataOut       : std_logic_vector(7 downto 0);
		
    Interrupt     : std_logic;
    Message       : std_logic_vector(7 downto 0);
    Interrupt_Ack : std_logic;
  end record;

  type T_DataBus_Vector is array(natural range <>) of R_DataBus;
	
  view V_DataBus of R_DataBus is
    ReadStrobe    : out;
    WriteStrobe   : out;
    WriteStrobe_K : out;
    PortID        : out;
    DataIn        : in;
    DataOut       : out;

    Interrupt     : in;
    Message       : in;
    Interrupt_Ack : out;
  end view;
end package;

-- General Comments:
-- =====================================
-- * <Add your comment here>

