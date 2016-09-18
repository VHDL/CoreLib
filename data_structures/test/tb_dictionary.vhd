library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

library data_structures_lib;
use data_structures_lib.corelib_Dict.all;



entity tb_data_structures is
  generic (
    runner_cfg : string);
end entity tb_data_structures;



architecture test_fixture of tb_data_structures is


  shared variable sv_dict : PT_DICT;


begin


  test_runner : process is
    impure function is_equal (key : integer; expected_data : std_logic_vector) return boolean is
    begin
      return sv_dict.Get(key) = expected_data;
    end function is_equal;
  begin
    test_runner_setup(runner, runner_cfg);
    checker_init(display_format => verbose);
    while test_suite loop
      if run ("Test that dictionary is empty") then
        check_equal(sv_dict.Count, 0);
      elsif run("Test that dictionary data can be set and retrieved") then
        sv_dict.Set(42, x"DEADBEEF");
        check(is_equal(42, x"DEADBEEF"));
      end if;
    end loop;
    test_runner_cleanup(runner);
    wait;
  end process;


  test_runner_watchdog(runner, 100 ns);


end architecture test_fixture;
