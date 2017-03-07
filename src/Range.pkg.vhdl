
package Ranges is
	package Integer_Ranges is new package GenericDiscreteRanges
		generic map (
			T_BOUND => INTEGER
		);
	
	package Real_Ranges is new package GenericRealRanges
		generic map (
			T_BOUND => REAL
		);
end package;
