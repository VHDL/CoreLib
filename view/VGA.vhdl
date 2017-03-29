-- Package author:    Patrick Lehmann - Patrick.Lehmann@tu-dresden.de
-- =============================================================================
-- Interface name:    VGA
-- Developed by:      IBM
-- Standard/Manual:   http://www.mcamafia.de/pdf/ibm_vgaxga_trm2.pdf
-- Further links:     https://en.wikipedia.org/wiki/VGA_connector
-- =============================================================================
-- 
use work.I2C.all;

package VGA_BUS is
  type R_VGA is record
    HSync : std_logic;
    VSync : std_logic;
    R     : std_logic_vector;
    G     : std_logic_vector;
    B     : std_logic_vector;
  end record;

  -- DDC - Display Data Channel
  type R_VGA_with_DCC_PCB is record
    VGA : R_VGA;
    DDC : R_I2C_PCB;
  end record;
  
  view V_VGA_PCB of R_VGA_with_DCC_PCB is
    VGA : out;         -- no need for a view here, because all are outputs
    DDC : view V_I2C_PCB;
  end view;

  -- DDC - Display Data Channel
  type R_VGA_with_DCC is record
    VGA : R_VGA;
    DDC : R_I2C;
  end record;
  
  view V_VGA of R_VGA_with_DCC is
    VGA : out;         -- no need for a view here, because all are outputs
    view DDC : view V_I2C;
  end view;
end package;
