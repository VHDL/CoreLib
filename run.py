from vunit import VUnit, VUnitCLI
from pathlib import Path
from math import floor
from random import randint

rootDirectory = Path.cwd()

# Create and configure a VUnit instance and handover the command line arguments
args = VUnitCLI().parse_args()
if args.num_threads != 1:
    raise RuntimeError("Script doesn't support multi-threading")
vu = VUnit.from_args(args=args)

vu.add_array_util()

# Create the VHDL library 'CoreLib' and add required files
CoreLib = vu.add_library("CoreLib")
CoreLib.add_source_files(str(rootDirectory / "src/math.vhdl"))
CoreLib.add_source_files(str(rootDirectory / "tb/vunit/math_tb.vhdl"))

def make_pre_config(power, natural_high_path):
    """
    Return a pre configuration function generating reference data for testing a function f(n)=n^power.
    """
    def pre_config(output_path):
        """
        This function receives the output path for the test case.
        """
        NUM_OF_INPUT_SAMPLES = 1000

        with open(str(natural_high_path)) as natural_high:
            MAX_INPUT = floor(int(natural_high.read())**(1/power))

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


NATURAL_HIGH_PATH = rootDirectory / "tb/vunit/natural_high.csv"

# Pass the location where natural'high is to be stored by the first test case
math_tb = CoreLib.entity("math_tb")
math_tb.test("Test that natural high is according to LRM").add_config(generics=dict(natural_high_path=NATURAL_HIGH_PATH.as_posix()));

# Create pre-config functions to the last two test cases that create stimuli based on natural'high
# provided by the first test case
math_tb.test("Test square number function against reference data").add_config(pre_config=make_pre_config(2, NATURAL_HIGH_PATH))
math_tb.test("Test cubic number function against reference data").add_config(pre_config=make_pre_config(3, NATURAL_HIGH_PATH))

# launch VUnit
vu.main()
