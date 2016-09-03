package synchronization_pkg is
  function resolve_event (
    times : time_vector)
    return time;
  subtype event_t is resolve_event time;

  impure function is_triggered (
    signal event : event_t)
    return boolean;

  procedure trigger (
    signal event : out event_t;
    constant delay : in delay_length := 0 fs);

  procedure wait_on (
    signal event : event_t);

  procedure wait_on (
    signal event       : in  event_t;
    constant timeout   : in  time;
    variable timed_out : out boolean);
end package synchronization_pkg;

package body synchronization_pkg is
  function resolve_event (
    times : time_vector)
    return time is
    variable result : time;
  begin
    for i in times'range loop
      result := maximum(times(i), result);
    end loop;

    return result;
  end;

  impure function is_triggered (
    signal event : event_t)
    return boolean is
  begin
    return event = now;
  end;

  procedure trigger (
    signal event : out event_t;
    constant delay : in delay_length := 0 fs) is
  begin
    event <= now + delay after delay;
  end;

  procedure wait_on (
    signal event : event_t) is
  begin
    if event /= now then
      wait on event;
    end if;
  end;

  procedure wait_on (
    signal event       : in  event_t;
    constant timeout   : in  time;
    variable timed_out : out boolean) is
  begin
    if event /= now then
      assert timeout > 0 ns
        report "Setting negative timeout to 0 ns" severity warning;
      wait on event for maximum(0 ns, timeout);
    end if;
    timed_out := event /= now;
  end;

end package body synchronization_pkg;
