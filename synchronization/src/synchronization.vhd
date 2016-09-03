library ieee;
use ieee.std_logic_1164.all;

package synchronization_pkg is
  subtype event_t is std_logic; -- Proper type to be decided

  function is_triggered (
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
  function is_triggered (
    signal event : event_t)
    return boolean is
  begin
    return true;
  end;

  procedure trigger (
    signal event : out event_t;
    constant delay : in delay_length := 0 fs) is
  begin
  end;

  procedure wait_on (
    signal event : event_t) is
  begin
    wait for 50 ns;
  end;

  procedure wait_on (
    signal event       : in  event_t;
    constant timeout   : in  time;
    variable timed_out : out boolean) is
  begin
    wait for 50 ns;
    timed_out := true;
  end;

end package body synchronization_pkg;
