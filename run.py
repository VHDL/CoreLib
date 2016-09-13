from vunit import VUnit
from pathlib import Path

rootDirectory = Path(__file__)

# Create and configure a VUnit instance and handover the command line arguments
vu = VUnit.from_argv()
vu.enable_location_preprocessing()

# Create the VHDL library 'CoreLib' and add required files
CoreLib = vu.add_library("CoreLib")
CoreLib.add_source_files(str(rootDirectory / "src/math.vhdl"))

# Create the VHDL library 'Testbench' and add required files
Testbench = vu.add_library("Testbench")
Testbench.add_source_files(str(rootDirectory / "tb/vunit/math_tb.vhdl"))

# launch VUnit
vu.main()
