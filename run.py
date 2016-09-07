from vunit import VUnit
from os.path import dirname, join

vu = VUnit.from_argv()
vu.enable_location_preprocessing()

root = join(dirname(__file__))

CoreLib = vu.add_library('CoreLib')
CoreLib.add_source_files(join(root, 'src', '*.vhdl'))
CoreLib.add_source_files(join(root, 'src', 'DataStructures', '*.vhdl'))
CoreLib.add_source_files(join(root, 'tb', 'vunit', '*.vhdl'))

vu.main()
