-- Package author:    Patrick Lehmann - Patrick.Lehmann@tu-dresden.de
-- =============================================================================
-- Interface name:    AXI 4 Lite (...)
-- Developed by:      Patrick Lehmann
-- Standard/Manual:   http://www.arm.com
-- =============================================================================
-- AXI uses 5 data ports plus a clock/reset "system interface":
--  * System          M -> S
--  * Write Addresses M -> S
--  * Write Data      M -> S
--  * Write Response  M <- S
--  * Read Addresses  M -> S
--  * Read Data       M <- S

package AXI4Lite is
  generic (
    DATA_WIDTH : positive := 32
  );
  
	constant STROBE_WIDTH : positive := DATA_WIDTH / 8;
	
  -- Data width dependent types.
  subtype T_AXI_Data   is std_logic_vector(DATA_WIDTH - 1 downto 0);
  subtype T_AXI_Strobe is std_logic_vector(STROBE_WIDTH - 1 downto 0);

  -- Data width independent types.
  subtype T_AXI_prot     is std_logic_vector(2 downto 0);
  subtype T_AXI_Response is std_logic_vector(1 downto 0);

  type T_AXI_System is record
    Clock     : std_logic;
    Reset     : std_logic;
  end record;

  type T_AXI_Handshake is record
    Valid     : std_logic;
    Ready     : std_logic;
  end record;

  type T_AXILite_Address is record
    Handshake : T_AXI_Handshake;
    Address   : unsigned;
    prot      : T_AXI_prot;
  end record;

  type T_AXILite_WriteData is record
    Handshake : T_AXI_Handshake;
    Data      : T_AXI_Data;
    Strobe    : T_AXI_Strobe;
  end record;

  type T_AXILite_WriteResponse is record
    Handshake : T_AXI_Handshake;
    Response  : T_AXI_Response;
  end record;

  type T_AXILite_ReadData is record
    Handshake : T_AXI_Handshake;
    Data      : T_AXI_Data;
    Response  : T_AXI_Response;
  end record;

  type T_AXILite is record
    System        : T_AXI_System;
    WriteAddress  : T_AXILite_Address;
    WriteData     : T_AXILite_WriteData;
    WriteResponse : T_AXILite_WriteResponse;
    ReadAddress   : T_AXILite_Address;
    ReadData      : T_AXILite_ReadData;
  end record;

  -- All lower-level views are defined from the driver's point of view.
  view V_AXI_Handshake of T_AXI_Handshake is
    Valid     : out;
    Ready     : in;
  end view;

  view V_AXILite_Address of T_AXI_Address is
    Handshake : V_AXI_Handshake;
    Address   : out;
    prot      : out;
  end view;

  view V_AXILite_WriteData of T_AXILite_WriteData is
    Handshake : V_AXI_Handshake;
    Data      : out;
    Strobe    : out;
  end view;

  view V_AXILite_WriteResponse of T_AXILite_WriteResponse is
    Handshake : V_AXI_Handshake;
    Response  : out;
  end view;

  view V_AXILite_ReadData of T_AXILite_ReadData is
    Handshake : V_AXI_Handshake;
    Data      : out;
    Response  : out;
  end view;

  -- Top level views for master and slave.
  view V_AXILite_Master of T_AXILite is
    System        : in;
    WriteAddress  : V_AXILite_Address;
    WriteData     : V_AXILite_WriteData;
    WriteResponse : V_AXILite_WriteResponse'converse;
    ReadAddress   : V_AXILite_Address;
    ReadData      : V_AXILite_ReadData'converse;
  end view;

  view V_AXILite_Slave of T_AXILite is
    Clock         : in;
    WriteAddress  : V_AXILite_Address'converse;
    WriteData     : V_AXILite_WriteData'converse;
    WriteResponse : V_AXILite_WriteResponse;
    ReadAddress   : V_AXILite_Address'converse;
    ReadData      : V_AXILite_ReadData;
  end view;
end package;
