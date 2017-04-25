
-- VHDL Instantiation Created from source file RegisterFile8x16.vhd -- 15:22:49 04/13/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT RegisterFile8x16
	PORT(
		clock : IN std_logic;
		addressSD : IN std_logic_vector(2 downto 0);
		flags : IN std_logic_vector(3 downto 0);
		RFC : IN std_logic_vector(4 downto 0);
		CL : IN std_logic;
		addrA : IN std_logic_vector(2 downto 0);
		addrB : IN std_logic_vector(2 downto 0);
		DestData : IN std_logic_vector(15 downto 0);          
		flags_output : OUT std_logic_vector(2 downto 0);
		PC : OUT std_logic_vector(15 downto 0);
		Output_A : OUT std_logic_vector(15 downto 0);
		Output_B : OUT std_logic_vector(15 downto 0);
		Output_Sc : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	Inst_RegisterFile8x16: RegisterFile8x16 PORT MAP(
		clock => ,
		addressSD => ,
		flags => ,
		RFC => ,
		CL => ,
		addrA => ,
		addrB => ,
		DestData => ,
		flags_output => ,
		PC => ,
		Output_A => ,
		Output_B => ,
		Output_Sc => 
	);


