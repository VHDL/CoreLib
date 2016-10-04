library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library osvvm;
context osvvm.osvvmcontext;

library vunit_lib;
context vunit_lib.vunit_context;

library data_structures_lib;
use data_structures_lib.DataStructures.all;



entity tb_data_structures is
  generic (
    runner_cfg : string);
end entity tb_data_structures;



architecture test_fixture of tb_data_structures is


  shared variable sv_dict : Integer_Slv_Dict;


begin


  test_runner : process is
    variable v_random : RandomPType;
  begin
    test_runner_setup(runner, runner_cfg);
    checker_init(display_format => verbose);
    while test_suite loop
      if run("Test that dictionary is empty in initial state") then
        check_equal(sv_dict.Count, 0);
      elsif run("Test that dictionary data can be set") then
        sv_dict.Set(42, x"DEADBEEF");
        check(sv_dict.HasKey(42));
      elsif run("Test that dictionary data can be set and count is updated") then
        sv_dict.Set(42, x"DEADBEEF");
        check_equal(sv_dict.Count, 1);
      elsif run("Test that dictionary data can be set and retrieved") then
        sv_dict.Set(42, x"DEADBEEF");
        check_equal(sv_dict.Get(42), std_logic_vector'(x"DEADBEEF"));
      elsif run("Test that dictionary data can be set and removed") then
        sv_dict.Set(42, x"DEADBEEF");
        check(sv_dict.HasKey(42));
        sv_dict.Del(42);
        check_false(sv_dict.HasKey(42));
      elsif run("Test that dictionary data can be overwritten when having same key") then
        sv_dict.Set(42, x"DEADBEEF");
        sv_dict.Set(42, x"DEADAFFE");
        check_equal(sv_dict.Get(42), std_logic_vector'(x"DEADAFFE"));
      elsif run("Test that dictionary data with same hash table slot can be set and retrieved") then
        sv_dict.Set(1, x"DEADBEEF");
        sv_dict.Set(129, x"DEADAFFE");
        check_equal(sv_dict.Get(1), std_logic_vector'(x"DEADBEEF"));
        check_equal(sv_dict.Get(129), std_logic_vector'(x"DEADAFFE"));
        check_equal(sv_dict.Count, 2);
      elsif run("Test that dictionary data with same hash table slot can be set and completely removed") then
        sv_dict.Set(1, x"DEADBEEF");
        sv_dict.Set(129, x"DEADAFFE");
        check_equal(sv_dict.Count, 2);
        sv_dict.Del(1);
        check_equal(sv_dict.Count, 1);
        sv_dict.Del(129);
        check_equal(sv_dict.Count, 0);
      elsif run("Test that dictionary data can be stored and retrieved in every hash table slot") then
        v_random.InitSeed(test_runner'instance_name);
        for i in 0 to 127 loop
          sv_dict.Set(i, v_random.RandSlv(32));
        end loop;
        v_random.InitSeed(test_runner'instance_name);
        for i in 0 to 127 loop
          check_equal(sv_dict.Get(i), v_random.RandSlv(32));
        end loop;
        check_equal(sv_dict.Count, 128);
      elsif run("Test that dictionary data can be cleared") then
        for i in 0 to 127 loop
          sv_dict.Set(i, std_logic_vector(to_unsigned(i, 32)));
        end loop;
        check_equal(sv_dict.Count, 128);
        sv_dict.Clear;
        check_equal(sv_dict.Count, 0);
      end if;
    end loop;
    test_runner_cleanup(runner);
    wait;
  end process;


  test_runner_watchdog(runner, 100 ns);


end architecture test_fixture;
