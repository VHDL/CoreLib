-- EMACS settings: -*-  tab-width: 2; indent-tabs-mode: t -*-
-- vim: tabstop=2:shiftwidth=2:noexpandtab
-- kate: tab-width 2; replace-tabs off; indent-width 2;
-- =============================================================================
-- Authors:         Patrick Lehmann
--
-- Testbench:       Syntheziable hardware components expressed as functions.
--
-- Description:
-- -------------------------------------
-- .. TODO:: Undodumented.
--
-- License:
-- =============================================================================
-- Copyright 2007-2016 Patrick Lehmann - Dresden, Germany
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
-- =============================================================================

library CoreLib;
use			work.math.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity components_tb is
	generic (runner_cfg : string);
end entity;

architecture test of components_tb is

begin
	TestRunner : process
		variable start     : time;
		variable timed_out : boolean;
		
	begin
		checker_init(display_format => verbose);
		test_runner_setup(runner, runner_cfg);

		while test_suite loop
			if run("testcase 1") then
				null;
			elsif run("testcase 2") then
				null;
			end if;
		end loop;

		test_runner_cleanup(runner);
		wait;
	end process;

	test_runner_watchdog(runner, 100 ns);
end architecture;
