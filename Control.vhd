----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:04:31 04/25/2016 
-- Design Name: 
-- Module Name:    Control - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use pds16_types.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Control is
    Port ( WL : in  STD_LOGIC;
           Flags : in  STD_LOGIC_VECTOR(3 downto 0);
           OpCode : in  STD_LOGIC_VECTOR(6 downto 0);-- bits de 15 a 9
           INTP : in  STD_LOGIC;
           Clock : in  STD_LOGIC;
           CL : in  STD_LOGIC;
           Sync : in  STD_LOGIC_VECTOR(1 downto 0); -- 0- BRQ, 1-RDY
           BusCtr : out  STD_LOGIC_VECTOR(3 downto 0);
           RFC : out  STD_LOGIC_VECTOR(4 downto 0);
           ALUC : out  STD_LOGIC_VECTOR(2 downto 0);
           SelAddr : out  STD_LOGIC_VECTOR(1 downto 0);
           SelData : out  STD_LOGIC_VECTOR(1 downto 0);
           Sellmm : out  STD_LOGIC
	);
end Control;

architecture Behavioral of Control is

	type STATE_TYPE is (SReset, SFetch_Addr, SFetch_Inst, SFetch_Decod, SExecution, SExec_Addr, SExec_RW, SInterrupt, SBreak, SHold_Fetch, SHold_Exec, SWait_Fetch, SWait_Exec);
	signal CurrentState, NewState : STATE_TYPE;
	
begin

    ---------------------------------------------------------------------------
    -- faz a transição de estado com o Clock, se não existir necessidades de Hold,Wait ou Interrupt, i.e. se os sinais de Ready, BGT ou Reset estiverem activos
    ---------------------------------------------------------------------------
    State_Change: 
	 process (Clock)
    begin
        if rising_edge(Clock) then
            CurrentState <= NewState;
        end if;
    end process;

    ---------------------------------------------------------------------------
    -- Determinar o proximo estado
    ---------------------------------------------------------------------------
    Nxt_State_Eval : 
	 process (CL, Sync, INTP,  CurrentState)
    begin
        if (CL = '1') then
            CurrentState <= SReset;
        else
            case (CurrentState) is
			
                when SFetch_Addr => NewState <= SFetch_Inst;

                when SFetch_Inst => if (Sync(1)= '0') then --Ready activo
													 NewState <= SWait_Fetch;
												else
													 NewState <= SFetch_Decod;
												end if;
--Ver o que este loadStoreMem significa.--------------------------------------------------------
                when SFetch_Decod =>if (( loadstoremem ) and (Sync(0)= '1')) then --BRQ activo
													 NewState <= SHold_Exec;
												else
													if (( loadstoremem ) and (Sync(0)= '0')) then
														NewState <= SExec_Addr;
													 else
														NewState <= SExecution;
													end if;
												end if;
 
					when SExecution => if (Sync(0)= '1') then --BRQ activo
													 NewState <= SHold_Fetch;
												else
													if (INTP = '1') then
													 NewState <= SInterrupt;
													else --VER O QUE É A BREAK CONDITION -------------------------------------
														if (breakCondition) then
															NewState <= SBreak;
														else
															NewState <= SFetch_Addr;
														end if;
													end if;
												end if;
												
					when SExec_Addr => NewState <= SExec_RW;
					
					when SExec_RW => if (Sync(1)= '0') then -- ready activo
												NewState <= SWait_Exec;
											else 
												NewState <= SExecution;
											end if;
											
					when SInterrupt => if (Sync(0)= '1') then -- BRQ activo
												NewState <= SHold_Fetch;
											else
												if(breakCondition) then
													NewState <= SBreak;
												else
													NewState <= SFetch_Addr;
												end if;
											end if;
											
					when SBreak => if (GO = '0') then -- Se não existir sinal para continuar, mantemos o Break.
												NewState <= SBreak;
										else
												NewState <= SFetch_Addr;
										end if;
										
					when SHold_Fetch => if (Sync(0)= '1') then -- BRQ activo
												NewState <= SHold_Fetch;
											else
												if(breakCondition) then
													NewState <= SBreak;
												else
													NewState <= SFetch_Addr;
												end if;
											end if;		

					when SHold_Exec =>if (Sync(0)= '1') then -- BRQ activo
													NewState <= SHold_Fetch;
											else
													NewState <= SExec_Addr;										
											end if;
					
					when SWait_Fetch =>if (Sync(1)= '0') then -- Ready activo
													NewState <= SWait_Fetch;
											else
													NewState <= SFetch_Decod;										
											end if;
					
					when SWait_Exec =>if (Sync(1)= '0') then -- Ready activo
													NewState <= SWait_Exec;
											else
													NewState <= SExecution;										
											end if;												
                when others =>   NewState <= SBreak;
            end case;
        end if;
    end process;

    ---------------------------------------------------------------------------
    -- Signal assignment statements for 
    ---------------------------------------------------------------------------
	 Inst_Decode: 
	 process ()
    begin
        if (CL = '1') then
            CurrentState <= SReset;
        else
            case (OpCode(6 downto 5)) is --bit15 e 14
						-- is Data transfer
						when '00' =>
							-- bit13 a 11
							if (OpCode(4 downto 2) = '000') then
								--LDI
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '001') then
								--LDIH
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '010') then
								--LD_Direct
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
--VER ESTE OPCODE, instruções.
							else if(OpCode(4 downto 2) = '010w0') then
								--LD_Indexed
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '010w1') then
								--LD_BasedIndexed
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '110') then
								--ST_Direct
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '110w0') then
								--ST_Indexed
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';

							else if(OpCode(4 downto 2) = '110w1') then
								--ST_BasedIndexed
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
						-- is Data processing
						when ('10') =>
							if (OpCode(4 downto 2) = '000') then
								--ADD
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '010') then
								--ADDC
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '100') then
								--ADD_Const
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '110') then
								--ADDC_Const
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if (OpCode(4 downto 2) = '001') then
								--SUB
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '011') then
								--SBB
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '101') then
								--SUB_Const
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '111') then
								--SBB_Const
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
						
						-- is Data processing
						when ('11') =>
							if (OpCode(4 downto 2) = '000') then
								--ANL
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '001') then
								--ORL
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '010') then
								--XRL
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '011') then
								--NOT
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
								
							else if(OpCode(4 downto 2) = '100') then
								--SHL
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '101') then
								--SHR
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 1) = '1100') then
								--RRL
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 1) = '1101') then
								--RRM
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 1) = '1110') then
								--RCR
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 1) = '1111') then
								--RCL
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';


						-- is Flow Control
						when '01' =>
							if (OpCode(4 downto 2) = '000') then
								--JZ
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '001') then
								--JNZ
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '010') then
								--JC
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '011') then
								--JNC
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
								
							else if(OpCode(4 downto 2) = '100') then
								--JMP
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '101') then
								--JMPL
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '110') then
								--IRET
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
							else if(OpCode(4 downto 2) = '111') then
								--NOP
								--sa_lin_cntr_rst <= '1' when (CS = SStandBy) else '0';
							
	

    ---------------------------------------------------------------------------
    -- Signal assignment statements for combinatorial outputs
    ---------------------------------------------------------------------------



end Behavioral;

