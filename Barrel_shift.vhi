
-- VHDL Instantiation Created from source file Barrel_shift.vhd -- 03:44:32 08/24/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Barrel_shift
	PORT(
		A : IN std_logic_vector(15 downto 0);
		B : IN std_logic_vector(3 downto 0);
		Shifter_Ctrl : IN std_logic_vector(2 downto 0);          
		Output : OUT std_logic_vector(15 downto 0);
		Cy : OUT std_logic
		);
	END COMPONENT;

	Inst_Barrel_shift: Barrel_shift PORT MAP(
		A => ,
		B => ,
		Shifter_Ctrl => ,
		Output => ,
		Cy => 
	);


