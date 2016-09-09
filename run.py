from vunit import VUnit
from os.path import dirname, join

vu = VUnit.from_argv()
vu.enable_location_preprocessing()

root = join(dirname(__file__), 'string_operations')

string_operations_lib = vu.add_library('string_operations_lib')
string_operations_lib.add_source_files(join(root, 'src', '*.vhd'))
tb_string_operations_lib = vu.add_library('tb_string_operations_lib')
tb_string_operations_lib.add_source_files(join(root, 'test', '*.vhd'))

vu.main()
