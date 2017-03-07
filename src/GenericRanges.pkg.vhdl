-- EMACS settings: -*-  tab-width: 2; indent-tabs-mode: t -*-
-- vim: tabstop=2:shiftwidth=2:noexpandtab
-- kate: tab-width 2; replace-tabs off; indent-width 2;
-- 
-- =============================================================================
--  _____      _                 _          _ ____
-- | ____|_  _| |_ ___ _ __   __| | ___  __| |  _ \ __ _ _ __   __ _  ___  ___
-- |  _| \ \/ / __/ _ \ '_ \ / _` |/ _ \/ _` | |_) / _` | '_ \ / _` |/ _ \/ __|
-- | |___ >  <| ||  __/ | | | (_| |  __/ (_| |  _ < (_| | | | | (_| |  __/\__ \
-- |_____/_/\_\\__\___|_| |_|\__,_|\___|\__,_|_| \_\__,_|_| |_|\__, |\___||___/
--                                                             |___/
-- =============================================================================
-- Authors:       Patrick Lehmann
-- 
-- Package:       VHDL package for extended ranges expressed as records.
--
-- Documentation:
-- -------------------------------------
-- Add user defined and manipulatable ranges (abstracted as VHDL records) to
-- the next VHDL release.
-- 
-- Proposal URL: http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/ExtendedRanges
--
-- License:
-- ============================================================================
-- Copyright 2016 Patrick Lehmann - Dresden, Germany
-- 
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
--    http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- ============================================================================

package GenericDiscreteRanges is
  generic (
    type T_BOUND is ( <> )
  );

  type DIRECTION is (ASCENDING, DESCENDING);
  
  type RANGE_RECORD is record
    Left : T_BOUND;
    Right : T_BOUND;
    Direction  : DIRECTION;
  end record;
  
  -- constructors
  function to_range(Left : T_BOUND; Right : T_BOUND) return RANGE_RECORD;
  function dt_range(Right : T_BOUND; Left : T_BOUND) return RANGE_RECORD;
  
  -- property extraction functions
  function low(R : RANGE_RECORD) return T_BOUND;
  function high(R : RANGE_RECORD) return T_BOUND;
  function left(R : RANGE_RECORD) return T_BOUND;
  function right(R : RANGE_RECORD) return T_BOUND;
  function length(R : RANGE_RECORD) return INTEGER;
  function direction(R : RANGE_RECORD) return DIRECTION;
  function is_ascending(R : RANGE_RECORD) return BOOLEAN;
  function is_descending(R : RANGE_RECORD) return BOOLEAN;
  function is_nullrange(R : RANGE_RECORD) return BOOLEAN;
  function ascending(R : RANGE_RECORD) return RANGE_RECORD;
  function descending(R : RANGE_RECORD) return RANGE_RECORD;
  function reverse(R : RANGE_RECORD) return RANGE_RECORD;
  function offset(R : RANGE_RECORD) return INTEGER;
  function normalize(R : RANGE_RECORD) return RANGE_RECORD;
  function image(R : RANGE_RECORD) return STRING;
  
  -- not/complement operator to reverse the direction
  function "not"(RD : DIRECTION) return DIRECTION;
  -- alias "not" is reverse[RANGE_RECORD return RANGE_RECORD];
  
  -- relational operators / equality operators
  function "="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  function "?="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  function "/="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  function "?/="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  function "<"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  function "?<"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  function "<="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  function "?<="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  function ">"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  function "?>"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  function ">="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  function "?>="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  
  -- shift operators
  function "sll"(LHS : RANGE_RECORD; RHS : INTEGER) return RANGE_RECORD;
  function "srl"(LHS : RANGE_RECORD; RHS : INTEGER) return RANGE_RECORD;
  
  -- arithmetic operators
  function "+"(LHS : RANGE_RECORD; RHS : INTEGER) return RANGE_RECORD;
  function "-"(LHS : RANGE_RECORD; RHS : INTEGER) return RANGE_RECORD;
  function "*"(LHS : RANGE_RECORD; RHS : NATURAL) return RANGE_RECORD;
  function "/"(LHS : RANGE_RECORD; RHS : POSITIVE) return RANGE_RECORD;
  function "/"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return INTEGER;
  function "&"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return RANGE_RECORD;
  
  -- set operators
  function "and"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return RANGE_RECORD;
  function "and"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  function "or"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return RANGE_RECORD;
  function "or"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
  function "xor"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return RANGE_RECORD;
  function "xor"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN;
end package;


package body GenericDiscreteRanges is
  -- constructors
  function to_range(Left : T_BOUND; Right : T_BOUND) return RANGE_RECORD is
  begin
    return (
      Left => Left,
      Right => Left,
      Direction =>  ASCENDING
    );
  end function;
  
  function dt_range(Right : T_BOUND; Left : T_BOUND) return RANGE_RECORD is
  begin
    return (
      Left => Left,
      Right => Right,
      Direction =>  DESCENDING
    );
  end function;
  
  function sign(D : DIRECTION) return INTEGER is
  begin
    if (D = ASCENDING) then
      return 1;
    else
      return -1;
    end if;
  end function;

  function low(R : RANGE_RECORD) return T_BOUND is
  begin
    if (R.Direction = ASCENDING) then
      return R.Left;
    else
      return R.Right;
    end if;
  end function;
  
  function high(R : RANGE_RECORD) return T_BOUND is
  begin
    if (R.Direction = ASCENDING) then
      return R.Right;
    else
      return R.Left;
    end if;
  end function;
  
  function left(R : RANGE_RECORD) return T_BOUND is
  begin
    return R.Left;
  end function;
  
  function right(R : RANGE_RECORD) return T_BOUND is
  begin
    return R.Right;
  end function;
  
  function length(R : RANGE_RECORD) return INTEGER is
    constant Distance : INTEGER := T_BOUND'pos(R.Right) - T_BOUND'pos(R.Left);
  begin
    if (Distance >= 0) then
      return Distance + 1;
    else
      return Distance - 1;
    end if;
  end function;
  
  function direction(R : RANGE_RECORD) return DIRECTION is
  begin
    return R.Direction;
  end function;
  
  function is_ascending(R : RANGE_RECORD) return BOOLEAN is
  begin
    return (R.Direction = ASCENDING);
  end function;
  
  function is_descending(R : RANGE_RECORD) return BOOLEAN is
  begin
    return (R.Direction = DESCENDING);
  end function;
  
  function is_nullrange(R : RANGE_RECORD) return BOOLEAN is
  begin
    return (length(R) <= 0);
  end function;
  
  function ascending(R : RANGE_RECORD) return RANGE_RECORD is
  begin
    return (
      Left =>       R.Left,
      Right =>      R.Right,
      Direction =>  ASCENDING
    );
  end function;
  
  function descending(R : RANGE_RECORD) return RANGE_RECORD is
  begin
    return (
      Left =>       R.Left,
      Right =>      R.Right,
      Direction =>  DESCENDING
    );
  end function;
  
  function reverse(R : RANGE_RECORD) return RANGE_RECORD is
  begin
    return (
      Left =>       R.Left,
      Right =>      R.Right,
      Direction =>  not R.Direction
    );
  end function;
  
  function offset(R : RANGE_RECORD) return INTEGER is
  begin
    return T_BOUND'pos(R.Left);
  end function;
  
  function normalize(R : RANGE_RECORD) return RANGE_RECORD is
  begin
    return (
      Left =>       T_BOUND'val(0),
      Right =>      T_BOUND'val(length(R) - 1),
      Direction =>  R.Direction
    );
  end function;
  
  function image(R : RANGE_RECORD) return STRING is
    constant LowerImage : STRING  := T_BOUND'image(R.Left);
    constant UpperImage : STRING  := T_BOUND'image(R.Right);
  begin
    if (R.Direction = ASCENDING) then
      return LowerImage & " to "     & UpperImage;
    else
      return UpperImage & " downto " & LowerImage;
    end if;
  end function;
  
  function "not"(RD : DIRECTION) return DIRECTION is
  begin
    if (RD = ASCENDING) then
      return DESCENDING;
    else
      return ASCENDING;
    end if;
  end function;
  
  function "="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return ((LHS.Direction = RHS.Direction)
        and (LHS.Left = RHS.Left)
        and (LHS.Right = RHS.Right));
  end function;
  
  function "?="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return ((LHS.Left = RHS.Left)
        and (LHS.Right = RHS.Right));
  end function;
  
  function "/="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return not (LHS = RHS);
  end function;
  
  function "?/="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return not (LHS ?= RHS);
  end function;
  
  function "<"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return ((LHS.Direction = RHS.Direction)
        and (LHS.Left < RHS.Left)
        and (LHS.Right < RHS.Left));
  end function;
  
  function "?<"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return ((LHS.Left < RHS.Left)
        and (LHS.Right < RHS.Left));
  end function;
  
  function "<="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return ((LHS.Direction = RHS.Direction)
        and (LHS.Left <= RHS.Left)
        and (LHS.Right <= RHS.Right));
  end function;
  
  function "?<="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return ((LHS.Left <= RHS.Left)
        and (LHS.Right <= RHS.Right));
  end function;
  
  function ">"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return ((LHS.Direction = RHS.Direction)
        and (LHS.Left > RHS.Right)
        and (LHS.Right > RHS.Right));
  end function;
  
  function "?>"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return ((LHS.Left > RHS.Right)
        and (LHS.Right > RHS.Right));
  end function;
  
  function ">="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return ((LHS.Direction = RHS.Direction)
        and (LHS.Left >= RHS.Left)
        and (LHS.Right >= RHS.Right));
  end function;
  
  function "?>="(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return ((LHS.Left >= RHS.Left)
        and (LHS.Right >= RHS.Right));
  end function;
  
  
  function "sll"(LHS : RANGE_RECORD; RHS : INTEGER) return RANGE_RECORD is
    constant LowerPosition  : INTEGER := T_BOUND'pos(LHS.Left);
    constant UpperPosition  : INTEGER := T_BOUND'pos(LHS.Right);
    constant DirectionSign  : INTEGER := sign(not LHS.Direction);
  begin
    return (
      Left => T_BOUND'val(LowerPosition + (RHS * DirectionSign)),
      Right => T_BOUND'val(UpperPosition + (RHS * DirectionSign)),
      Direction =>  LHS.Direction
    );
  end function;
  
  function "srl"(LHS : RANGE_RECORD; RHS : INTEGER) return RANGE_RECORD is
  begin
    return LHS sll (-RHS);
  end function;
  
  
  function "+"(LHS : RANGE_RECORD; RHS : INTEGER) return RANGE_RECORD is
    constant UpperPosition  : INTEGER := T_BOUND'pos(LHS.Right);
  begin
    return (
      Left => LHS.Left,
      Right => T_BOUND'val(UpperPosition + RHS),
      Direction =>  LHS.Direction
    );
  end function;
  
  function "-"(LHS : RANGE_RECORD; RHS : INTEGER) return RANGE_RECORD is
  begin
    return LHS + (-RHS);
  end function;
  
  function "*"(LHS : RANGE_RECORD; RHS : NATURAL) return RANGE_RECORD is
    constant Offset : INTEGER := length(LHS) * (RHS - 1);
  begin
    return LHS + Offset;
  end function;
  
  function "/"(LHS : RANGE_RECORD; RHS : POSITIVE) return RANGE_RECORD is
    constant LowerPosition  : INTEGER := T_BOUND'pos(LHS.Left);
    constant len            : NATURAL := length(LHS) / RHS;
  begin
    return (
        Left => LHS.Left,
        Right => T_BOUND'val(LowerPosition + len - 1),
        Direction =>  LHS.Direction
      );
  end function;
  
  function "/"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return INTEGER is
  begin
    assert not is_nullrange(RHS)               report "RHS is an empty range."        severity FAILURE;
    assert ((length(LHS) mod length(RHS)) = 0) report "LHS is not a multiple of RHS." severity FAILURE;
    return length(LHS) / length(RHS);
  end function;
  
  function "&"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return RANGE_RECORD is
  begin
    return LHS + length(RHS);
  end function;
  
  -- Intersection
  -- -----------------------------------
  -- * Returns the range of LHS' and RHS' intersection range.
  -- * LHS' direction is preserved
  -- * If LHS and RHS have no overlap, a null range is created which spans the gap between both ranges
  function "and"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return RANGE_RECORD is
  begin
    if (LHS ?= RHS) then
      return LHS;
    elsif ((LHS.Left <= RHS.Left) and (LHS.Right >= RHS.Right)) then
      return (
        Left => RHS.Left,
        Right => RHS.Right,
        Direction =>  LHS.Direction
      );
    elsif ((LHS.Left >= RHS.Left) and (LHS.Right <= RHS.Right)) then
      return LHS;
    elsif (LHS ?< RHS) then  -- no overlap
      return (
        -- Left => T_BOUND'pred(RHS.Left),
        -- Right => T_BOUND'succ(LHS.Right),
        Left => RHS.Left,
        Right => LHS.Right,
        Direction =>  LHS.Direction
      );
    elsif (LHS ?> RHS) then  -- no overlap
      return (
        -- Left => T_BOUND'pred(LHS.Left),
        -- Right => T_BOUND'succ(RHS.Right),
        Left => LHS.Left,
        Right => RHS.Right,
        Direction =>  LHS.Direction
      );
    elsif (LHS ?<= RHS) then
      return (
        Left => RHS.Left,
        Right => LHS.Right,
        Direction =>  LHS.Direction
      );
    elsif (LHS ?>= RHS) then
      return (
        Left => LHS.Left,
        Right => RHS.Right,
        Direction =>  LHS.Direction
      );
    end if;
    report "This case should not be reached! LHS: " & image(LHS) & " RHS:" & image(RHS) severity ERROR;
  end function;
  
  function "and"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return not is_nullrange(LHS and RHS);
  end function;
  
  -- Union
  -- -----------------------------------
  -- * Returns the range of LHS' and RHS' union range.
  -- * LHS' direction is preserved
  -- * If LHS and RHS have no overlap, a null range is created which spans the gap between both ranges
  function "or"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return RANGE_RECORD is
  begin
    if (LHS ?= RHS) then
      return LHS;
    elsif ((LHS.Left <= RHS.Left) and (LHS.Right >= RHS.Right)) then
      return (
        Left => RHS.Left,
        Right => RHS.Right,
        Direction =>  LHS.Direction
      );
    elsif ((LHS.Left >= RHS.Left) and (LHS.Right <= RHS.Right)) then
      return LHS;
    elsif (LHS ?< RHS) then
      return (
        -- Left => T_BOUND'pred(RHS.Left),
        -- Right => T_BOUND'succ(LHS.Right),
        Left => RHS.Left,
        Right => LHS.Right,
        Direction =>  LHS.Direction
      );
    elsif (LHS ?> RHS) then
      return (
        -- Left => T_BOUND'pred(LHS.Left),
        -- Right => T_BOUND'succ(RHS.Right),
        Left => LHS.Left,
        Right => RHS.Right,
        Direction =>  LHS.Direction
      );
    elsif (LHS ?<= RHS) then
      return (
        Left => LHS.Left,
        Right => RHS.Right,
        Direction =>  LHS.Direction
      );
    elsif (LHS ?>= RHS) then
      return (
        Left => RHS.Left,
        Right => LHS.Right,
        Direction =>  LHS.Direction
      );
    end if;
    report "This case should not be reached! LHS: " & image(LHS) & " RHS:" & image(RHS) severity ERROR;
  end function;
  
  function "or"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return not is_nullrange(LHS or RHS);
  end function;
  
  -- Consecutive ranges
  -- -----------------------------------
  -- * Returns the range of LHS' and RHS' union range, if both ranges are consecutive.
  -- * Identical ranges create a null range
  -- * For non consecutive ranges, a null range is created which spans the gap between both ranges
  function "xor"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return RANGE_RECORD is
  begin
    if (LHS ?= RHS) then
      return (
        Left => LHS.Right,
        Right => LHS.Left,
        Direction =>  LHS.Direction
      );
    elsif (LHS ?< RHS) then
      if (T_BOUND'succ(LHS.Right) = RHS.Left) then
        return (
          Left => LHS.Left,
          Right => RHS.Right,
          Direction =>  LHS.Direction
        );
      else
        return (
          Left => T_BOUND'pred(RHS.Left),
          Right => T_BOUND'succ(LHS.Right),
          Direction =>  LHS.Direction
        );
      end if;
    elsif (LHS ?> RHS) then
      if (T_BOUND'succ(RHS.Right) = LHS.Left) then
        return (
          Left => RHS.Left,
          Right => LHS.Right,
          Direction =>  LHS.Direction
        );
      else
        return (
          Left => T_BOUND'pred(LHS.Left),
          Right => T_BOUND'succ(RHS.Right),
          Direction =>  LHS.Direction
        );
      end if;
    end if;
    report "This case should not be reached! LHS: " & image(LHS) & " RHS:" & image(RHS) severity ERROR;
  end function;
  
  function "xor"(LHS : RANGE_RECORD; RHS : RANGE_RECORD) return BOOLEAN is
  begin
    return not is_nullrange(LHS xor RHS);
  end function;
end package body;
