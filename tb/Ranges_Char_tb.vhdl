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
	
	alias Range_Type is Paebbels.TypePackage.RangeType;
	alias char_range is Paebbels.Ranges.RANGE_RECORD;
	
	subtype ST_0_3 is Range_Type range AA to AD;
	subtype ST_0_7 is Range_Type range AA to BD;
	subtype ST_011 is Range_Type range AA to CD;
	subtype ST_015 is Range_Type range AA to DD;
	subtype ST_031 is Range_Type range AA to HP;
	subtype ST_4_7 is Range_Type range BA to BD;
	subtype ST_811 is Range_Type range CA to CD;
	subtype ST_815 is Range_Type range CA to DD;
	subtype ST1215 is Range_Type range DA to DD;

	subtype ST_3_0 is Range_Type range AD downto AA;
	subtype ST_7_0 is Range_Type range BD downto AA;
	subtype ST11_0 is Range_Type range CD downto AA;
	subtype ST15_0 is Range_Type range DD downto AA;
	subtype ST31_0 is Range_Type range HP downto AA;
	subtype ST_7_4 is Range_Type range BD downto BA;
	subtype ST11_8 is Range_Type range CD downto CA;
	subtype ST15_8 is Range_Type range DD downto CA;
	subtype ST1512 is Range_Type range DD downto DA;

	constant C_0_3 : DUMMY_VECTOR(ST_0_3) := (others => '0');
	constant C_0_7 : DUMMY_VECTOR(ST_0_7) := (others => '0');
	constant C_011 : DUMMY_VECTOR(ST_011) := (others => '0');
	constant C_015 : DUMMY_VECTOR(ST_015) := (others => '0');
	constant C_031 : DUMMY_VECTOR(ST_031) := (others => '0');
	constant C_4_7 : DUMMY_VECTOR(ST_4_7) := (others => '0');
	constant C_811 : DUMMY_VECTOR(ST_811) := (others => '0');
	constant C_815 : DUMMY_VECTOR(ST_815) := (others => '0');
	constant C1215 : DUMMY_VECTOR(ST1215) := (others => '0');
	constant C_3_0 : DUMMY_VECTOR(ST_3_0) := (others => '0');
	constant C_7_0 : DUMMY_VECTOR(ST_7_0) := (others => '0');
	constant C11_0 : DUMMY_VECTOR(ST11_0) := (others => '0');
	constant C15_0 : DUMMY_VECTOR(ST15_0) := (others => '0');
	constant C31_0 : DUMMY_VECTOR(ST31_0) := (others => '0');
	constant C_7_4 : DUMMY_VECTOR(ST_7_4) := (others => '0');
	constant C11_8 : DUMMY_VECTOR(ST11_8) := (others => '0');
	constant C15_8 : DUMMY_VECTOR(ST15_8) := (others => '0');
	constant C1512 : DUMMY_VECTOR(ST1512) := (others => '0');
	
	constant R_0_3 : char_range	:= to_range(C_0_3);
	constant R_0_7 : char_range	:= to_range(C_0_7);
	constant R_011 : char_range	:= to_range(C_011);
	constant R_015 : char_range	:= to_range(C_015);
	constant R_031 : char_range	:= to_range(C_031);
	constant R_4_7 : char_range	:= to_range(C_4_7);
	constant R_811 : char_range	:= to_range(C_811);
	constant R_815 : char_range	:= to_range(C_815);
	constant R1215 : char_range	:= to_range(C1215);
	constant R_3_0 : char_range	:= to_range(C_3_0);
	constant R_7_0 : char_range	:= to_range(C_7_0);
	constant R11_0 : char_range	:= to_range(C11_0);
	constant R15_0 : char_range	:= to_range(C15_0);
	constant R31_0 : char_range	:= to_range(C31_0);
	constant R_7_4 : char_range	:= to_range(C_7_4);
	constant R11_8 : char_range	:= to_range(C11_8);
	constant R15_8 : char_range	:= to_range(C15_8);
	constant R1512 : char_range	:= to_range(C1512);

begin
	assert FALSE report "properties of    AA to AD       AD downto AA   CD downto CA   CA to DD" severity NOTE;
	assert FALSE report "-----------------------------------------------------------------------" severity NOTE;
	assert FALSE report "low():           " & RANGE_TYPE'image(low(R_0_3)) &   "             " & RANGE_TYPE'image(low(R_3_0)) &   "             " & RANGE_TYPE'image(low(R11_8)) &   "             " & RANGE_TYPE'image(low(R_815))   severity NOTE;
	assert FALSE report "high():          " & RANGE_TYPE'image(high(R_0_3)) &  "             " & RANGE_TYPE'image(high(R_3_0)) &  "             " & RANGE_TYPE'image(high(R11_8)) &  "             " &  RANGE_TYPE'image(high(R_815))  severity NOTE;
	assert FALSE report "left():          " & RANGE_TYPE'image(left(R_0_3)) &  "             " & RANGE_TYPE'image(left(R_3_0)) &  "             " & RANGE_TYPE'image(left(R11_8)) &  "             " &  RANGE_TYPE'image(left(R_815))  severity NOTE;
	assert FALSE report "right():         " & RANGE_TYPE'image(right(R_0_3)) & "             " & RANGE_TYPE'image(right(R_3_0)) & "             " & RANGE_TYPE'image(right(R11_8)) & "             " & RANGE_TYPE'image(right(R_815)) severity NOTE;
	assert FALSE report "length():        " & INTEGER'image(length(R_0_3)) &   "              " & INTEGER'image(length(R_3_0)) &   "              " & INTEGER'image(length(R11_8)) &   "              " & INTEGER'image(length(R_815))   severity NOTE;
	assert FALSE report "direction():     " & RANGE_DIRECTION'image(direction(R_0_3)) & "      " & RANGE_DIRECTION'image(direction(R_3_0)) & "     " &   RANGE_DIRECTION'image(direction(R11_8)) & "     " &      RANGE_DIRECTION'image(direction(R_815)) severity NOTE;
	assert FALSE report "is_ascending():  " & BOOLEAN'image(is_ascending(R_0_3)) & "           " & BOOLEAN'image(is_ascending(R_3_0)) & "          " &   BOOLEAN'image(is_ascending(R11_8)) &      "          " & BOOLEAN'image(is_ascending(R_815)) severity NOTE;
	assert FALSE report "is_descending(): " & BOOLEAN'image(is_descending(R_0_3)) & "          " & BOOLEAN'image(is_descending(R_3_0)) & "           " & BOOLEAN'image(is_descending(R11_8)) &     "           " &  BOOLEAN'image(is_descending(R_815)) severity NOTE;
	assert FALSE report "is_nullrange():  " & BOOLEAN'image(is_nullrange(R_0_3)) &  "          " & BOOLEAN'image(is_nullrange(R_3_0)) &  "          " &  BOOLEAN'image(is_nullrange(R11_8)) &      "          " &  BOOLEAN'image(is_nullrange(R_815))  severity NOTE;
	assert FALSE report "ascending():     " & image(ascending(R_0_3)) &  "       " & image(ascending(R_3_0)) &  "       " & image(ascending(R11_8)) &  "       " & image(ascending(R_815))  severity NOTE;
	assert FALSE report "descending():    " & image(descending(R_0_3)) & "   " &     image(descending(R_3_0)) & "   " &     image(descending(R11_8)) & "   " &     image(descending(R_815)) severity NOTE;
	assert FALSE report "reverse():       " & image(reverse(R_0_3)) &    "   " &     image(reverse(R_3_0)) &    "       " & image(reverse(R11_8)) &    "       " & image(reverse(R_815))    severity NOTE;
	assert FALSE report "normalize():     " & image(normalize(R_0_3)) &  "       " & image(normalize(R_3_0)) &  "   " &     image(normalize(R11_8)) &  "   " &     image(normalize(R_815))  severity NOTE;
	assert FALSE report "image():         " & image(R_0_3) &             "       " & image(R_3_0) &             "   " &     image(R11_8) &             "   " &     image(R_815)             severity NOTE;
	assert FALSE report "-------------------------------------------------------------------" severity NOTE;


	-- assert FALSE report "R1 and R2 -> RANGE: " & image(R3) & "    R1 and R2 -> bool: " & BOOLEAN'image(B3) severity NOTE;
	

end architecture;
