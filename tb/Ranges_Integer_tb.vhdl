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
-- Authors:					Patrick Lehmann
-- 
-- Package:					VHDL package for extended ranges expressed as records.
--
-- License:
-- ============================================================================
-- Copyright 2016 Patrick Lehmann - Dresden, Germany
-- 
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
--		http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- ============================================================================


library Paebbels;
use			Paebbels.Ranges.all;

entity ghdl is
end entity;

architecture test of ghdl is
	-- dummy types  and dummy conversion function
	type DUMMY_VECTOR is array(Paebbels.TypePackage.RangeType range <>) of BIT;
	function to_range(dummy : DUMMY_VECTOR) return Paebbels.Ranges.RANGE_RECORD is
	begin
		if dummy'ascending then
			return (
				LowerBound => dummy'low,
				UpperBound => dummy'high,
				Direction =>  ASCENDING
			);
		else
			return (
				LowerBound => dummy'low,
				UpperBound => dummy'high,
				Direction =>  DESCENDING
			);
		end if;
	end function;
	
	function print(R : RANGE_RECORD) return STRING is
		constant LowerImage : STRING  := RANGE_TYPE'image(R.LowerBound);
		constant UpperImage : STRING  := RANGE_TYPE'image(R.UpperBound);
	begin
		if is_nullrange(R) then
			if (R.Direction = ASCENDING) then
				return LowerImage & " nr " & UpperImage;
			else
				return UpperImage & " NR " & LowerImage;
			end if;
		else
			if (R.Direction = ASCENDING) then
				return LowerImage & " to " & UpperImage;
			else
				return UpperImage & " dt " & LowerImage;
			end if;
		end if;
	end function;
	
	alias Range_Type is Paebbels.TypePackage.RangeType;
	alias int_range  is Paebbels.Ranges.RANGE_RECORD;
	
	subtype ST_NUL is Range_Type range  3 to  0;
	subtype ST_0_1 is Range_Type range  0 to  1;
	subtype ST_0_3 is Range_Type range  0 to  3;
	subtype ST_0_7 is Range_Type range  0 to  7;
	subtype ST_011 is Range_Type range  0 to 11;
	subtype ST_015 is Range_Type range  0 to 15;
	subtype ST_031 is Range_Type range  0 to 31;
	subtype ST_4_7 is Range_Type range  4 to  7;
	subtype ST_411 is Range_Type range  4 to 11;
	subtype ST_811 is Range_Type range  8 to 11;
	subtype ST_815 is Range_Type range  8 to 15;
	subtype ST1215 is Range_Type range 12 to 15;

	subtype ST_3_0 is Range_Type range  3 downto  0;
	subtype ST_7_0 is Range_Type range  7 downto  0;
	subtype ST11_0 is Range_Type range 11 downto  0;
	subtype ST15_0 is Range_Type range 15 downto  0;
	subtype ST31_0 is Range_Type range 31 downto  0;
	subtype ST_7_4 is Range_Type range  7 downto  4;
	subtype ST11_4 is Range_Type range 11 downto  4;
	subtype ST11_8 is Range_Type range 11 downto  8;
	subtype ST15_8 is Range_Type range 15 downto  8;
	subtype ST1512 is Range_Type range 15 downto 12;

	constant C_NUL : DUMMY_VECTOR(ST_NUL) := (others => '0');
	constant C_0_1 : DUMMY_VECTOR(ST_0_1) := (others => '0');
	constant C_0_3 : DUMMY_VECTOR(ST_0_3) := (others => '0');
	constant C_0_7 : DUMMY_VECTOR(ST_0_7) := (others => '0');
	constant C_011 : DUMMY_VECTOR(ST_011) := (others => '0');
	constant C_015 : DUMMY_VECTOR(ST_015) := (others => '0');
	constant C_031 : DUMMY_VECTOR(ST_031) := (others => '0');
	constant C_4_7 : DUMMY_VECTOR(ST_4_7) := (others => '0');
	constant C_411 : DUMMY_VECTOR(ST_411) := (others => '0');
	constant C_811 : DUMMY_VECTOR(ST_811) := (others => '0');
	constant C_815 : DUMMY_VECTOR(ST_815) := (others => '0');
	constant C1215 : DUMMY_VECTOR(ST1215) := (others => '0');
	constant C_3_0 : DUMMY_VECTOR(ST_3_0) := (others => '0');
	constant C_7_0 : DUMMY_VECTOR(ST_7_0) := (others => '0');
	constant C11_0 : DUMMY_VECTOR(ST11_0) := (others => '0');
	constant C15_0 : DUMMY_VECTOR(ST15_0) := (others => '0');
	constant C31_0 : DUMMY_VECTOR(ST31_0) := (others => '0');
	constant C_7_4 : DUMMY_VECTOR(ST_7_4) := (others => '0');
	constant C11_4 : DUMMY_VECTOR(ST11_4) := (others => '0');
	constant C11_8 : DUMMY_VECTOR(ST11_8) := (others => '0');
	constant C15_8 : DUMMY_VECTOR(ST15_8) := (others => '0');
	constant C1512 : DUMMY_VECTOR(ST1512) := (others => '0');
	
	constant R_NUL : int_range	:= to_range(C_NUL);
	constant R_0_1 : int_range	:= to_range(C_0_1);
	constant R_0_3 : int_range	:= to_range(C_0_3);
	constant R_0_7 : int_range	:= to_range(C_0_7);
	constant R_011 : int_range	:= to_range(C_011);
	constant R_015 : int_range	:= to_range(C_015);
	constant R_031 : int_range	:= to_range(C_031);
	constant R_4_7 : int_range	:= to_range(C_4_7);
	constant R_411 : int_range	:= to_range(C_411);
	constant R_811 : int_range	:= to_range(C_811);
	constant R_815 : int_range	:= to_range(C_815);
	constant R1215 : int_range	:= to_range(C1215);
	constant R_3_0 : int_range	:= to_range(C_3_0);
	constant R_7_0 : int_range	:= to_range(C_7_0);
	constant R11_0 : int_range	:= to_range(C11_0);
	constant R15_0 : int_range	:= to_range(C15_0);
	constant R31_0 : int_range	:= to_range(C31_0);
	constant R_7_4 : int_range	:= to_range(C_7_4);
	constant R11_4 : int_range	:= to_range(C11_4);
	constant R11_8 : int_range	:= to_range(C11_8);
	constant R15_8 : int_range	:= to_range(C15_8);
	constant R1512 : int_range	:= to_range(C1512);

begin
	assert FALSE report "properties of    0 to 3       3 downto 0   11 downto 8   8 to 15" severity NOTE;
	assert FALSE report "-------------------------------------------------------------------" severity NOTE;
	assert FALSE report "low():           " & RANGE_TYPE'image(low(R_0_3)) &   "            " & RANGE_TYPE'image(low(R_3_0)) &   "            " & RANGE_TYPE'image(low(R11_8)) &   "             " & RANGE_TYPE'image(low(R_815))   severity NOTE;
	assert FALSE report "high():          " & RANGE_TYPE'image(high(R_0_3)) &  "            " & RANGE_TYPE'image(high(R_3_0)) &  "            " & RANGE_TYPE'image(high(R11_8)) &  "            " &  RANGE_TYPE'image(high(R_815))  severity NOTE;
	assert FALSE report "left():          " & RANGE_TYPE'image(left(R_0_3)) &  "            " & RANGE_TYPE'image(left(R_3_0)) &  "            " & RANGE_TYPE'image(left(R11_8)) &  "            " &  RANGE_TYPE'image(left(R_815))  severity NOTE;
	assert FALSE report "right():         " & RANGE_TYPE'image(right(R_0_3)) & "            " & RANGE_TYPE'image(right(R_3_0)) & "            " & RANGE_TYPE'image(right(R11_8)) & "             " & RANGE_TYPE'image(right(R_815)) severity NOTE;
	assert FALSE report "length():        " & INTEGER'image(length(R_0_3)) &   "            " & INTEGER'image(length(R_3_0)) &   "            " & INTEGER'image(length(R11_8)) &   "             " & INTEGER'image(length(R_815))   severity NOTE;
	assert FALSE report "direction():     " & RANGE_DIRECTION'image(direction(R_0_3)) & "    " & RANGE_DIRECTION'image(direction(R_3_0)) & "   " &   RANGE_DIRECTION'image(direction(R11_8)) & "    " &      RANGE_DIRECTION'image(direction(R_815)) severity NOTE;
	assert FALSE report "is_ascending():  " & BOOLEAN'image(is_ascending(R_0_3)) & "         " & BOOLEAN'image(is_ascending(R_3_0)) & "        " &   BOOLEAN'image(is_ascending(R11_8)) &      "         " & BOOLEAN'image(is_ascending(R_815)) severity NOTE;
	assert FALSE report "is_descending(): " & BOOLEAN'image(is_descending(R_0_3)) & "        " & BOOLEAN'image(is_descending(R_3_0)) & "         " & BOOLEAN'image(is_descending(R11_8)) &     "          " &  BOOLEAN'image(is_descending(R_815)) severity NOTE;
	assert FALSE report "is_nullrange():  " & BOOLEAN'image(is_nullrange(R_0_3)) &  "        " & BOOLEAN'image(is_nullrange(R_3_0)) &  "        " &  BOOLEAN'image(is_nullrange(R11_8)) &      "         " &  BOOLEAN'image(is_nullrange(R_815))  severity NOTE;
	assert FALSE report "ascending():     " & image(ascending(R_0_3)) &  "       " & image(ascending(R_3_0)) &  "       " & image(ascending(R11_8)) &  "       " & image(ascending(R_815))  severity NOTE;
	assert FALSE report "descending():    " & image(descending(R_0_3)) & "   " &     image(descending(R_3_0)) & "   " &     image(descending(R11_8)) & "   " &     image(descending(R_815)) severity NOTE;
	assert FALSE report "reverse():       " & image(reverse(R_0_3)) &    "   " &     image(reverse(R_3_0)) &    "       " & image(reverse(R11_8)) &    "       " & image(reverse(R_815))    severity NOTE;
	assert FALSE report "normalize():     " & image(normalize(R_0_3)) &  "       " & image(normalize(R_3_0)) &  "   " &     image(normalize(R11_8)) &  "    " &     image(normalize(R_815))  severity NOTE;
	assert FALSE report "image():         " & image(R_0_3) &             "       " & image(R_3_0) &             "   " &     image(R11_8) &             "   " &     image(R_815)             severity NOTE;
	assert FALSE report "" severity NOTE;
	assert FALSE report "is_nullrange(3 to 0): " & BOOLEAN'image(is_nullrange(R_NUL)) & "  length(3 to 0): " & INTEGER'image(length(R_NUL)) severity NOTE;
	assert FALSE report "" severity NOTE;
	assert FALSE report "           (0 to 3)    (3 dt 0)    (4 to 7)     (7 dt 4)    (8 to 11)    (11 dt 8)"      severity NOTE;
	assert FALSE report "=======================================================================================" severity NOTE;
	assert FALSE report "(0 to 3)     = " & BOOLEAN'image(R_0_3 = R_0_3) & "      = " & BOOLEAN'image(R_0_3 = R_3_0) &  "     = " & BOOLEAN'image(R_0_3 = R_4_7) &  "      = " & BOOLEAN'image(R_0_3 = R_7_4) &  "     = " & BOOLEAN'image(R_0_3 = R_811) &  "      = " & BOOLEAN'image(R_0_3 = R11_8)   severity NOTE;
	assert FALSE report "(3 dt 0)     = " & BOOLEAN'image(R_3_0 = R_0_3) &  "     = " & BOOLEAN'image(R_3_0 = R_3_0) & "      = " & BOOLEAN'image(R_3_0 = R_4_7) &  "      = " & BOOLEAN'image(R_3_0 = R_7_4) &  "     = " & BOOLEAN'image(R_3_0 = R_811) &  "      = " & BOOLEAN'image(R_3_0 = R11_8)   severity NOTE;
	assert FALSE report "(4 dt 7)     = " & BOOLEAN'image(R_4_7 = R_0_3) &  "     = " & BOOLEAN'image(R_4_7 = R_3_0) &  "     = " & BOOLEAN'image(R_4_7 = R_4_7) & "       = " & BOOLEAN'image(R_4_7 = R_7_4) &  "     = " & BOOLEAN'image(R_4_7 = R_811) &  "      = " & BOOLEAN'image(R_4_7 = R11_8)   severity NOTE;
	assert FALSE report "(7 dt 4)     = " & BOOLEAN'image(R_7_4 = R_0_3) &  "     = " & BOOLEAN'image(R_7_4 = R_3_0) &  "     = " & BOOLEAN'image(R_7_4 = R_4_7) &  "      = " & BOOLEAN'image(R_7_4 = R_7_4) & "      = " & BOOLEAN'image(R_7_4 = R_811) &  "      = " & BOOLEAN'image(R_7_4 = R11_8)   severity NOTE;
	assert FALSE report "(8 dt 11)    = " & BOOLEAN'image(R_811 = R_0_3) &  "     = " & BOOLEAN'image(R_811 = R_3_0) &  "     = " & BOOLEAN'image(R_811 = R_4_7) &  "      = " & BOOLEAN'image(R_811 = R_7_4) &  "     = " & BOOLEAN'image(R_811 = R_811) & "       = " & BOOLEAN'image(R_811 = R11_8)   severity NOTE;
	assert FALSE report "(11 dt 8)    = " & BOOLEAN'image(R11_8 = R_0_3) &  "     = " & BOOLEAN'image(R11_8 = R_3_0) &  "     = " & BOOLEAN'image(R11_8 = R_4_7) &  "      = " & BOOLEAN'image(R11_8 = R_7_4) &  "     = " & BOOLEAN'image(R11_8 = R_811) &  "      = " & BOOLEAN'image(R11_8 = R11_8)   severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "(0 to 3)    ?= " & BOOLEAN'image(R_0_3 ?= R_0_3) & "     ?= " & BOOLEAN'image(R_0_3 ?= R_3_0) & "     ?= " & BOOLEAN'image(R_0_3 ?= R_4_7) &  "     ?= " & BOOLEAN'image(R_0_3 ?= R_7_4) &  "    ?= " & BOOLEAN'image(R_0_3 ?= R_811) &  "     ?= " & BOOLEAN'image(R_0_3 ?= R11_8)   severity NOTE;
	assert FALSE report "(3 dt 0)    ?= " & BOOLEAN'image(R_3_0 ?= R_0_3) & "     ?= " & BOOLEAN'image(R_3_0 ?= R_3_0) & "     ?= " & BOOLEAN'image(R_3_0 ?= R_4_7) &  "     ?= " & BOOLEAN'image(R_3_0 ?= R_7_4) &  "    ?= " & BOOLEAN'image(R_3_0 ?= R_811) &  "     ?= " & BOOLEAN'image(R_3_0 ?= R11_8)   severity NOTE;
	assert FALSE report "(4 dt 7)    ?= " & BOOLEAN'image(R_4_7 ?= R_0_3) &  "    ?= " & BOOLEAN'image(R_4_7 ?= R_3_0) &  "    ?= " & BOOLEAN'image(R_4_7 ?= R_4_7) & "      ?= " & BOOLEAN'image(R_4_7 ?= R_7_4) & "     ?= " & BOOLEAN'image(R_4_7 ?= R_811) &  "     ?= " & BOOLEAN'image(R_4_7 ?= R11_8)   severity NOTE;
	assert FALSE report "(7 dt 4)    ?= " & BOOLEAN'image(R_7_4 ?= R_0_3) &  "    ?= " & BOOLEAN'image(R_7_4 ?= R_3_0) &  "    ?= " & BOOLEAN'image(R_7_4 ?= R_4_7) & "      ?= " & BOOLEAN'image(R_7_4 ?= R_7_4) & "     ?= " & BOOLEAN'image(R_7_4 ?= R_811) &  "     ?= " & BOOLEAN'image(R_7_4 ?= R11_8)   severity NOTE;
	assert FALSE report "(8 dt 11)   ?= " & BOOLEAN'image(R_811 ?= R_0_3) &  "    ?= " & BOOLEAN'image(R_811 ?= R_3_0) &  "    ?= " & BOOLEAN'image(R_811 ?= R_4_7) &  "     ?= " & BOOLEAN'image(R_811 ?= R_7_4) &  "    ?= " & BOOLEAN'image(R_811 ?= R_811) & "      ?= " & BOOLEAN'image(R_811 ?= R11_8)   severity NOTE;
	assert FALSE report "(11 dt 8)   ?= " & BOOLEAN'image(R11_8 ?= R_0_3) &  "    ?= " & BOOLEAN'image(R11_8 ?= R_3_0) &  "    ?= " & BOOLEAN'image(R11_8 ?= R_4_7) &  "     ?= " & BOOLEAN'image(R11_8 ?= R_7_4) &  "    ?= " & BOOLEAN'image(R11_8 ?= R_811) & "      ?= " & BOOLEAN'image(R11_8 ?= R11_8)   severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "(0 to 3)    /= " & BOOLEAN'image(R_0_3 /= R_0_3) & "    /= " & BOOLEAN'image(R_0_3 /= R_3_0) &  "     /= " & BOOLEAN'image(R_0_3 /= R_4_7) &  "     /= " & BOOLEAN'image(R_0_3 /= R_7_4) &  "    /= " & BOOLEAN'image(R_0_3 /= R_811) &  "     /= " & BOOLEAN'image(R_0_3 /= R11_8)   severity NOTE;
	assert FALSE report "(3 dt 0)    /= " & BOOLEAN'image(R_3_0 /= R_0_3) &  "     /= " & BOOLEAN'image(R_3_0 /= R_3_0) & "    /= " & BOOLEAN'image(R_3_0 /= R_4_7) &  "     /= " & BOOLEAN'image(R_3_0 /= R_7_4) &  "    /= " & BOOLEAN'image(R_3_0 /= R_811) &  "     /= " & BOOLEAN'image(R_3_0 /= R11_8)   severity NOTE;
	assert FALSE report "(4 dt 7)    /= " & BOOLEAN'image(R_4_7 /= R_0_3) &  "     /= " & BOOLEAN'image(R_4_7 /= R_3_0) &  "    /= " & BOOLEAN'image(R_4_7 /= R_4_7) & "      /= " & BOOLEAN'image(R_4_7 /= R_7_4) &  "    /= " & BOOLEAN'image(R_4_7 /= R_811) &  "     /= " & BOOLEAN'image(R_4_7 /= R11_8)   severity NOTE;
	assert FALSE report "(7 dt 4)    /= " & BOOLEAN'image(R_7_4 /= R_0_3) &  "     /= " & BOOLEAN'image(R_7_4 /= R_3_0) &  "    /= " & BOOLEAN'image(R_7_4 /= R_4_7) &  "     /= " & BOOLEAN'image(R_7_4 /= R_7_4) & "     /= " & BOOLEAN'image(R_7_4 /= R_811) &  "     /= " & BOOLEAN'image(R_7_4 /= R11_8)   severity NOTE;
	assert FALSE report "(8 dt 11)   /= " & BOOLEAN'image(R_811 /= R_0_3) &  "     /= " & BOOLEAN'image(R_811 /= R_3_0) &  "    /= " & BOOLEAN'image(R_811 /= R_4_7) &  "     /= " & BOOLEAN'image(R_811 /= R_7_4) &  "    /= " & BOOLEAN'image(R_811 /= R_811) & "      /= " & BOOLEAN'image(R_811 /= R11_8)   severity NOTE;
	assert FALSE report "(11 dt 8)   /= " & BOOLEAN'image(R11_8 /= R_0_3) &  "     /= " & BOOLEAN'image(R11_8 /= R_3_0) &  "    /= " & BOOLEAN'image(R11_8 /= R_4_7) &  "     /= " & BOOLEAN'image(R11_8 /= R_7_4) &  "    /= " & BOOLEAN'image(R11_8 /= R_811) &  "     /= " & BOOLEAN'image(R11_8 /= R11_8)   severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "(0 to 3)   ?/= " & BOOLEAN'image(R_0_3 ?/= R_0_3) & "   ?/= " & BOOLEAN'image(R_0_3 ?/= R_3_0) & "    ?/= " & BOOLEAN'image(R_0_3 ?/= R_4_7) &  "    ?/= " & BOOLEAN'image(R_0_3 ?= R_7_4) &  "   ?/= " & BOOLEAN'image(R_0_3 ?/= R_811) &  "    ?/= " & BOOLEAN'image(R_0_3 ?/= R11_8)   severity NOTE;
	assert FALSE report "(3 dt 0)   ?/= " & BOOLEAN'image(R_3_0 ?/= R_0_3) & "   ?/= " & BOOLEAN'image(R_3_0 ?/= R_3_0) & "    ?/= " & BOOLEAN'image(R_3_0 ?/= R_4_7) &  "    ?/= " & BOOLEAN'image(R_3_0 ?= R_7_4) &  "   ?/= " & BOOLEAN'image(R_3_0 ?/= R_811) &  "    ?/= " & BOOLEAN'image(R_3_0 ?/= R11_8)   severity NOTE;
	assert FALSE report "(4 dt 7)   ?/= " & BOOLEAN'image(R_4_7 ?/= R_0_3) &  "    ?/= " & BOOLEAN'image(R_4_7 ?/= R_3_0) &  "   ?/= " & BOOLEAN'image(R_4_7 ?/= R_4_7) & "     ?/= " & BOOLEAN'image(R_4_7 ?= R_7_4) & "    ?/= " & BOOLEAN'image(R_4_7 ?/= R_811) &  "    ?/= " & BOOLEAN'image(R_4_7 ?/= R11_8)   severity NOTE;
	assert FALSE report "(7 dt 4)   ?/= " & BOOLEAN'image(R_7_4 ?/= R_0_3) &  "    ?/= " & BOOLEAN'image(R_7_4 ?/= R_3_0) &  "   ?/= " & BOOLEAN'image(R_7_4 ?/= R_4_7) & "     ?/= " & BOOLEAN'image(R_7_4 ?= R_7_4) & "    ?/= " & BOOLEAN'image(R_7_4 ?/= R_811) &  "    ?/= " & BOOLEAN'image(R_7_4 ?/= R11_8)   severity NOTE;
	assert FALSE report "(8 dt 11)  ?/= " & BOOLEAN'image(R_811 ?/= R_0_3) &  "    ?/= " & BOOLEAN'image(R_811 ?/= R_3_0) &  "   ?/= " & BOOLEAN'image(R_811 ?/= R_4_7) &  "    ?/= " & BOOLEAN'image(R_811 ?= R_7_4) &  "   ?/= " & BOOLEAN'image(R_811 ?/= R_811) & "     ?/= " & BOOLEAN'image(R_811 ?/= R11_8)   severity NOTE;
	assert FALSE report "(11 dt 8)  ?/= " & BOOLEAN'image(R11_8 ?/= R_0_3) &  "    ?/= " & BOOLEAN'image(R11_8 ?/= R_3_0) &  "   ?/= " & BOOLEAN'image(R11_8 ?/= R_4_7) &  "    ?/= " & BOOLEAN'image(R11_8 ?= R_7_4) &  "   ?/= " & BOOLEAN'image(R11_8 ?/= R_811) & "     ?/= " & BOOLEAN'image(R11_8 ?/= R11_8)   severity NOTE;

	assert FALSE report "" severity NOTE;
	assert FALSE report "           (0 to 3)    (3 dt 0)    (4 to 7)     (7 dt 4)    (8 to 11)    (11 dt 8)"      severity NOTE;
	assert FALSE report "=======================================================================================" severity NOTE;
	assert FALSE report "(0 to 3)     < " & BOOLEAN'image(R_0_3 < R_0_3) & "      < " & BOOLEAN'image(R_0_3 < R_3_0) &  "     < " & BOOLEAN'image(R_0_3 < R_4_7) &  "      < " & BOOLEAN'image(R_0_3 < R_7_4) &  "     < " & BOOLEAN'image(R_0_3 < R_811) &  "      < " & BOOLEAN'image(R_0_3 < R11_8)   severity NOTE;
	assert FALSE report "(3 dt 0)     < " & BOOLEAN'image(R_3_0 < R_0_3) &  "     < " & BOOLEAN'image(R_3_0 < R_3_0) & "      < " & BOOLEAN'image(R_3_0 < R_4_7) &  "      < " & BOOLEAN'image(R_3_0 < R_7_4) &  "     < " & BOOLEAN'image(R_3_0 < R_811) &  "      < " & BOOLEAN'image(R_3_0 < R11_8)   severity NOTE;
	assert FALSE report "(4 dt 7)     < " & BOOLEAN'image(R_4_7 < R_0_3) &  "     < " & BOOLEAN'image(R_4_7 < R_3_0) &  "     < " & BOOLEAN'image(R_4_7 < R_4_7) & "       < " & BOOLEAN'image(R_4_7 < R_7_4) &  "     < " & BOOLEAN'image(R_4_7 < R_811) &  "      < " & BOOLEAN'image(R_4_7 < R11_8)   severity NOTE;
	assert FALSE report "(7 dt 4)     < " & BOOLEAN'image(R_7_4 < R_0_3) &  "     < " & BOOLEAN'image(R_7_4 < R_3_0) &  "     < " & BOOLEAN'image(R_7_4 < R_4_7) &  "      < " & BOOLEAN'image(R_7_4 < R_7_4) & "      < " & BOOLEAN'image(R_7_4 < R_811) &  "      < " & BOOLEAN'image(R_7_4 < R11_8)   severity NOTE;
	assert FALSE report "(8 dt 11)    < " & BOOLEAN'image(R_811 < R_0_3) &  "     < " & BOOLEAN'image(R_811 < R_3_0) &  "     < " & BOOLEAN'image(R_811 < R_4_7) &  "      < " & BOOLEAN'image(R_811 < R_7_4) &  "     < " & BOOLEAN'image(R_811 < R_811) & "       < " & BOOLEAN'image(R_811 < R11_8)   severity NOTE;
	assert FALSE report "(11 dt 8)    < " & BOOLEAN'image(R11_8 < R_0_3) &  "     < " & BOOLEAN'image(R11_8 < R_3_0) &  "     < " & BOOLEAN'image(R11_8 < R_4_7) &  "      < " & BOOLEAN'image(R11_8 < R_7_4) &  "     < " & BOOLEAN'image(R11_8 < R_811) &  "      < " & BOOLEAN'image(R11_8 < R11_8)   severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "(0 to 3)    ?< " & BOOLEAN'image(R_0_3 ?< R_0_3) & "     ?< " & BOOLEAN'image(R_0_3 ?< R_3_0) & "     ?< " & BOOLEAN'image(R_0_3 ?< R_4_7) &  "     ?< " & BOOLEAN'image(R_0_3 ?< R_7_4) &  "    ?< " & BOOLEAN'image(R_0_3 ?< R_811) &  "     ?< " & BOOLEAN'image(R_0_3 ?< R11_8)   severity NOTE;
	assert FALSE report "(3 dt 0)    ?< " & BOOLEAN'image(R_3_0 ?< R_0_3) & "     ?< " & BOOLEAN'image(R_3_0 ?< R_3_0) & "     ?< " & BOOLEAN'image(R_3_0 ?< R_4_7) &  "     ?< " & BOOLEAN'image(R_3_0 ?< R_7_4) &  "    ?< " & BOOLEAN'image(R_3_0 ?< R_811) &  "     ?< " & BOOLEAN'image(R_3_0 ?< R11_8)   severity NOTE;
	assert FALSE report "(4 dt 7)    ?< " & BOOLEAN'image(R_4_7 ?< R_0_3) &  "    ?< " & BOOLEAN'image(R_4_7 ?< R_3_0) &  "    ?< " & BOOLEAN'image(R_4_7 ?< R_4_7) & "      ?< " & BOOLEAN'image(R_4_7 ?< R_7_4) & "     ?< " & BOOLEAN'image(R_4_7 ?< R_811) &  "     ?< " & BOOLEAN'image(R_4_7 ?< R11_8)   severity NOTE;
	assert FALSE report "(7 dt 4)    ?< " & BOOLEAN'image(R_7_4 ?< R_0_3) &  "    ?< " & BOOLEAN'image(R_7_4 ?< R_3_0) &  "    ?< " & BOOLEAN'image(R_7_4 ?< R_4_7) & "      ?< " & BOOLEAN'image(R_7_4 ?< R_7_4) & "     ?< " & BOOLEAN'image(R_7_4 ?< R_811) &  "     ?< " & BOOLEAN'image(R_7_4 ?< R11_8)   severity NOTE;
	assert FALSE report "(8 dt 11)   ?< " & BOOLEAN'image(R_811 ?< R_0_3) &  "    ?< " & BOOLEAN'image(R_811 ?< R_3_0) &  "    ?< " & BOOLEAN'image(R_811 ?< R_4_7) &  "     ?< " & BOOLEAN'image(R_811 ?< R_7_4) &  "    ?< " & BOOLEAN'image(R_811 ?< R_811) & "      ?< " & BOOLEAN'image(R_811 ?< R11_8)   severity NOTE;
	assert FALSE report "(11 dt 8)   ?< " & BOOLEAN'image(R11_8 ?< R_0_3) &  "    ?< " & BOOLEAN'image(R11_8 ?< R_3_0) &  "    ?< " & BOOLEAN'image(R11_8 ?< R_4_7) &  "     ?< " & BOOLEAN'image(R11_8 ?< R_7_4) &  "    ?< " & BOOLEAN'image(R11_8 ?< R_811) & "      ?< " & BOOLEAN'image(R11_8 ?< R11_8)   severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "(0 to 3)    <= " & BOOLEAN'image(R_0_3 <= R_0_3) & "    <= " & BOOLEAN'image(R_0_3 <= R_3_0) &  "     <= " & BOOLEAN'image(R_0_3 <= R_4_7) &  "     <= " & BOOLEAN'image(R_0_3 <= R_7_4) &  "    <= " & BOOLEAN'image(R_0_3 <= R_811) &  "     <= " & BOOLEAN'image(R_0_3 <= R11_8)   severity NOTE;
	assert FALSE report "(3 dt 0)    <= " & BOOLEAN'image(R_3_0 <= R_0_3) &  "     <= " & BOOLEAN'image(R_3_0 <= R_3_0) & "    <= " & BOOLEAN'image(R_3_0 <= R_4_7) &  "     <= " & BOOLEAN'image(R_3_0 <= R_7_4) &  "    <= " & BOOLEAN'image(R_3_0 <= R_811) &  "     <= " & BOOLEAN'image(R_3_0 <= R11_8)   severity NOTE;
	assert FALSE report "(4 dt 7)    <= " & BOOLEAN'image(R_4_7 <= R_0_3) &  "     <= " & BOOLEAN'image(R_4_7 <= R_3_0) &  "    <= " & BOOLEAN'image(R_4_7 <= R_4_7) & "      <= " & BOOLEAN'image(R_4_7 <= R_7_4) &  "    <= " & BOOLEAN'image(R_4_7 <= R_811) &  "     <= " & BOOLEAN'image(R_4_7 <= R11_8)   severity NOTE;
	assert FALSE report "(7 dt 4)    <= " & BOOLEAN'image(R_7_4 <= R_0_3) &  "     <= " & BOOLEAN'image(R_7_4 <= R_3_0) &  "    <= " & BOOLEAN'image(R_7_4 <= R_4_7) &  "     <= " & BOOLEAN'image(R_7_4 <= R_7_4) & "     <= " & BOOLEAN'image(R_7_4 <= R_811) &  "     <= " & BOOLEAN'image(R_7_4 <= R11_8)   severity NOTE;
	assert FALSE report "(8 dt 11)   <= " & BOOLEAN'image(R_811 <= R_0_3) &  "     <= " & BOOLEAN'image(R_811 <= R_3_0) &  "    <= " & BOOLEAN'image(R_811 <= R_4_7) &  "     <= " & BOOLEAN'image(R_811 <= R_7_4) &  "    <= " & BOOLEAN'image(R_811 <= R_811) & "      <= " & BOOLEAN'image(R_811 <= R11_8)   severity NOTE;
	assert FALSE report "(11 dt 8)   <= " & BOOLEAN'image(R11_8 <= R_0_3) &  "     <= " & BOOLEAN'image(R11_8 <= R_3_0) &  "    <= " & BOOLEAN'image(R11_8 <= R_4_7) &  "     <= " & BOOLEAN'image(R11_8 <= R_7_4) &  "    <= " & BOOLEAN'image(R11_8 <= R_811) &  "     <= " & BOOLEAN'image(R11_8 <= R11_8)   severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "(0 to 3)   ?<= " & BOOLEAN'image(R_0_3 ?<= R_0_3) & "   ?<= " & BOOLEAN'image(R_0_3 ?<= R_3_0) & "    ?<= " & BOOLEAN'image(R_0_3 ?<= R_4_7) &  "    ?<= " & BOOLEAN'image(R_0_3 ?= R_7_4) &  "   ?<= " & BOOLEAN'image(R_0_3 ?<= R_811) &  "    ?<= " & BOOLEAN'image(R_0_3 ?<= R11_8)   severity NOTE;
	assert FALSE report "(3 dt 0)   ?<= " & BOOLEAN'image(R_3_0 ?<= R_0_3) & "   ?<= " & BOOLEAN'image(R_3_0 ?<= R_3_0) & "    ?<= " & BOOLEAN'image(R_3_0 ?<= R_4_7) &  "    ?<= " & BOOLEAN'image(R_3_0 ?= R_7_4) &  "   ?<= " & BOOLEAN'image(R_3_0 ?<= R_811) &  "    ?<= " & BOOLEAN'image(R_3_0 ?<= R11_8)   severity NOTE;
	assert FALSE report "(4 dt 7)   ?<= " & BOOLEAN'image(R_4_7 ?<= R_0_3) &  "    ?<= " & BOOLEAN'image(R_4_7 ?<= R_3_0) &  "   ?<= " & BOOLEAN'image(R_4_7 ?<= R_4_7) & "     ?<= " & BOOLEAN'image(R_4_7 ?= R_7_4) & "    ?<= " & BOOLEAN'image(R_4_7 ?<= R_811) &  "    ?<= " & BOOLEAN'image(R_4_7 ?<= R11_8)   severity NOTE;
	assert FALSE report "(7 dt 4)   ?<= " & BOOLEAN'image(R_7_4 ?<= R_0_3) &  "    ?<= " & BOOLEAN'image(R_7_4 ?<= R_3_0) &  "   ?<= " & BOOLEAN'image(R_7_4 ?<= R_4_7) & "     ?<= " & BOOLEAN'image(R_7_4 ?= R_7_4) & "    ?<= " & BOOLEAN'image(R_7_4 ?<= R_811) &  "    ?<= " & BOOLEAN'image(R_7_4 ?<= R11_8)   severity NOTE;
	assert FALSE report "(8 dt 11)  ?<= " & BOOLEAN'image(R_811 ?<= R_0_3) &  "    ?<= " & BOOLEAN'image(R_811 ?<= R_3_0) &  "   ?<= " & BOOLEAN'image(R_811 ?<= R_4_7) &  "    ?<= " & BOOLEAN'image(R_811 ?= R_7_4) &  "   ?<= " & BOOLEAN'image(R_811 ?<= R_811) & "     ?<= " & BOOLEAN'image(R_811 ?<= R11_8)   severity NOTE;
	assert FALSE report "(11 dt 8)  ?<= " & BOOLEAN'image(R11_8 ?<= R_0_3) &  "    ?<= " & BOOLEAN'image(R11_8 ?<= R_3_0) &  "   ?<= " & BOOLEAN'image(R11_8 ?<= R_4_7) &  "    ?<= " & BOOLEAN'image(R11_8 ?= R_7_4) &  "   ?<= " & BOOLEAN'image(R11_8 ?<= R_811) & "     ?<= " & BOOLEAN'image(R11_8 ?<= R11_8)   severity NOTE;

	assert FALSE report "" severity NOTE;
	assert FALSE report "           (0 to 3)    (3 dt 0)    (4 to 7)     (7 dt 4)    (8 to 11)    (11 dt 8)"      severity NOTE;
	assert FALSE report "=======================================================================================" severity NOTE;
	assert FALSE report "(0 to 3)     > " & BOOLEAN'image(R_0_3 > R_0_3) & "      > " & BOOLEAN'image(R_0_3 > R_3_0) &  "     > " & BOOLEAN'image(R_0_3 > R_4_7) &  "      > " & BOOLEAN'image(R_0_3 > R_7_4) &  "     > " & BOOLEAN'image(R_0_3 > R_811) &  "      > " & BOOLEAN'image(R_0_3 > R11_8)   severity NOTE;
	assert FALSE report "(3 dt 0)     > " & BOOLEAN'image(R_3_0 > R_0_3) &  "     > " & BOOLEAN'image(R_3_0 > R_3_0) & "      > " & BOOLEAN'image(R_3_0 > R_4_7) &  "      > " & BOOLEAN'image(R_3_0 > R_7_4) &  "     > " & BOOLEAN'image(R_3_0 > R_811) &  "      > " & BOOLEAN'image(R_3_0 > R11_8)   severity NOTE;
	assert FALSE report "(4 dt 7)     > " & BOOLEAN'image(R_4_7 > R_0_3) &  "     > " & BOOLEAN'image(R_4_7 > R_3_0) &  "     > " & BOOLEAN'image(R_4_7 > R_4_7) & "       > " & BOOLEAN'image(R_4_7 > R_7_4) &  "     > " & BOOLEAN'image(R_4_7 > R_811) &  "      > " & BOOLEAN'image(R_4_7 > R11_8)   severity NOTE;
	assert FALSE report "(7 dt 4)     > " & BOOLEAN'image(R_7_4 > R_0_3) &  "     > " & BOOLEAN'image(R_7_4 > R_3_0) &  "     > " & BOOLEAN'image(R_7_4 > R_4_7) &  "      > " & BOOLEAN'image(R_7_4 > R_7_4) & "      > " & BOOLEAN'image(R_7_4 > R_811) &  "      > " & BOOLEAN'image(R_7_4 > R11_8)   severity NOTE;
	assert FALSE report "(8 dt 11)    > " & BOOLEAN'image(R_811 > R_0_3) &  "     > " & BOOLEAN'image(R_811 > R_3_0) &  "     > " & BOOLEAN'image(R_811 > R_4_7) &  "      > " & BOOLEAN'image(R_811 > R_7_4) &  "     > " & BOOLEAN'image(R_811 > R_811) & "       > " & BOOLEAN'image(R_811 > R11_8)   severity NOTE;
	assert FALSE report "(11 dt 8)    > " & BOOLEAN'image(R11_8 > R_0_3) &  "     > " & BOOLEAN'image(R11_8 > R_3_0) &  "     > " & BOOLEAN'image(R11_8 > R_4_7) &  "      > " & BOOLEAN'image(R11_8 > R_7_4) &  "     > " & BOOLEAN'image(R11_8 > R_811) &  "      > " & BOOLEAN'image(R11_8 > R11_8)   severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "(0 to 3)    ?> " & BOOLEAN'image(R_0_3 ?> R_0_3) & "     ?> " & BOOLEAN'image(R_0_3 ?> R_3_0) & "     ?> " & BOOLEAN'image(R_0_3 ?> R_4_7) &  "     ?> " & BOOLEAN'image(R_0_3 ?> R_7_4) &  "    ?> " & BOOLEAN'image(R_0_3 ?> R_811) &  "     ?> " & BOOLEAN'image(R_0_3 ?> R11_8)   severity NOTE;
	assert FALSE report "(3 dt 0)    ?> " & BOOLEAN'image(R_3_0 ?> R_0_3) & "     ?> " & BOOLEAN'image(R_3_0 ?> R_3_0) & "     ?> " & BOOLEAN'image(R_3_0 ?> R_4_7) &  "     ?> " & BOOLEAN'image(R_3_0 ?> R_7_4) &  "    ?> " & BOOLEAN'image(R_3_0 ?> R_811) &  "     ?> " & BOOLEAN'image(R_3_0 ?> R11_8)   severity NOTE;
	assert FALSE report "(4 dt 7)    ?> " & BOOLEAN'image(R_4_7 ?> R_0_3) &  "    ?> " & BOOLEAN'image(R_4_7 ?> R_3_0) &  "    ?> " & BOOLEAN'image(R_4_7 ?> R_4_7) & "      ?> " & BOOLEAN'image(R_4_7 ?> R_7_4) & "     ?> " & BOOLEAN'image(R_4_7 ?> R_811) &  "     ?> " & BOOLEAN'image(R_4_7 ?> R11_8)   severity NOTE;
	assert FALSE report "(7 dt 4)    ?> " & BOOLEAN'image(R_7_4 ?> R_0_3) &  "    ?> " & BOOLEAN'image(R_7_4 ?> R_3_0) &  "    ?> " & BOOLEAN'image(R_7_4 ?> R_4_7) & "      ?> " & BOOLEAN'image(R_7_4 ?> R_7_4) & "     ?> " & BOOLEAN'image(R_7_4 ?> R_811) &  "     ?> " & BOOLEAN'image(R_7_4 ?> R11_8)   severity NOTE;
	assert FALSE report "(8 dt 11)   ?> " & BOOLEAN'image(R_811 ?> R_0_3) &  "    ?> " & BOOLEAN'image(R_811 ?> R_3_0) &  "    ?> " & BOOLEAN'image(R_811 ?> R_4_7) &  "     ?> " & BOOLEAN'image(R_811 ?> R_7_4) &  "    ?> " & BOOLEAN'image(R_811 ?> R_811) & "      ?> " & BOOLEAN'image(R_811 ?> R11_8)   severity NOTE;
	assert FALSE report "(11 dt 8)   ?> " & BOOLEAN'image(R11_8 ?> R_0_3) &  "    ?> " & BOOLEAN'image(R11_8 ?> R_3_0) &  "    ?> " & BOOLEAN'image(R11_8 ?> R_4_7) &  "     ?> " & BOOLEAN'image(R11_8 ?> R_7_4) &  "    ?> " & BOOLEAN'image(R11_8 ?> R_811) & "      ?> " & BOOLEAN'image(R11_8 ?> R11_8)   severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "(0 to 3)    >= " & BOOLEAN'image(R_0_3 >= R_0_3) & "    >= " & BOOLEAN'image(R_0_3 >= R_3_0) &  "     >= " & BOOLEAN'image(R_0_3 >= R_4_7) &  "     >= " & BOOLEAN'image(R_0_3 >= R_7_4) &  "    >= " & BOOLEAN'image(R_0_3 >= R_811) &  "     >= " & BOOLEAN'image(R_0_3 >= R11_8)   severity NOTE;
	assert FALSE report "(3 dt 0)    >= " & BOOLEAN'image(R_3_0 >= R_0_3) &  "     >= " & BOOLEAN'image(R_3_0 >= R_3_0) & "    >= " & BOOLEAN'image(R_3_0 >= R_4_7) &  "     >= " & BOOLEAN'image(R_3_0 >= R_7_4) &  "    >= " & BOOLEAN'image(R_3_0 >= R_811) &  "     >= " & BOOLEAN'image(R_3_0 >= R11_8)   severity NOTE;
	assert FALSE report "(4 dt 7)    >= " & BOOLEAN'image(R_4_7 >= R_0_3) &  "     >= " & BOOLEAN'image(R_4_7 >= R_3_0) &  "    >= " & BOOLEAN'image(R_4_7 >= R_4_7) & "      >= " & BOOLEAN'image(R_4_7 >= R_7_4) &  "    >= " & BOOLEAN'image(R_4_7 >= R_811) &  "     >= " & BOOLEAN'image(R_4_7 >= R11_8)   severity NOTE;
	assert FALSE report "(7 dt 4)    >= " & BOOLEAN'image(R_7_4 >= R_0_3) &  "     >= " & BOOLEAN'image(R_7_4 >= R_3_0) &  "    >= " & BOOLEAN'image(R_7_4 >= R_4_7) &  "     >= " & BOOLEAN'image(R_7_4 >= R_7_4) & "     >= " & BOOLEAN'image(R_7_4 >= R_811) &  "     >= " & BOOLEAN'image(R_7_4 >= R11_8)   severity NOTE;
	assert FALSE report "(8 dt 11)   >= " & BOOLEAN'image(R_811 >= R_0_3) &  "     >= " & BOOLEAN'image(R_811 >= R_3_0) &  "    >= " & BOOLEAN'image(R_811 >= R_4_7) &  "     >= " & BOOLEAN'image(R_811 >= R_7_4) &  "    >= " & BOOLEAN'image(R_811 >= R_811) & "      >= " & BOOLEAN'image(R_811 >= R11_8)   severity NOTE;
	assert FALSE report "(11 dt 8)   >= " & BOOLEAN'image(R11_8 >= R_0_3) &  "     >= " & BOOLEAN'image(R11_8 >= R_3_0) &  "    >= " & BOOLEAN'image(R11_8 >= R_4_7) &  "     >= " & BOOLEAN'image(R11_8 >= R_7_4) &  "    >= " & BOOLEAN'image(R11_8 >= R_811) &  "     >= " & BOOLEAN'image(R11_8 >= R11_8)   severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "(0 to 3)   ?>= " & BOOLEAN'image(R_0_3 ?>= R_0_3) & "   ?>= " & BOOLEAN'image(R_0_3 ?>= R_3_0) & "    ?>= " & BOOLEAN'image(R_0_3 ?>= R_4_7) &  "    ?>= " & BOOLEAN'image(R_0_3 ?= R_7_4) &  "   ?>= " & BOOLEAN'image(R_0_3 ?>= R_811) &  "    ?>= " & BOOLEAN'image(R_0_3 ?>= R11_8)   severity NOTE;
	assert FALSE report "(3 dt 0)   ?>= " & BOOLEAN'image(R_3_0 ?>= R_0_3) & "   ?>= " & BOOLEAN'image(R_3_0 ?>= R_3_0) & "    ?>= " & BOOLEAN'image(R_3_0 ?>= R_4_7) &  "    ?>= " & BOOLEAN'image(R_3_0 ?= R_7_4) &  "   ?>= " & BOOLEAN'image(R_3_0 ?>= R_811) &  "    ?>= " & BOOLEAN'image(R_3_0 ?>= R11_8)   severity NOTE;
	assert FALSE report "(4 dt 7)   ?>= " & BOOLEAN'image(R_4_7 ?>= R_0_3) &  "    ?>= " & BOOLEAN'image(R_4_7 ?>= R_3_0) &  "   ?>= " & BOOLEAN'image(R_4_7 ?>= R_4_7) & "     ?>= " & BOOLEAN'image(R_4_7 ?= R_7_4) & "    ?>= " & BOOLEAN'image(R_4_7 ?>= R_811) &  "    ?>= " & BOOLEAN'image(R_4_7 ?>= R11_8)   severity NOTE;
	assert FALSE report "(7 dt 4)   ?>= " & BOOLEAN'image(R_7_4 ?>= R_0_3) &  "    ?>= " & BOOLEAN'image(R_7_4 ?>= R_3_0) &  "   ?>= " & BOOLEAN'image(R_7_4 ?>= R_4_7) & "     ?>= " & BOOLEAN'image(R_7_4 ?= R_7_4) & "    ?>= " & BOOLEAN'image(R_7_4 ?>= R_811) &  "    ?>= " & BOOLEAN'image(R_7_4 ?>= R11_8)   severity NOTE;
	assert FALSE report "(8 dt 11)  ?>= " & BOOLEAN'image(R_811 ?>= R_0_3) &  "    ?>= " & BOOLEAN'image(R_811 ?>= R_3_0) &  "   ?>= " & BOOLEAN'image(R_811 ?>= R_4_7) &  "    ?>= " & BOOLEAN'image(R_811 ?= R_7_4) &  "   ?>= " & BOOLEAN'image(R_811 ?>= R_811) & "     ?>= " & BOOLEAN'image(R_811 ?>= R11_8)   severity NOTE;
	assert FALSE report "(11 dt 8)  ?>= " & BOOLEAN'image(R11_8 ?>= R_0_3) &  "    ?>= " & BOOLEAN'image(R11_8 ?>= R_3_0) &  "   ?>= " & BOOLEAN'image(R11_8 ?>= R_4_7) &  "    ?>= " & BOOLEAN'image(R11_8 ?= R_7_4) &  "   ?>= " & BOOLEAN'image(R11_8 ?>= R_811) & "     ?>= " & BOOLEAN'image(R11_8 ?>= R11_8)   severity NOTE;
	assert FALSE report "" severity NOTE;
	assert FALSE report " shifts   |   sll 4      sll -4     srl 4     srl -4"          severity NOTE;
	assert FALSE report "=======================================================================" severity NOTE;
	assert FALSE report "(0 to  3) | " &  print(R_0_3 sll 4) & "    " &  print(R_0_3 sll -4) & "     " & print(R_0_3 srl 4) & "   " &  print(R_0_3 srl -4) severity NOTE;
	assert FALSE report "(3 dt  0) |  " & print(R_3_0 sll 4) & "    " &  print(R_3_0 sll -4) & "   " &   print(R_3_0 srl 4) & "   " &  print(R_3_0 srl -4) severity NOTE;
	assert FALSE report "(4 dt  7) |  " & print(R_4_7 sll 4) & "     " &  print(R_4_7 sll -4) & "    " &  print(R_4_7 srl 4) & "   " &  print(R_4_7 srl -4) severity NOTE;
	assert FALSE report "(7 dt  4) | " &  print(R_7_4 sll 4) & "     " & print(R_7_4 sll -4) & "     " & print(R_7_4 srl 4) & "   " &  print(R_7_4 srl -4) severity NOTE;
	assert FALSE report "(8 dt 11) |  " & print(R_811 sll 4) & "    " &  print(R_811 sll -4) &  "   " &  print(R_811 srl 4) &  "   " & print(R_811 srl -4) severity NOTE;
	assert FALSE report "(11 dt 8) | " &  print(R11_8 sll 4) &  "    " & print(R11_8 sll -4) &  "     " & print(R11_8 srl 4) &  "   " & print(R11_8 srl -4) severity NOTE;
	
	assert FALSE report "" severity NOTE;
	assert FALSE report "              + 4      + (-4)     - 4        - (-4)"          severity NOTE;
	assert FALSE report "=======================================================================" severity NOTE;
	assert FALSE report "(0 to 3)    " &  print(R_0_3 + 4) & "    " &  print(R_0_3 + (-4)) & "   " & print(R_0_3 - 4) & "   " &  print(R_0_3 - (-4)) severity NOTE;
	assert FALSE report "(3 dt 0)    " & print(R_3_0 + 4) & "   " &      print(R_3_0 + (-4)) & "   " &       print(R_3_0 - 4) & "    " &      print(R_3_0 - (-4)) severity NOTE;
	assert FALSE report "(4 dt 7)    " & print(R_4_7 + 4) & "   " & print(R_4_7 + (-4)) & "    " &  print(R_4_7 - 4) & "    " &  print(R_4_7 - (-4)) severity NOTE;
	assert FALSE report "(7 dt 4)   " &  print(R_7_4 + 4) & "    " &     print(R_7_4 + (-4)) & "    " &     print(R_7_4 - 4) & "   " &      print(R_7_4 - (-4)) severity NOTE;
	assert FALSE report "(8 dt 11)   " & print(R_811 + 4) & "   " &  print(R_811 + (-4)) &  "    " &  print(R_811 - 4) &  "    " & print(R_811 - (-4)) severity NOTE;
	assert FALSE report "(11 dt 8)  " &  print(R11_8 + 4) &  "    " &     print(R11_8 + (-4)) &  "    " &    print(R11_8 - 4) &  "   " &     print(R11_8 - (-4)) severity NOTE;
	
	assert FALSE report "" severity NOTE;
	assert FALSE report "              * 4       / 2    / (0 to 1)  & (4 to 7)"          severity NOTE;
	assert FALSE report "=======================================================================" severity NOTE;
	assert FALSE report "(0 to 3)    " &  print(R_0_3 * 4) & "   " & print(R_0_3 / 2) & "   " & INTEGER'image(R_0_3 / R_0_1) & "          " & print(R_0_3 & R_4_7) severity NOTE;
	assert FALSE report "(3 dt 0)   " & print(R_3_0 * 4) & "    " &       print(R_3_0 / 2) & "   " &       INTEGER'image(R_3_0 / R_0_1) & "          " & print(R_3_0 & R_4_7) severity NOTE;
	assert FALSE report "(4 dt 7)    " & print(R_4_7 * 4) & "   " &  print(R_4_7 / 2) & "   " &  INTEGER'image(R_4_7 / R_0_1) & "          " & print(R_4_7 & R_4_7) severity NOTE;
	assert FALSE report "(7 dt 4)   " &  print(R_7_4 * 4) & "    " &     print(R_7_4 / 2) & "   " &     INTEGER'image(R_7_4 / R_0_1) & "          " & print(R_7_4 & R_4_7) severity NOTE;
	assert FALSE report "(8 dt 11)   " & print(R_811 * 4) & "   " &  print(R_811 / 2) & "   " &  INTEGER'image(R_811 / R_0_1) & "          " & print(R_811 & R_4_7) severity NOTE;
	assert FALSE report "(11 dt 8)  " &  print(R11_8 * 4) &  "    " &    print(R11_8 / 2) &  "   " &    INTEGER'image(R11_8 / R_0_1) &  "          " & print(R11_8 & R_4_7) severity NOTE;
	
	assert FALSE report "" severity NOTE;
	assert FALSE report " and      (0 to 3)  (0 to 7)  (0 to 11)  (4 to 7)   (4 to 11)  (8 to 11)"      severity NOTE;
	assert FALSE report "=======================================================================================" severity NOTE;
	assert FALSE report "(0 to  3)  " & print(R_0_3 and R_0_3) & "    " & print(R_0_3 and R_0_7) & "    " & print(R_0_3 and R_011) & "     " & print(R_0_3 and R_4_7) & "      " & print(R_0_3 and R_411) & "    " & print(R_0_3 and R_811)  severity NOTE;
	assert FALSE report "(0 to  7)  " & print(R_0_7 and R_0_3) & "    " & print(R_0_7 and R_0_7) & "    " & print(R_0_7 and R_011) & "     " & print(R_0_7 and R_4_7) & "      " & print(R_0_7 and R_411) & "    " & print(R_0_7 and R_811)  severity NOTE;
	assert FALSE report "(0 to 11)  " & print(R_011 and R_0_3) & "    " & print(R_011 and R_0_7) & "    " & print(R_011 and R_011) & "     " & print(R_011 and R_4_7) & "      " & print(R_011 and R_411) & "    " & print(R_011 and R_811)  severity NOTE;
	assert FALSE report "(4 to  7)  " & print(R_4_7 and R_0_3) & "    " & print(R_4_7 and R_0_7) & "    " & print(R_4_7 and R_011) & "     " & print(R_4_7 and R_4_7) & "      " & print(R_4_7 and R_411) & "    " & print(R_4_7 and R_811)  severity NOTE;
	assert FALSE report "(4 to 11)  " & print(R_411 and R_0_3) & "    " & print(R_411 and R_0_7) & "    " & print(R_411 and R_011) & "     " & print(R_411 and R_4_7) & "      " & print(R_411 and R_411) & "    " & print(R_411 and R_811)  severity NOTE;
	assert FALSE report "(8 to 11)  " & print(R_811 and R_0_3) & "    " & print(R_811 and R_0_7) & "    " & print(R_811 and R_011) & "     " & print(R_811 and R_4_7) & "      " & print(R_811 and R_411) & "    " & print(R_811 and R_811)  severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "( 3 dt 0)  " & print(R_3_0 and R_0_3) & "    " & print(R_3_0 and R_0_7) & "    " & print(R_3_0 and R_011) & "     " & print(R_3_0 and R_4_7) & "      " & print(R_3_0 and R_411) & "    " & print(R_3_0 and R_811)  severity NOTE;
	assert FALSE report "( 7 dt 0)  " & print(R_7_0 and R_0_3) & "    " & print(R_7_0 and R_0_7) & "    " & print(R_7_0 and R_011) & "     " & print(R_7_0 and R_4_7) & "      " & print(R_7_0 and R_411) & "    " & print(R_7_0 and R_811)  severity NOTE;
	assert FALSE report "(11 dt 0)  " & print(R11_0 and R_0_3) & "    " & print(R11_0 and R_0_7) & "    " & print(R11_0 and R_011) & "     " & print(R11_0 and R_4_7) & "      " & print(R11_0 and R_411) & "    " & print(R11_0 and R_811)  severity NOTE;
	assert FALSE report "( 7 dt 4)  " & print(R_7_4 and R_0_3) & "    " & print(R_7_4 and R_0_7) & "    " & print(R_7_4 and R_011) & "     " & print(R_7_4 and R_4_7) & "      " & print(R_7_4 and R_411) & "    " & print(R_7_4 and R_811)  severity NOTE;
	assert FALSE report "(11 dt 4)  " & print(R11_4 and R_0_3) & "    " & print(R11_4 and R_0_7) & "    " & print(R11_4 and R_011) & "     " & print(R11_4 and R_4_7) & "      " & print(R11_4 and R_411) & "    " & print(R11_4 and R_811)  severity NOTE;
	assert FALSE report "(11 dt 8)  " & print(R11_8 and R_0_3) & "    " & print(R11_8 and R_0_7) & "    " & print(R11_8 and R_011) & "     " & print(R11_8 and R_4_7) & "      " & print(R11_8 and R_411) & "    " & print(R11_8 and R_811)  severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report " cont.    (3 dt 0)  (7 dt 0)  (11 dt 0)  (7 dt 4)   (11 dt 4)  (11 dt 8)"      severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "(0 to  3)  " & print(R_0_3 and R_3_0) & "    " & print(R_0_3 and R_7_0) & "    " & print(R_0_3 and R11_0) & "     " & print(R_0_3 and R_7_4) & "      " & print(R_0_3 and R11_4) & "    " & print(R_0_3 and R11_8)  severity NOTE;
	assert FALSE report "(0 to  7)  " & print(R_0_7 and R_3_0) & "    " & print(R_0_7 and R_7_0) & "    " & print(R_0_7 and R11_0) & "     " & print(R_0_7 and R_7_4) & "      " & print(R_0_7 and R11_4) & "    " & print(R_0_7 and R11_8)  severity NOTE;
	assert FALSE report "(0 to 11)  " & print(R_011 and R_3_0) & "    " & print(R_011 and R_7_0) & "    " & print(R_011 and R11_0) & "     " & print(R_011 and R_7_4) & "      " & print(R_011 and R11_4) & "    " & print(R_011 and R11_8)  severity NOTE;
	assert FALSE report "(4 to  7)  " & print(R_4_7 and R_3_0) & "    " & print(R_4_7 and R_7_0) & "    " & print(R_4_7 and R11_0) & "     " & print(R_4_7 and R_7_4) & "      " & print(R_4_7 and R11_4) & "    " & print(R_4_7 and R11_8)  severity NOTE;
	assert FALSE report "(4 to 11)  " & print(R_411 and R_3_0) & "    " & print(R_411 and R_7_0) & "    " & print(R_411 and R11_0) & "     " & print(R_411 and R_7_4) & "      " & print(R_411 and R11_4) & "    " & print(R_411 and R11_8)  severity NOTE;
	assert FALSE report "(8 to 11)  " & print(R_811 and R_3_0) & "    " & print(R_811 and R_7_0) & "    " & print(R_811 and R11_0) & "     " & print(R_811 and R_7_4) & "      " & print(R_811 and R11_4) & "    " & print(R_811 and R11_8)  severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "( 3 dt 0)  " & print(R_3_0 and R_3_0) & "    " & print(R_3_0 and R_7_0) & "    " & print(R_3_0 and R11_0) & "     " & print(R_3_0 and R_7_4) & "      " & print(R_3_0 and R11_4) & "    " & print(R_3_0 and R11_8)  severity NOTE;
	assert FALSE report "( 7 dt 0)  " & print(R_7_0 and R_3_0) & "    " & print(R_7_0 and R_7_0) & "    " & print(R_7_0 and R11_0) & "     " & print(R_7_0 and R_7_4) & "      " & print(R_7_0 and R11_4) & "    " & print(R_7_0 and R11_8)  severity NOTE;
	assert FALSE report "(11 dt 0)  " & print(R11_0 and R_3_0) & "    " & print(R11_0 and R_7_0) & "    " & print(R11_0 and R11_0) & "     " & print(R11_0 and R_7_4) & "      " & print(R11_0 and R11_4) & "    " & print(R11_0 and R11_8)  severity NOTE;
	assert FALSE report "( 7 dt 4)  " & print(R_7_4 and R_3_0) & "    " & print(R_7_4 and R_7_0) & "    " & print(R_7_4 and R11_0) & "     " & print(R_7_4 and R_7_4) & "      " & print(R_7_4 and R11_4) & "    " & print(R_7_4 and R11_8)  severity NOTE;
	assert FALSE report "(11 dt 4)  " & print(R11_4 and R_3_0) & "    " & print(R11_4 and R_7_0) & "    " & print(R11_4 and R11_0) & "     " & print(R11_4 and R_7_4) & "      " & print(R11_4 and R11_4) & "    " & print(R11_4 and R11_8)  severity NOTE;
	assert FALSE report "(11 dt 8)  " & print(R11_8 and R_3_0) & "    " & print(R11_8 and R_7_0) & "    " & print(R11_8 and R11_0) & "     " & print(R11_8 and R_7_4) & "      " & print(R11_8 and R11_4) & "    " & print(R11_8 and R11_8)  severity NOTE;

	assert FALSE report "" severity NOTE;
	assert FALSE report " or       (0 to 3)  (0 to 7)  (0 to 11)  (4 to 7)   (4 to 11)  (8 to 11)"      severity NOTE;
	assert FALSE report "=======================================================================================" severity NOTE;
	assert FALSE report "(0 to  3)  " & print(R_0_3 or R_0_3) & "    " & print(R_0_3 or R_0_7) & "    " & print(R_0_3 or R_011) & "     " & print(R_0_3 or R_4_7) & "      " & print(R_0_3 or R_411) & "    " & print(R_0_3 or R_811)  severity NOTE;
	assert FALSE report "(0 to  7)  " & print(R_0_7 or R_0_3) & "    " & print(R_0_7 or R_0_7) & "    " & print(R_0_7 or R_011) & "     " & print(R_0_7 or R_4_7) & "      " & print(R_0_7 or R_411) & "    " & print(R_0_7 or R_811)  severity NOTE;
	assert FALSE report "(0 to 11)  " & print(R_011 or R_0_3) & "    " & print(R_011 or R_0_7) & "    " & print(R_011 or R_011) & "     " & print(R_011 or R_4_7) & "      " & print(R_011 or R_411) & "    " & print(R_011 or R_811)  severity NOTE;
	assert FALSE report "(4 to  7)  " & print(R_4_7 or R_0_3) & "    " & print(R_4_7 or R_0_7) & "    " & print(R_4_7 or R_011) & "     " & print(R_4_7 or R_4_7) & "      " & print(R_4_7 or R_411) & "    " & print(R_4_7 or R_811)  severity NOTE;
	assert FALSE report "(4 to 11)  " & print(R_411 or R_0_3) & "    " & print(R_411 or R_0_7) & "    " & print(R_411 or R_011) & "     " & print(R_411 or R_4_7) & "      " & print(R_411 or R_411) & "    " & print(R_411 or R_811)  severity NOTE;
	assert FALSE report "(8 to 11)  " & print(R_811 or R_0_3) & "    " & print(R_811 or R_0_7) & "    " & print(R_811 or R_011) & "     " & print(R_811 or R_4_7) & "      " & print(R_811 or R_411) & "    " & print(R_811 or R_811)  severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "( 3 dt 0)  " & print(R_3_0 or R_0_3) & "    " & print(R_3_0 or R_0_7) & "    " & print(R_3_0 or R_011) & "     " & print(R_3_0 or R_4_7) & "      " & print(R_3_0 or R_411) & "    " & print(R_3_0 or R_811)  severity NOTE;
	assert FALSE report "( 7 dt 0)  " & print(R_7_0 or R_0_3) & "    " & print(R_7_0 or R_0_7) & "    " & print(R_7_0 or R_011) & "     " & print(R_7_0 or R_4_7) & "      " & print(R_7_0 or R_411) & "    " & print(R_7_0 or R_811)  severity NOTE;
	assert FALSE report "(11 dt 0)  " & print(R11_0 or R_0_3) & "    " & print(R11_0 or R_0_7) & "    " & print(R11_0 or R_011) & "     " & print(R11_0 or R_4_7) & "      " & print(R11_0 or R_411) & "    " & print(R11_0 or R_811)  severity NOTE;
	assert FALSE report "( 7 dt 4)  " & print(R_7_4 or R_0_3) & "    " & print(R_7_4 or R_0_7) & "    " & print(R_7_4 or R_011) & "     " & print(R_7_4 or R_4_7) & "      " & print(R_7_4 or R_411) & "    " & print(R_7_4 or R_811)  severity NOTE;
	assert FALSE report "(11 dt 4)  " & print(R11_4 or R_0_3) & "    " & print(R11_4 or R_0_7) & "    " & print(R11_4 or R_011) & "     " & print(R11_4 or R_4_7) & "      " & print(R11_4 or R_411) & "    " & print(R11_4 or R_811)  severity NOTE;
	assert FALSE report "(11 dt 8)  " & print(R11_8 or R_0_3) & "    " & print(R11_8 or R_0_7) & "    " & print(R11_8 or R_011) & "     " & print(R11_8 or R_4_7) & "      " & print(R11_8 or R_411) & "    " & print(R11_8 or R_811)  severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report " cont.    (3 dt 0)  (7 dt 0)  (11 dt 0)  (7 dt 4)   (11 dt 4)  (11 dt 8)"      severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "(0 to  3)  " & print(R_0_3 or R_3_0) & "    " & print(R_0_3 or R_7_0) & "    " & print(R_0_3 or R11_0) & "     " & print(R_0_3 or R_7_4) & "      " & print(R_0_3 or R11_4) & "    " & print(R_0_3 or R11_8)  severity NOTE;
	assert FALSE report "(0 to  7)  " & print(R_0_7 or R_3_0) & "    " & print(R_0_7 or R_7_0) & "    " & print(R_0_7 or R11_0) & "     " & print(R_0_7 or R_7_4) & "      " & print(R_0_7 or R11_4) & "    " & print(R_0_7 or R11_8)  severity NOTE;
	assert FALSE report "(0 to 11)  " & print(R_011 or R_3_0) & "    " & print(R_011 or R_7_0) & "    " & print(R_011 or R11_0) & "     " & print(R_011 or R_7_4) & "      " & print(R_011 or R11_4) & "    " & print(R_011 or R11_8)  severity NOTE;
	assert FALSE report "(4 to  7)  " & print(R_4_7 or R_3_0) & "    " & print(R_4_7 or R_7_0) & "    " & print(R_4_7 or R11_0) & "     " & print(R_4_7 or R_7_4) & "      " & print(R_4_7 or R11_4) & "    " & print(R_4_7 or R11_8)  severity NOTE;
	assert FALSE report "(4 to 11)  " & print(R_411 or R_3_0) & "    " & print(R_411 or R_7_0) & "    " & print(R_411 or R11_0) & "     " & print(R_411 or R_7_4) & "      " & print(R_411 or R11_4) & "    " & print(R_411 or R11_8)  severity NOTE;
	assert FALSE report "(8 to 11)  " & print(R_811 or R_3_0) & "    " & print(R_811 or R_7_0) & "    " & print(R_811 or R11_0) & "     " & print(R_811 or R_7_4) & "      " & print(R_811 or R11_4) & "    " & print(R_811 or R11_8)  severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "( 3 dt 0)  " & print(R_3_0 or R_3_0) & "    " & print(R_3_0 or R_7_0) & "    " & print(R_3_0 or R11_0) & "     " & print(R_3_0 or R_7_4) & "      " & print(R_3_0 or R11_4) & "    " & print(R_3_0 or R11_8)  severity NOTE;
	assert FALSE report "( 7 dt 0)  " & print(R_7_0 or R_3_0) & "    " & print(R_7_0 or R_7_0) & "    " & print(R_7_0 or R11_0) & "     " & print(R_7_0 or R_7_4) & "      " & print(R_7_0 or R11_4) & "    " & print(R_7_0 or R11_8)  severity NOTE;
	assert FALSE report "(11 dt 0)  " & print(R11_0 or R_3_0) & "    " & print(R11_0 or R_7_0) & "    " & print(R11_0 or R11_0) & "     " & print(R11_0 or R_7_4) & "      " & print(R11_0 or R11_4) & "    " & print(R11_0 or R11_8)  severity NOTE;
	assert FALSE report "( 7 dt 4)  " & print(R_7_4 or R_3_0) & "    " & print(R_7_4 or R_7_0) & "    " & print(R_7_4 or R11_0) & "     " & print(R_7_4 or R_7_4) & "      " & print(R_7_4 or R11_4) & "    " & print(R_7_4 or R11_8)  severity NOTE;
	assert FALSE report "(11 dt 4)  " & print(R11_4 or R_3_0) & "    " & print(R11_4 or R_7_0) & "    " & print(R11_4 or R11_0) & "     " & print(R11_4 or R_7_4) & "      " & print(R11_4 or R11_4) & "    " & print(R11_4 or R11_8)  severity NOTE;
	assert FALSE report "(11 dt 8)  " & print(R11_8 or R_3_0) & "    " & print(R11_8 or R_7_0) & "    " & print(R11_8 or R11_0) & "     " & print(R11_8 or R_7_4) & "      " & print(R11_8 or R11_4) & "    " & print(R11_8 or R11_8)  severity NOTE;

	assert FALSE report "" severity NOTE;
	assert FALSE report " xor      (0 to 3)  (0 to 7)  (0 to 11)  (4 to 7)   (4 to 11)  (8 to 11)"      severity NOTE;
	assert FALSE report "=======================================================================================" severity NOTE;
	assert FALSE report "(0 to  3)  " & print(R_0_3 xor R_0_3) & "    " & print(R_0_3 xor R_0_7) & "    " & print(R_0_3 xor R_011) & "     " & print(R_0_3 xor R_4_7) & "      " & print(R_0_3 xor R_411) & "    " & print(R_0_3 xor R_811)  severity NOTE;
	assert FALSE report "(0 to  7)  " & print(R_0_7 xor R_0_3) & "    " & print(R_0_7 xor R_0_7) & "    " & print(R_0_7 xor R_011) & "     " & print(R_0_7 xor R_4_7) & "      " & print(R_0_7 xor R_411) & "    " & print(R_0_7 xor R_811)  severity NOTE;
	assert FALSE report "(0 to 11)  " & print(R_011 xor R_0_3) & "    " & print(R_011 xor R_0_7) & "    " & print(R_011 xor R_011) & "     " & print(R_011 xor R_4_7) & "      " & print(R_011 xor R_411) & "    " & print(R_011 xor R_811)  severity NOTE;
	assert FALSE report "(4 to  7)  " & print(R_4_7 xor R_0_3) & "    " & print(R_4_7 xor R_0_7) & "    " & print(R_4_7 xor R_011) & "     " & print(R_4_7 xor R_4_7) & "      " & print(R_4_7 xor R_411) & "    " & print(R_4_7 xor R_811)  severity NOTE;
	assert FALSE report "(4 to 11)  " & print(R_411 xor R_0_3) & "    " & print(R_411 xor R_0_7) & "    " & print(R_411 xor R_011) & "     " & print(R_411 xor R_4_7) & "      " & print(R_411 xor R_411) & "    " & print(R_411 xor R_811)  severity NOTE;
	assert FALSE report "(8 to 11)  " & print(R_811 xor R_0_3) & "    " & print(R_811 xor R_0_7) & "    " & print(R_811 xor R_011) & "     " & print(R_811 xor R_4_7) & "      " & print(R_811 xor R_411) & "    " & print(R_811 xor R_811)  severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "( 3 dt 0)  " & print(R_3_0 xor R_0_3) & "    " & print(R_3_0 xor R_0_7) & "    " & print(R_3_0 xor R_011) & "     " & print(R_3_0 xor R_4_7) & "      " & print(R_3_0 xor R_411) & "    " & print(R_3_0 xor R_811)  severity NOTE;
	assert FALSE report "( 7 dt 0)  " & print(R_7_0 xor R_0_3) & "    " & print(R_7_0 xor R_0_7) & "    " & print(R_7_0 xor R_011) & "     " & print(R_7_0 xor R_4_7) & "      " & print(R_7_0 xor R_411) & "    " & print(R_7_0 xor R_811)  severity NOTE;
	assert FALSE report "(11 dt 0)  " & print(R11_0 xor R_0_3) & "    " & print(R11_0 xor R_0_7) & "    " & print(R11_0 xor R_011) & "     " & print(R11_0 xor R_4_7) & "      " & print(R11_0 xor R_411) & "    " & print(R11_0 xor R_811)  severity NOTE;
	assert FALSE report "( 7 dt 4)  " & print(R_7_4 xor R_0_3) & "    " & print(R_7_4 xor R_0_7) & "    " & print(R_7_4 xor R_011) & "     " & print(R_7_4 xor R_4_7) & "      " & print(R_7_4 xor R_411) & "    " & print(R_7_4 xor R_811)  severity NOTE;
	assert FALSE report "(11 dt 4)  " & print(R11_4 xor R_0_3) & "    " & print(R11_4 xor R_0_7) & "    " & print(R11_4 xor R_011) & "     " & print(R11_4 xor R_4_7) & "      " & print(R11_4 xor R_411) & "    " & print(R11_4 xor R_811)  severity NOTE;
	assert FALSE report "(11 dt 8)  " & print(R11_8 xor R_0_3) & "    " & print(R11_8 xor R_0_7) & "    " & print(R11_8 xor R_011) & "     " & print(R11_8 xor R_4_7) & "      " & print(R11_8 xor R_411) & "    " & print(R11_8 xor R_811)  severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report " cont.    (3 dt 0)  (7 dt 0)  (11 dt 0)  (7 dt 4)   (11 dt 4)  (11 dt 8)"      severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "(0 to  3)  " & print(R_0_3 xor R_3_0) & "    " & print(R_0_3 xor R_7_0) & "    " & print(R_0_3 xor R11_0) & "     " & print(R_0_3 xor R_7_4) & "      " & print(R_0_3 xor R11_4) & "    " & print(R_0_3 xor R11_8)  severity NOTE;
	assert FALSE report "(0 to  7)  " & print(R_0_7 xor R_3_0) & "    " & print(R_0_7 xor R_7_0) & "    " & print(R_0_7 xor R11_0) & "     " & print(R_0_7 xor R_7_4) & "      " & print(R_0_7 xor R11_4) & "    " & print(R_0_7 xor R11_8)  severity NOTE;
	assert FALSE report "(0 to 11)  " & print(R_011 xor R_3_0) & "    " & print(R_011 xor R_7_0) & "    " & print(R_011 xor R11_0) & "     " & print(R_011 xor R_7_4) & "      " & print(R_011 xor R11_4) & "    " & print(R_011 xor R11_8)  severity NOTE;
	assert FALSE report "(4 to  7)  " & print(R_4_7 xor R_3_0) & "    " & print(R_4_7 xor R_7_0) & "    " & print(R_4_7 xor R11_0) & "     " & print(R_4_7 xor R_7_4) & "      " & print(R_4_7 xor R11_4) & "    " & print(R_4_7 xor R11_8)  severity NOTE;
	assert FALSE report "(4 to 11)  " & print(R_411 xor R_3_0) & "    " & print(R_411 xor R_7_0) & "    " & print(R_411 xor R11_0) & "     " & print(R_411 xor R_7_4) & "      " & print(R_411 xor R11_4) & "    " & print(R_411 xor R11_8)  severity NOTE;
	assert FALSE report "(8 to 11)  " & print(R_811 xor R_3_0) & "    " & print(R_811 xor R_7_0) & "    " & print(R_811 xor R11_0) & "     " & print(R_811 xor R_7_4) & "      " & print(R_811 xor R11_4) & "    " & print(R_811 xor R11_8)  severity NOTE;
	assert FALSE report "---------------------------------------------------------------------------------------" severity NOTE;
	assert FALSE report "( 3 dt 0)  " & print(R_3_0 xor R_3_0) & "    " & print(R_3_0 xor R_7_0) & "    " & print(R_3_0 xor R11_0) & "     " & print(R_3_0 xor R_7_4) & "      " & print(R_3_0 xor R11_4) & "    " & print(R_3_0 xor R11_8)  severity NOTE;
	assert FALSE report "( 7 dt 0)  " & print(R_7_0 xor R_3_0) & "    " & print(R_7_0 xor R_7_0) & "    " & print(R_7_0 xor R11_0) & "     " & print(R_7_0 xor R_7_4) & "      " & print(R_7_0 xor R11_4) & "    " & print(R_7_0 xor R11_8)  severity NOTE;
	assert FALSE report "(11 dt 0)  " & print(R11_0 xor R_3_0) & "    " & print(R11_0 xor R_7_0) & "    " & print(R11_0 xor R11_0) & "     " & print(R11_0 xor R_7_4) & "      " & print(R11_0 xor R11_4) & "    " & print(R11_0 xor R11_8)  severity NOTE;
	assert FALSE report "( 7 dt 4)  " & print(R_7_4 xor R_3_0) & "    " & print(R_7_4 xor R_7_0) & "    " & print(R_7_4 xor R11_0) & "     " & print(R_7_4 xor R_7_4) & "      " & print(R_7_4 xor R11_4) & "    " & print(R_7_4 xor R11_8)  severity NOTE;
	assert FALSE report "(11 dt 4)  " & print(R11_4 xor R_3_0) & "    " & print(R11_4 xor R_7_0) & "    " & print(R11_4 xor R11_0) & "     " & print(R11_4 xor R_7_4) & "      " & print(R11_4 xor R11_4) & "    " & print(R11_4 xor R11_8)  severity NOTE;
	assert FALSE report "(11 dt 8)  " & print(R11_8 xor R_3_0) & "    " & print(R11_8 xor R_7_0) & "    " & print(R11_8 xor R11_0) & "     " & print(R11_8 xor R_7_4) & "      " & print(R11_8 xor R11_4) & "    " & print(R11_8 xor R11_8)  severity NOTE;

end architecture;
