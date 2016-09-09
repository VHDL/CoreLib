library vunit_lib;
context vunit_lib.vunit_context;

library string_operations_lib;
use string_operations_lib.string_operations.all;

entity tb_string_operations is
  generic (
    runner_cfg : string);
end entity tb_string_operations;

architecture test_fixture of tb_string_operations is
begin
  test_runner : process
    constant offset_string :string(10 to 16) := "foo bar";
    constant reverse_string :string(16 downto 10) := "foo bar";
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop
      if run("Test that a pattern can be replaced with something") then
        check_equal(str_replace("beginning middle end", "beginning", "replaced beginning"),
                    "replaced beginning middle end");
        check_equal(str_replace("beginning middle end", "middle", "replaced middle"),
                    "beginning replaced middle end");
        check_equal(str_replace("beginning middle end", "end", "replaced end"),
                    "beginning middle replaced end");
      elsif run("Test that a pattern can be replaced with nothing") then
        check_equal(str_replace("beginning middle end", "beginning", ""),
                    " middle end");
        check_equal(str_replace("beginning middle end", "middle", ""),
                    "beginning  end");
        check_equal(str_replace("beginning middle end", "end", ""),
                    "beginning middle ");
        check_equal(str_replace("", "", ""), "");
      elsif run("Test that nothing can be replaced with something") then
        check_equal(str_replace("foo", "", "|"), "|f|o|o|");
        check_equal(str_replace("foo", "", ""), "foo");
        check_equal(str_replace("", "", "|"), "|");
      elsif run("Test that nothing is replaced when pattern is not found") then
        check_equal(str_replace("foo bar", "spam", "eggs"), "foo bar");
      elsif run("Test that the complete string can be replaced") then
        check_equal(str_replace("foo bar", "foo bar", "spam eggs"), "spam eggs");
      elsif run("Test that a pattern can be replaced in many locations") then
        check_equal(str_replace("ding dong", "ng", "me"), "dime dome");
      elsif run("Test that a pattern can be replaced in an offset string") then
        check_equal(str_replace(offset_string, "oo", "ood"), "food bar");
      elsif run("Test that a pattern can be replaced in a reversed string") then
        check_equal(str_replace(reverse_string, "oo", "ood"), "food bar");
      elsif run("Test that an existing pattern is not replaced when max_num_of_replacements is zero") then
        check_equal(str_replace("foo", "o", "a", 0), "foo");
      elsif run("Test that just the first max_num_of_replacements occurances of a pattern are replaced") then
        check_equal(str_replace("foo zoo", "oo", "ine", 1), "fine zoo");
      elsif run("Test that all of n occurances of a pattern are replaced if max_num_of_replacements is n") then
        check_equal(str_replace("foo zoo", "oo", "ine", 2), "fine zine");
      elsif run("Test that all of n occurances of a pattern are replaced if max_num_of_replacements is greater than n") then
        check_equal(str_replace("foo zoo", "oo", "ine", 100), "fine zine");
      end if;
    end loop;

    test_runner_cleanup(runner);
    wait;
  end process;

  test_runner_watchdog(runner, 100 ns);

end test_fixture;
