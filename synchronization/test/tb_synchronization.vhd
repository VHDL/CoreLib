library vunit_lib;
context vunit_lib.vunit_context;

library synchronization_lib;
use synchronization_lib.synchronization_pkg.all;

use std.env.all;

entity tb_synchronization is
  generic (
    runner_cfg : string);
end entity tb_synchronization;

architecture test_fixture of tb_synchronization is
  signal event, delayed_event, concurently_triggered_event : event_t;
  signal number_of_times_triggered : natural := 0;
  constant event_delay_c : time := 10 ns;
  constant concurently_triggered_event_delay_c : time := 15 ns;
begin
  test_runner : process
    variable start : time;
    variable timed_out : boolean;
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop
      if run("Test that an uninitialized event is not triggered") then
        check_false(is_triggered(event));

      elsif run("Test that an event in a sensitivity list will trigger the process") then
        wait for 0 fs;
        check_equal(number_of_times_triggered, 1, "Expected an initial run of the process at this point");
        trigger(event);
        wait for resolution_limit;
        check_equal(number_of_times_triggered, 2, "Process should have been triggered by now");

      elsif run("Test that an event can be waited for until triggered") then
        start := now;
        wait_on(delayed_event);
        check_equal(now - start, event_delay_c);

      elsif run("Test that a wait for a triggered event does not block") then
        wait_on(delayed_event);
        start := now;
        wait_on(delayed_event);
        check_equal(start, now);

      elsif run("Test that a wait with timeout blocks until event is set if that happens before the timeout") then
        start := now;
        wait_on(delayed_event, event_delay_c + 1 ns, timed_out);
        check_equal(now - start, event_delay_c, "Did not block correctly on wait statement");
        check_false(timed_out, "Time out reported");

      elsif run("Test that a wait with timeout times out if timeout happens before event is set") then
        start := now;
        wait_on(delayed_event, event_delay_c - 1 ns, timed_out);
        check_equal(now - start, event_delay_c - 1 ns, "Did not timeout when expected");
        check(timed_out, "Time out not reported");

      elsif run("Test that a negative timeout behaves like a zero timeout") then
        start := now;
        wait_on(event, -1 ns, timed_out);
        check_equal(start, now, "Did not timeout when expected");
        check(timed_out, "Time out not reported");
        trigger(event);
        start := now;
        wait_on(event, -1 ns, timed_out);
        check_equal(start, now, "Blocked on an already triggered event");
        check_false(timed_out, "Time out reported");

      elsif run("Test that an event triggered with zero delay is triggered in the next delta cycle") then
        trigger(event);
        check_false(is_triggered(event), "Event triggered");
        wait for 0 ns;
        check(is_triggered(event), "Event not triggered");

      elsif run("Test that an event triggered with a positive delay is triggered after the delay given") then
        trigger(event, 3 ns);
        start := now;
        wait_on(event);
        check_equal(now - start, 3 ns, "Did not trigger correctly");

      elsif run("Test that an event can be triggered concurrently") then
        start := now;
        wait_on(concurently_triggered_event);
        check_equal(now - start, concurently_triggered_event_delay_c);

      elsif run("Test that an event triggered simultaneously two times does not cancel each other") then
        -- The original proposal suggests that these two events should cancel each other
        trigger(event);
        trigger(event);
        wait_on(event, 0 ns, timed_out);
        check_false(timed_out, "No event detected");

      elsif run("Test that an event can be driven from several processes") then
        start := now;
        trigger(concurently_triggered_event);
        wait_on(concurently_triggered_event);
        check_equal(now, start);
        wait for resolution_limit;
        wait_on(concurently_triggered_event);
        check_equal(now - start, concurently_triggered_event_delay_c);
      end if;
    end loop;

    test_runner_cleanup(runner);
  end process;

  test_runner_watchdog(runner, 100 ns);

  delayed_trigger: process is
  begin
    wait for event_delay_c;
    trigger(delayed_event);
    wait;
  end process delayed_trigger;

  trigger(concurently_triggered_event, concurently_triggered_event_delay_c);

  process_to_trigger: process (event) is
  begin
    number_of_times_triggered <= number_of_times_triggered + 1;
  end process process_to_trigger;

end test_fixture;
