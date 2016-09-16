from vunit import VUnit
from pathlib import Path
from math import floor
from random import randint

rootDirectory = Path.cwd()

# Create and configure a VUnit instance and handover the command line arguments
vu = VUnit.from_argv()
vu.add_array_util()

# Create the VHDL library 'CoreLib' and add required files
CoreLib = vu.add_library("CoreLib")
CoreLib.add_source_files(str(rootDirectory / "src/math.vhdl"))
CoreLib.add_source_files(str(rootDirectory / "tb/vunit/math_tb.vhdl"))

def make_pre_config(power):
    """
    Return a pre configuration function generating reference data for testing a function f(n)=n^power.
    """
    def pre_config(output_path):
        """
        This function receives the output path for the test case.
        """
        NUM_OF_INPUT_SAMPLES = 1000
        MINIMUM_HIGHEST_NATURAL_REQUIRED_BY_VHDL = 2**31 - 1
        MAX_INPUT = floor(MINIMUM_HIGHEST_NATURAL_REQUIRED_BY_VHDL**(1/power))
        with open(str(Path(output_path) / "reference_data.csv"), "w") as reference_data:
            # Random input
            for i in range(NUM_OF_INPUT_SAMPLES - 2):
                next_input = randint(0, MAX_INPUT)
                reference_data.write("%s, %s," % (next_input, next_input**power))

            # Corner cases
            reference_data.write("%s, %s," % (0, 0))
            reference_data.write("%s, %s" % (MAX_INPUT, MAX_INPUT**power))

        # Must return True or the test case will fail
        return True

    return pre_config

# Add a pre configurations to run before each test case
math_tb = CoreLib.entity("math_tb")
math_tb.test("Test square number function against reference data").add_config(pre_config=make_pre_config(2))
math_tb.test("Test cubic number function against reference data").add_config(pre_config=make_pre_config(3))

# launch VUnit
vu.main()
