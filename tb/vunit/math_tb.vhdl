-- =============================================================================
-- Authors:          Patrick Lehmann
--
-- Package:          Math extension package.
--
-- Description:
-- -------------------------------------
--    This package provides additional math functions.
--
-- License:
-- =============================================================================
-- Copyright 2007-2016 Patrick Lehmann - Dresden, Germany
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
-- =============================================================================
use work.math.all;

library vunit_lib;
context vunit_lib.vunit_context;
use vunit_lib.array_pkg.all;

entity math_tb is
  generic (
    runner_cfg : string;
    natural_high_path :string := "");
end entity;

architecture test of math_tb is
begin
  TestRunner : process
    variable reference_data :array_t;
    variable natural_high :array_t;
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop
      if run("Test that natural high is according to LRM") then
        check(natural'high >= 2**31 - 1);
        natural_high.init;
        natural_high.append(natural'high);
        natural_high.save_csv(natural_high_path);
      elsif run("Test square number function against reference data") then
        reference_data.load_csv(join(output_path(runner_cfg), "reference_data.csv"));
        for i in 0 to reference_data.length/2 - 1 loop
          check_equal(squareNumber(reference_data.get(2 * i)), reference_data.get(2 * i + 1));
        end loop;
      elsif run("Test cubic number function against reference data") then
        reference_data.load_csv(join(output_path(runner_cfg), "reference_data.csv"));
        for i in 0 to reference_data.length/2 - 1 loop
          check_equal(cubicNumber(reference_data.get(2 * i)), reference_data.get(2 * i + 1));
        end loop;
      end if;
    end loop;

    test_runner_cleanup(runner);
    wait;
  end process;

  test_runner_watchdog(runner, 100 ns);
end architecture;
