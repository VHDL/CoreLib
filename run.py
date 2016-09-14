from vunit import VUnit
from pathlib import Path

rootDirectory = Path.cwd()

# Create and configure a VUnit instance and handover the command line arguments
vu = VUnit.from_argv()
vu.enable_location_preprocessing()

# Create the VHDL library 'CoreLib' and add required files
CoreLib = vu.add_library("CoreLib")
CoreLib.add_source_files(str(rootDirectory / "src/physical.vhdl"))

# Create the VHDL library 'Testbench' and add required files
# Testbench = vu.add_library("Testbench")
CoreLib.add_source_files(str(rootDirectory / "tb/vunit/physical_tb.vhdl"))

# launch VUnit
vu.main()
