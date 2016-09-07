library vunit_lib;
context vunit_lib.vunit_context;

library data_structures_lib;
use data_structures_lib.corelib_Dict.all;

entity tb_data_structures is
  generic (
    runner_cfg : string);
end entity tb_data_structures;

architecture test_fixture of tb_data_structures is
  shared variable shared_dict : PT_DICT;
begin
  test_runner : process
    variable dict : PT_DICT;
  begin
    test_runner_setup(runner, runner_cfg);
    checker_init(display_format => verbose);

    while test_suite loop
      if run("Test that dictionary values can be set and retrieved") then
        dict.set("Answer to the Ultimate Question of Life, the Universe, and Everything", 42);
        check_equal(dict.get("Answer to the Ultimate Question of Life, the Universe, and Everything"), 42);
      elsif run("Test that a shared variable can be of a dictionary type") then
        shared_dict.set("seventeen", 17);
        check_equal(shared_dict.get("seventeen"), 17);
      end if;
    end loop;

    test_runner_cleanup(runner);
    wait;
  end process;

  test_runner_watchdog(runner, 100 ns);

end test_fixture;
