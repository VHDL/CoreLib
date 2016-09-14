from vunit import VUnit
from os.path import dirname, join

vu = VUnit.from_argv()

root = join(dirname(__file__), 'synchronization')

synchronization_lib = vu.add_library('synchronization_lib')
synchronization_lib.add_source_files(join(root, 'src', '*.vhd'))
tb_synchronization_lib = vu.add_library('tb_synchronization_lib')
tb_synchronization_lib.add_source_files(join(root, 'test', '*.vhd'))

vu.main()
