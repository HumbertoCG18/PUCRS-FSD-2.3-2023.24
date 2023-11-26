---------------------------------------------------------------------------
-- Fernando Moraes - 11/out/2021
-- (adapted from previous processors from Ney Calazans and Fernando Moraes)
---------------------------------------------------------------------------

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Generic register  
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
use work.pMips.all;

entity regnbit is
    generic( INIT_VALUE : reg32 := (others => '0') );
       port( ck, rst, ce : in std_logic;
             D : in  reg32;
             Q : out reg32
          );
end regnbit;

architecture regn of regnbit is
begin

    process(ck, rst)
    begin
        if rst = '1' then
            Q <= INIT_VALUE(31 downto 0);
        elsif rising_edge(ck) then
            if ce = '1' then
                Q <= D;
            end if;
        end if;
    end process;

end regn;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Register Bank (R0..R31) - 31 GENERAL PURPOSE 16-bit REGISTERS
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.pMips.all;

entity reg_bank is
    port( ck, rst, wreg    : in  std_logic;
          AdRs, AdRt, adRD : in  reg5;
          RD               : in  reg32;
          R1, R2           : out reg32
    );
end reg_bank;

architecture reg_bank of reg_bank is
    type bank is array(0 to 31) of reg32;
    signal reg : bank ;
    signal wen : reg32 ;
begin

    g1 : for i in 0 to 31 generate
        -- write enable - remember register $0 is the constant 0, not a register.
        wen(i) <= '1' when i/=0 and adRD=i and wreg='1' else '0';
        rx : entity work.regnbit port map(ck => ck, rst => rst, ce => wen(i), D => RD, Q => reg(i));
    end generate g1;

    R1 <= reg(CONV_INTEGER(AdRs)); -- source1 selection 
    R2 <= reg(CONV_INTEGER(AdRt)); -- source2 selection 

end reg_bank;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- ALU - operation depends only on the current instruction 
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;   -- ULA must be signed!
use work.pMips.all;

entity alu is
    port( op1, op2 : in reg32;
          op_alu :   in  inst_type; 
          outalu :   out reg32
    );
end alu;

architecture alu of alu is
    signal menor, menorEx  : std_logic ;
    signal extOP2, ZextOP2 : reg32;
begin

    menor   <= '1' when op1<op2 else '0'; 
    menorEx <= '1' when op1<extOP2 else '0'; 

 
    extOP2 <= x"FFFF" & op2(15 downto 0) when op2(15)='1' else
              x"0000" & op2(15 downto 0);     -- sign extension
   
    ZextOP2 <= x"0000" & op2(15 downto 0);    -- zero extension 

    outalu <=  op1 - op2                      when op_alu=SUB else
               op1 xor op2                    when op_alu=XXOR else
               op1 and op2                    when op_alu=AAND else
               op1 or op2                     when op_alu=OOR else
               (0 => menor, others => '0')    when op_alu=SLT else
       
               op1 + extOP2                   when op_alu=ADDI or op_alu=LW or op_alu=SW else
               op1 xor ZextOP2                when op_alu=XORI else
               op1 and ZextOP2                when op_alu=ANDI else
               op1 or ZextOP2                 when op_alu=ORI else
               op2(15 downto 0) & x"0000"     when op_alu=LUI else
               (0 => menorEx, others => '0')  when op_alu=SLTI else

               to_StdLogicVector(to_bitvector(op1) sll CONV_INTEGER(op2(10 downto 6))) when op_alu=SSLL else

               op1 + (extOP2(29 downto 0) & "00") when op_alu=BEQ or op_alu=BNE else

               op1(31 downto 28) & op2(25 downto 0) & "00" when op_alu=J or op_alu=JAL else

               op1 when op_alu=JR else

               op1 + op2; --  ADD       

end alu;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Datapath description
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.pMips.all;

entity datapath is
    port( ck, rst : in std_logic;

          i_address   : out reg32;
          instruction : in  reg32;

          d_address : out reg32;
          data_out  : out reg32;
          data_in   : in  reg32;

          uins   : in  microinstruction;
          IR_OUT : out reg32
    );     
end datapath;

architecture datapath of datapath is
    signal incpc, pc, npc, IR, RIN, o_alu, Ralu, R1, R2, RS, RT, op1, op2, dtpc : reg32;
    signal adS, adRd : reg5;
begin

    --==============================================================================
    -- first_stage
    --==============================================================================

    incpc <= pc + 4;

    RNPC : entity work.regnbit port map(ck => ck, rst => rst, ce => uins.CY1, D => incpc, Q => npc);

    RIR : entity work.regnbit port map(ck => ck, rst => rst, ce => uins.CY1, D => instruction, Q => IR);

    IR_OUT <= ir ; -- IR is the datapath output signal to carry the instruction

    i_address <= pc; -- connects PC output to the instruction memory address bus

    --==============================================================================
    -- second stage
    --==============================================================================

    -- signal to be written into the register bank
    RIN <= npc     when uins.i=JAL else
           data_in when uins.i=LW else
        Ralu;

    -- The then clause is only used for logic shifts with shamt field       
    adS <= IR(20 downto 16) when uins.i=SSLL else
           IR(25 downto 21);

    -- register bank write address selection
    adRd <= "11111"          when uins.i=JAL else
            IR(15 downto 11) when uins.i=ADD or uins.i=SUB or uins.i=XXOR or uins.i=AAND or uins.i=OOR or uins.i=SLT or uins.i=SSLL else
            IR(20 downto 16);

    REGS : entity work.reg_bank(reg_bank) 
               port map (ck => ck, rst => rst, wreg => uins.wreg,
                         AdRs => adS, AdRt => ir(20 downto 16), adRD => adRd,
                         RD   => RIN, R1 => R1, R2 => R2);

    -- second stage registers
    REG_S : entity work.regnbit port map(ck => ck, rst => rst, ce => uins.CY2, D => R1, Q => RS);
    REG_T : entity work.regnbit port map(ck => ck, rst => rst, ce => uins.CY2, D => R2, Q => RT);

    --==============================================================================
    -- third stage
    --==============================================================================

    -- select the first ALU operand                           
    op1 <= npc when uins.i=BEQ or uins.i=BNE or uins.i=J or uins.i=JAL else
        RS;

    -- select the second ALU operand
    op2 <= IR when uins.i=LW or uins.i=SW or uins.i=BEQ or uins.i=BNE or uins.i=J or uins.i=JAL or
                   uins.i=ADDI or uins.i=ANDI or uins.i=ORI or uins.i=XORI or uins.i=LUI or uins.i=SLTI or uins.i=SSLL else
           RT;

    -- ALU instantiation
    inst_alu : entity work.alu port map (op1 => op1, op2 => op2, outalu => o_alu, op_alu => uins.i);

    -- register to store de ALU result 
    REG_U : entity work.regnbit port map(ck => ck, rst => rst, ce => uins.CY3, D => o_alu, Q => Ralu);

    data_out  <= RT; --- data to be written into the memory
    d_address <= Ralu;

    --==============================================================================
    -- PC
    --==============================================================================

    dtpc <= Ralu when (uins.i=BEQ and RS=RT) or (uins.i=BNE and RS/=RT and uins.i=BNE) or uins.i=J or uins.i=JAL or uins.i=JR else
            npc;

    rpc : entity work.regnbit generic map(INIT_VALUE => x"00400000")
                                 port map(ck  => ck, rst => rst, ce => uins.wpc, D => dtpc, Q => pc);
       
end datapath;

--------------------------------------------------------------------------
--  Control Unit Description 
--------------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use work.pMips.all;

entity control_unit is
    port( ck, rst : in std_logic;
        uins : out microinstruction;
        ir   : in  reg32
    );
end control_unit;

architecture control_unit of control_unit is
    type type_state is (Sfetch, Sreg, Salu, Swbk, Sld, Sst, Ssalta);
    signal EA, PE : type_state;
    signal i      : inst_type;
begin

    ----------------------------------------------------------------------------------------
    -- BLOCK (1/3) - INSTRUCTION DECODING and ALU operation definition
    ----------------------------------------------------------------------------------------
    i <= ADD  when ir(31 downto 26)="000000" and (ir(7 downto 0)=x"20" or ir(7 downto 0)=x"21") else -- ADD e ADDU (accept both)
         SUB  when ir(31 downto 26)="000000" and (ir(7 downto 0)=x"22" or ir(7 downto 0)=x"22") else -- SUB e SUBU (accept both)
         XXOR when ir(31 downto 26)="000000" and ir(7 downto 0)=x"26" else
         AAND when ir(31 downto 26)="000000" and ir(7 downto 0)=x"24" else
         OOR  when ir(31 downto 26)="000000" and ir(7 downto 0)=x"25" else
         SLT  when ir(31 downto 26)="000000" and ir(5 downto 0)="101010" else
         ADDI when ir(31 downto 26)="001000" or ir(31 downto 26)="001001" else -- 8 is ADDI e 9 is ADDIU (accept both)
         ANDI when ir(31 downto 26)="001100" else
         ORI  when ir(31 downto 26)="001101" else
         XORI when ir(31 downto 26)="001110" else
         LUI  when ir(31 downto 26)="001111" else
         SLTI when ir(31 downto 26)="001010" else
         SSLL when ir(31 downto 21)="00000000000" and ir(5 downto 0)="000000" else
         LW   when ir(31 downto 26)="100011" else
         SW   when ir(31 downto 26)="101011" else
         BEQ  when ir(31 downto 26)="000100" else
         BNE  when ir(31 downto 26)="000101" else
         J    when ir(31 downto 26)="000010" else
         JAL  when ir(31 downto 26)="000011" else
         JR   when ir(31 downto 26)="000000" and ir(20 downto 0)="000000000000000001000" else
         invalid_instruction ; -- IMPORTANT: default condition is invalid instruction;

    assert i /= invalid_instruction or rst='1'
        report "******************* INVALID INSTRUCTION ************* ->   " &  CONV_STRING_32BITS(ir)   
        severity error;
    uins.i <= i; -- this instructs the alu to execute its expected operation, if any

    ----------------------------------------------------------------------------------------
    -- BLOCK (2/3) -  control signals generation
    ----------------------------------------------------------------------------------------
    uins.CY1 <= '1' when EA=Sfetch else '0';

    uins.CY2 <= '1' when EA=Sreg else '0';

    uins.CY3 <= '1' when EA=Salu else '0';

    uins.wreg <= '1' when EA=Swbk or EA=Sld else '0';

    uins.wpc <= '1' when EA=Swbk or EA=Sld or EA=Sst or EA=Ssalta else '0'; -- always in the third cycle

    uins.ce <= '1' when EA=Sld or EA=Sst else '0';

    uins.we <= '1' when EA=Sst else '0';

    ---------------------------------------------------------------------------------------------
    -- BLOCK (3/3) - Sequential part of the control unit - two processes implementing the
    -- Control Unit state register and the next-state (combinational) function
    --------------------------------------------------------------------------------------------- 
    process(ck, rst)
    begin
        if rst='1' then
             EA <= Sfetch;
        elsif rising_edge(ck) then
             EA <= PE;
        end if;
    end process;

    process(EA, i)
    begin
        case EA is

            -- first stage:  read the current instruction 
            when Sfetch => PE <= Sreg;

            -- second stage: read the register bank 
            when Sreg => PE <= Salu;

            -- third stage: executes the ALU operation
            when Salu => if i=LW then
                             PE <= Sld;
                         elsif i=SW then
                             PE <= Sst;
                         elsif i=JR or i=BEQ or i=BNE or i=J then
                             PE <= Ssalta;
                         else
                             PE <= Swbk;
                         end if;

            -- third clock cycle: write in registers - GO BACK TO FETCH
            when Sld | Sst | Ssalta | Swbk => PE <= Sfetch;

        end case;

    end process;

end control_unit;

--------------------------------------------------------------------------
-- Top-level instantiation of the MipsFSD Datapath and Control Unit
--------------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use work.pMips.all;

entity mipsFSD is
    port( clock, reset : in std_logic;

          i_address   : out reg32;
          instruction : in  reg32;

          ce, we    : out std_logic;
          d_address : out reg32;
          data_out  : out reg32;
          data_in   : in  reg32
    );
end mipsFSD;

architecture a1 of mipsFSD is
    signal IR   : reg32;
    signal uins : microinstruction;
begin

    dp : entity work.datapath
        port map( ck => clock, rst => reset, IR_OUT => IR, uins => uins,
            i_address => i_address, instruction => instruction,
            d_address => d_address, data_out => data_out, data_in => data_in);

    ct : entity work.control_unit port map(ck => clock, rst => reset, IR => IR, uins => uins);

    ce <= uins.ce;
    we <= uins.we;

end a1;
