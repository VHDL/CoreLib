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
    constant delay : in delay_length := delay_length'left);

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
    constant delay : in delay_length := delay_length'left) is
  begin
    event <= transport now + delay after delay;
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
      assert timeout > delay_length'left
        report "Setting negative timeout to " & to_string(delay_length'left) severity warning;
      wait on event for maximum(delay_length'left, timeout);
    end if;
    timed_out := event /= now;
  end;

end package body synchronization_pkg;
