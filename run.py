from vunit import VUnit
from os.path import dirname, join

vu = VUnit.from_argv()
vu.enable_location_preprocessing()
vu.add_osvvm()

root = join(dirname(__file__), 'data_structures')

data_structures_lib = vu.add_library('data_structures_lib')
data_structures_lib.add_source_files(join(root, 'src', '*.vhd'))
data_structures_lib.add_source_files(join(root, '', '*.vhd'))
tb_data_structures_lib = vu.add_library('tb_data_structures_lib')
tb_data_structures_lib.add_source_files(join(root, 'test', '*.vhd'))

vu.main()
