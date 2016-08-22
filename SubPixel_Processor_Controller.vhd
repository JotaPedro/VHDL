-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Project     : Configurable Structures For Motion Estimation (COSME)
-- Affiliations: PARSIG - Parallel Structures and Signal Processing 
--               SIPS - Signal Processing Systems Group
--               INESC-ID - Institute for Systems and Computer Engineering: 
--                          Research and Development in Lisbon
-- Funding     : FCT Project POSI/40877/CHS (2002/01/14 - 2004/01/14) 
-------------------------------------------------------------------------------
-- File        : SubPixel_Processor_Controller.vhd
-- Author(s)   : Tiago Dias <tdias@sips.inesc-id.pt>
-- Date        : August 11th, 2003
-------------------------------------------------------------------------------
-- Copyright (c) 2001-3 Signal Processing Systems Group - INESC-ID, Lisbon
-------------------------------------------------------------------------------
-- Description :
-- 
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use work.FSBM_Utils_Pack.all;
use work.SubPixel_Pack.all;

entity SubPixel_Processor_Controller is
    generic (
        N_VALUE      : positive;
		SP_PRECISION : natural;
		SPEED        : natural range 0 to 3);
    port (
        -- Clock signal
        CLK          : in std_logic;
		-- Reset signal
        RST          : in std_logic;
		-- Clock enable signal
        CE           : in std_logic;
		-- 
		TRIGGER      : in std_logic;
		-- 
		RA_RQST      : out std_logic;
		-- 
		RA_READY     : in std_logic;
		-- 
		RA_FLOW      : out std_logic_vector(3 downto 0);
		-- 
		SA_RQST      : out std_logic;
		-- 
		SA_READY     : in std_logic;
		-- 
		SA_FLOW      : out std_logic_vector(4 downto 0);
		-- 
		RST_SAD_CALC : out std_logic;
		-- 
		EN_SAD_CALC  : out std_logic;
		-- 
		HCOMP_EN     : out std_logic;
		--
		LD_REF_SAD   : out std_logic
    );
end SubPixel_Processor_Controller;

architecture Structural of SubPixel_Processor_Controller is

	component CompEQ
		generic (
			WIDTH : positive);
		port (
		 	A, B  : in std_logic_vector((WIDTH-1) downto 0);
	      	EQ    : out std_logic
	    );
	end component;

	component CountRE
		generic(
			WIDTH : positive);
		port(
			CLK   : in std_logic;
			RST   : in std_logic;
			CE	  : in std_logic;
			CNT   : out std_logic_vector((WIDTH-1) downto 0)
		);
	end component;

	component RegisterD is
	    generic (
	        WIDTH : positive;
			SPEED : natural range 0 to 3);
		port (
	        CLK   : in std_logic;
			Din   : in std_logic_vector((WIDTH-1) downto 0);
	        Dout  : out std_logic_vector((WIDTH-1) downto 0)
	    );
	end component;

	component RegisterE is
	    generic (
	        WIDTH : positive;
			SPEED : natural range 0 to 3);
		port (
	        CLK   : in std_logic;
			CE    : in std_logic;
			Din   : in std_logic_vector((WIDTH-1) downto 0);
	        Dout  : out std_logic_vector((WIDTH-1) downto 0)
	    );
	end component;

	component RegisterRE is
	    generic (
	        WIDTH : positive;
			SPEED : natural range 0 to 3);
		port (
	        CLK   : in std_logic;
            RST   : in std_logic;
			CE    : in std_logic;
			Din   : in std_logic_vector((WIDTH-1) downto 0);
	        Dout  : out std_logic_vector((WIDTH-1) downto 0)
	    );
	end component;

--	constant NR_SA_LINES       : positive := N_VALUE+(2**SP_PRECISION-1)*2;
	constant NR_SA_LINES       : positive := (N_VALUE+2)-1;
--	constant NR_INIT_LINES     : natural  := SP_PEArray_Height-1;
	constant NR_INIT_LINES     : natural  := 1;
	constant NR_SHIFTS         : positive := N_VALUE-1;

    type STATE_TYPE is (SStandBy, SInit, SLdL, SLdR, SShftL, SShftR, SWaitL, SWaitR, SDone);
	
    signal CS, NS : STATE_TYPE;

	signal inbuffers_rdy       : std_logic;
	
	signal last_line           : std_logic;
	
	signal ld_new_line          : std_logic;

	signal sa_lin_cntr_cnt      : std_logic_vector(log2ceil(N_VALUE+(2**SP_PRECISION-1)*2)-1 downto 0);
	signal sa_lin_cntr_en       : std_logic;
	signal sa_lin_cntr_rst      : std_logic;

	signal pearray_init         : std_logic;

	signal ra_end_shift         : std_logic;
	signal ra_shift_cntr_cnt    : std_logic_vector(log2ceil(NR_SHIFTS)-1 downto 0);
	signal ra_shift_cntr_en     : std_logic;

	signal rst_sad, rst_sad_del       : std_logic;

	signal start_hcmp, start_hcmp_del : std_logic;

begin
	
	inbuffers_rdy <= RA_READY and SA_READY;
	
    ---------------------------------------------------------------------------
    -- SA line counter. Allows for the acknowledge of the completion of the PE
	-- array initialization and the loading of the last SA/RA line.
    ---------------------------------------------------------------------------
	SA_Cntr_Lin : CountRE generic map (
                      WIDTH => log2ceil(NR_SA_LINES)
                  ) port map (
                      CLK   => CLK,
                      RST   => sa_lin_cntr_rst,
                      CE	=> sa_lin_cntr_en,
                      CNT   => sa_lin_cntr_cnt
                  );

	SA_EOA_Cmp  : CompEQ generic map (
                      WIDTH => log2ceil(NR_SA_LINES)
                  ) port map (
                      A     => sa_lin_cntr_cnt,
                      B     => conv_std_logic_vector(NR_SA_LINES, log2ceil(NR_SA_LINES)),
                      EQ    => last_line
                  );

	SA_EOI_Cmp  : CompEQ generic map (
                      WIDTH => log2ceil(NR_SA_LINES)
                  ) port map (
                      A     => sa_lin_cntr_cnt,
                      B     => conv_std_logic_vector(NR_INIT_LINES, log2ceil(NR_SA_LINES)),
					  EQ    => pearray_init
                  );
				 
    ---------------------------------------------------------------------------
    -- RA column counter. Allows for the acknowledge of the completion of the
	-- shift procedure of the RA lines.
    ---------------------------------------------------------------------------	
	RA_Cntr_Col : CountRE generic map (
                      WIDTH => log2ceil(NR_SHIFTS)
                  ) port map (
                      CLK   => CLK,
                      RST   => ld_new_line,
                      CE	=> ra_shift_cntr_en,
                      CNT   => ra_shift_cntr_cnt
                  );

	RA_EOS_Cmp  : CompEQ generic map (
                      WIDTH => log2ceil(NR_SHIFTS)
                  ) port map (
                      A     => ra_shift_cntr_cnt,
                      B     => conv_std_logic_vector(NR_SHIFTS, log2ceil(NR_SHIFTS)),
                      EQ    => ra_end_shift
                  );

    ---------------------------------------------------------------------------
    -- .
    ---------------------------------------------------------------------------	
    RstSAD_Reg : RegisterD generic map (
                     WIDTH   => 1,
                     SPEED   => SPEED
                 ) port map (
                     CLK     => CLK,
                     Din(0)  => rst_sad,
                     Dout(0) => rst_sad_del
                 );

    ---------------------------------------------------------------------------
    -- Delay the signal that triggers the hierarchical comparator for 2 clock
	-- cycles (cc):
	--    1 cc for the completion of the absolute difference operation for the
	--    last pixel;
	--    1 cc due to the accumulation units of the active PEs.
    ---------------------------------------------------------------------------	
	HCmp_Reg : RegisterD generic map (
                   WIDTH   => 1,
                   SPEED   => SPEED
               ) port map (
                   CLK     => CLK,
                   Din(0)  => start_hcmp,
                   Dout(0) => start_hcmp_del
               );

    ---------------------------------------------------------------------------
    -- Make the transition to the next state on a clock pulse, when the clock
	-- enable signal is active.
    ---------------------------------------------------------------------------
    State_Transitions : process (CLK)
    begin
        if rising_edge(CLK) then
			if (CE = '1') then
            	CS <= NS;
			end if;
        end if;
    end process;

    ---------------------------------------------------------------------------
    -- Determine the next state
    ---------------------------------------------------------------------------
    Nxt_State_Eval : process (RST, TRIGGER, pearray_init, ra_end_shift, last_line, inbuffers_rdy, CS)
    begin
        if (RST = '1') then
            NS <= SStandBy;
        else
            case (CS) is
				-- Wait for the start processing signal
                when SStandBy => if (TRIGGER = '1') then
                                     NS <= SInit;
							     else
                                     NS <= SStandBy;
                                 end if;
                -- Wait until all the inital SA lines, but the last one, are loaded into the PE array
                when SInit =>    if ((pearray_init = '1') and (inbuffers_rdy = '1')) then
                                     NS <= SLdL;
                                 else
                                     NS <= SInit;
                                 end if;
				-- Load last search area line and a new reference area line
                when SLdL =>     NS <= SShftL;
                -- Determine the MV by shifting the pixels to the left
                when SShftL =>   if (ra_end_shift = '0') then
                                     -- Wait until the line is fully shifted
                                     NS <= SShftL;
                                 elsif (last_line = '1') then
                                     -- Processing completed
                                     NS <= SDone;
                                 elsif (inbuffers_rdy = '0') then
                                     -- Next SA line not available, so wait for pixels
                                     NS <= SWaitR;
                                 else
                                     -- Next SA line available, so keep processing
                                     -- but on the opposite direction
                                     NS <= SLdR;
                                 end if;
                -- Wait until the next line of the SA pixels is ready to be loaded
                when SWaitR =>   if (inbuffers_rdy = '1') then
                                     NS <= SLdR;
                                 else
                                     NS <= SWaitR;
                                 end if;
				-- Load new search area and reference area lines
                when SLdR =>     NS <= SShftR;
                -- Determine the MV by shifting the pixels to the right
                when SShftR =>   if (ra_end_shift = '0') then
                                     -- Wait until the line is fully shifted
                                     NS <= SShftR;
                                 elsif (last_line = '1') then
                                     -- Processing completed
									 NS <= SDone;
                                 elsif (inbuffers_rdy = '0') then
                                     -- Next SA line not available, so wait for pixels
                                     NS <= SWaitL;
                                 else
                                     -- Next SA line available, so keep processing but on the opposite direction
                                     NS <= SLdL;
                                 end if;
                -- Wait until the next line of the SA pixels is ready to be loaded
                when SWaitL =>   if (inbuffers_rdy = '1') then
                                     NS <= SLdL;
                                 else
                                     NS <= SWaitL;
                                 end if;
                -- Signal the competion of the SAD computation
                when SDone  =>   NS <= SStandBy;
                -- If abnormal state, reset the processor
                when others =>   NS <= SStandBy;
            end case;
        end if;
    end process;

    ---------------------------------------------------------------------------
    -- Signal assignment statements for 
    ---------------------------------------------------------------------------
	--
	sa_lin_cntr_rst_assignment:
	sa_lin_cntr_rst <= '1' when (CS = SStandBy) else
                       '0';

	--
	sa_lin_cntr_en_assignment:
	sa_lin_cntr_en <= SA_READY      when (CS = SInit)  else
                      inbuffers_rdy when (CS = SLdL)   else
                      inbuffers_rdy when (CS = SWaitR) else
					  inbuffers_rdy when (CS = SLdR)   else
                      inbuffers_rdy when (CS = SWaitL) else
                      '0';

	-- 
	ld_new_line_assignment:
	ld_new_line <= pearray_init                                      when (CS = SInit)  else
                   ra_end_shift and not(last_line) and inbuffers_rdy when (CS = SShftL) else
                   inbuffers_rdy                                     when (CS = SWaitR) else
                   ra_end_shift and not(last_line) and inbuffers_rdy when (CS = SShftR) else
                   inbuffers_rdy                                     when (CS = SWaitL) else
                   '0';

	--
	ra_shift_cntr_en_assignment:
	ra_shift_cntr_en <=	'1' when (CS = SShftL) else
                        '1' when (CS = SShftR) else
                        '0';

	rst_sad_assignment:
	rst_sad <= '0' when (CS = SStandBy) else
               '1' when (CS = SInit)    else
               '0';

	start_hcmp_assignment:
	start_hcmp <= '1' when (CS = SDone) else
                  '0';

    ---------------------------------------------------------------------------
    -- Signal assignment statements for combinatorial outputs
    ---------------------------------------------------------------------------
	-- Controls the flow of the RA pixels in both the input buffer and PE array
	-- PEArray register load + InBuffer rotation + InBuffer shift + InBuffer
	-- load
    RA_FLOW_assignment:
    RA_FLOW <= "110" & RA_READY                                         when (CS = SInit)  else
               "1110"                                                   when (CS = SLdL)   else
			   '1'                                                    &
			   not(ra_end_shift and not(last_line) and inbuffers_rdy) & 
			   not(ra_end_shift and not(last_line) and inbuffers_rdy) &
			   (ra_end_shift and not(last_line) and inbuffers_rdy)      when (CS = SShftL) else
			   "000" & inbuffers_rdy                                    when (CS = SWaitR) else
			   "1010"                                                   when (CS = SLdR)   else
			   '1'                                                    &
			   (ra_end_shift and not(last_line) and inbuffers_rdy)    &
			   not(ra_end_shift and not(last_line) and inbuffers_rdy) &
			   (ra_end_shift and not(last_line) and inbuffers_rdy)      when (CS = SShftR) else
			   "010" & inbuffers_rdy                                    when (CS = SWaitL) else
               "0100";

	-- Controls the flow of the SA pixels in both the input buffer and PE array
	-- PEArray flow enable + PEArray flow direction (H(0)/V(1)) + PEArray rotation
	-- direction (L->R(0)/R->L(1)) + InBuffer load + InBuffer alignment (left(0)/right(1))
    SA_FLOW_assignment:
    SA_FLOW <= (SA_READY and not(pearray_init)) & "11" & (SA_READY and not(pearray_init)) & '0' when (CS = SInit)  else
               "11010"                                   when (CS = SLdL)   else
               "10001"                                   when (CS = SShftR) else
               "01101"                                   when (CS = SWaitR) else
               "11111"                                   when (CS = SLdR)   else
               "10100"                                   when (CS = SShftL) else
               "01000"                                   when (CS = SWaitL) else
               "00000";

	--
	RA_RQST_assignment:
	RA_RQST <= not(RA_READY) when (CS = SInit)  else
               '1'           when (CS = SLdL)   else
               '1'           when (CS = SLdR)   else
               '0';

	--
	SA_RQST_assignment:
	SA_RQST <= '1'          when (CS = SInit)  else
               ra_end_shift when (CS = SShftR) else
			   '1'          when (CS = SWaitR) else
               ra_end_shift when (CS = SShftL) else
			   '1'          when (CS = SWaitL) else
               '0';

	HCOMP_EN_assignment:
	HCOMP_EN <= start_hcmp_del;

	-- 
	RST_SAD_CALC_assignment:
	RST_SAD_CALC <= rst_sad_del;

	--
	EN_SAD_CALC_assignment:
	EN_SAD_CALC <= not(rst_sad_del) when (CS = SShftL) else
                   not(rst_sad_del) when (CS = SShftR) else
                   '0';

	--
	LD_REF_SAD_assignment:
	LD_REF_SAD <= pearray_init and inbuffers_rdy when (CS = SInit) else
                  '0';

end Structural;
