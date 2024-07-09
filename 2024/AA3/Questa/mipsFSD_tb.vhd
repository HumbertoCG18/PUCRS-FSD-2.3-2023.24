-------------------------------------------------------------------------
-- Fernando Moraes - 13/out/2021
-- 32 bits PROCESSOR TESTBENCH, HARVARD organization, LITTLE  ENDIAN    
--
-- It must be observed that the processor is hold in reset
-- (rstCPU <= '1') at the start of simulation, being activated
-- (rstCPU <= '0') just after the end of the object file reading be the testbench
--
-------------------------------------------------------------------------
    
--------------------------------------------------------------------------
-- Module implementing a behavioral model of an ASYNCHRONOUS INTERFACE RAM
--------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity RAM_mem is
      generic(  START_ADDRESS: std_logic_vector(31 downto 0) := (others=>'0')  );
      port( ce, we: in std_logic;    
            address: in std_logic_vector(31 downto 0);  
            data_in: in std_logic_vector(31 downto 0);
            data_out: out std_logic_vector(31 downto 0)
         );
end RAM_mem;

architecture RAM_mem of RAM_mem is 

   -- definição do tipo 'memory', endereçada a byte
   constant MEMORY_SIZE : integer := 2048;     
   type memory is array (0 to MEMORY_SIZE) of std_logic_vector(7 downto 0);
   signal RAM : memory;

   signal tmp_address: std_logic_vector(31 downto 0);
   alias  low_address: std_logic_vector(15 downto 0) is tmp_address(15 downto 0);    --  reduce to 16 bits due to CONV_INTEGER 
begin     

   tmp_address <= address - START_ADDRESS;   --  address offse
   
   -- writes in memory ASYNCHRONOUSLY-- LITTLE ENDIAN -------------------
   process(ce, we, low_address, data_in)
     begin
       if ce='1' and we='1' and CONV_INTEGER(low_address)>=0 and CONV_INTEGER(low_address+3)<=MEMORY_SIZE then
                   RAM(CONV_INTEGER(low_address+3)) <= data_in(31 downto 24);
                   RAM(CONV_INTEGER(low_address+2)) <= data_in(23 downto 16);
                   RAM(CONV_INTEGER(low_address+1)) <= data_in(15 downto  8);
                   RAM(CONV_INTEGER(low_address  )) <= data_in( 7 downto  0);    
      end if;  
    end process;   

   process(ce, we, low_address)
     begin
       if ce='1' and we='0' and CONV_INTEGER(low_address)>=0 and CONV_INTEGER(low_address+3)<=MEMORY_SIZE then
                   data_out(31 downto 24) <= RAM(CONV_INTEGER(low_address+3));
                   data_out(23 downto 16) <= RAM(CONV_INTEGER(low_address+2));
                   data_out(15 downto  8) <= RAM(CONV_INTEGER(low_address+1));
                   data_out( 7 downto  0) <= RAM(CONV_INTEGER(low_address  ));
       else 
                   data_out <= (others=>'Z');
       end if;     
 
    end process;
    
end RAM_mem;

-------------------------------------------------------------------------
--  CPU PROCESSOR SIMULATION TESTBENCH
-------------------------------------------------------------------------
library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 
use STD.TEXTIO.all;
use work.pMips.all;

entity CPU_tb is
end CPU_tb;

architecture cpu_tb of cpu_tb is
    
    signal Iadd_cpu, Iin_cpu, Dadd_cpu, Dout_cpu, Din_cpu,
           Daddress, Iaddress, DIN : std_logic_vector(31 downto 0);

    signal tb_add, tb_data : std_logic_vector(31 downto 0) := (others => '0' );
    
    signal Dce, Dwe, ck, rst, rstCPU, go_i, go_d, ce, we, bw: std_logic := '0' ;
    
    file ARQ : TEXT open READ_MODE is "mips.txt";
 
begin
    
    CPU: entity work.mipsFSD  port map(
              clock=>ck, reset=>rstCPU,

              i_address       => Iadd_cpu,
              instruction     => Iin_cpu,

              ce=>ce,  
              we=>we,  
              d_address =>   Dadd_cpu,
              data_out =>    Dout_cpu,
              data_in  =>    Din_cpu
        ); 

    Data_mem:  entity work.RAM_mem 
               generic map( START_ADDRESS => x"10010000" )
               port map (ce=>Dce, we=>Dwe, address=> Daddress, data_in=>DIN, data_out=>Din_cpu);
                                            
    Instr_mem: entity work.RAM_mem 
               generic map( START_ADDRESS => x"00400000" )
               port map (ce=>'1', we=>go_i, address=> Iaddress, data_in=>tb_data, data_out=>Iin_cpu);

        
    -- data memory signals --------------------------------------------------------
    Dce <= ce or go_d;
    Dwe <= we or go_d;    

    Daddress <= tb_add  when rstCPU='1' else Dadd_cpu;
    DIN      <= tb_data when rstCPU='1' else Dout_cpu; 
        
    -- instructions memory signals --------------------------------------------------------
    Iaddress <= tb_add  when rstCPU='1' else Iadd_cpu;
  
    rst <='1', '0' after 2 ns;        -- generates the reset signal (not the same as the CPU)
    ck <=  not ck after 5 ns;         -- generates the clock signal 

    ----------------------------------------------------------------------------
    -- this process loads the instruction memory and the data memory during reset
    --
    --
    --   O PROCESSO ABAIXO É UMA PARSER PARA LER CÓDIGO GERADO PELO MARS NO MARS NO FORMATO
    --   SEGUINTE FORMATO:
    --
    --  0x00400000  0x3c011001  lui $1,0x00001001     5    main: la $t0, a      # t0: *a  
    --  x00400004  0x34280008  ori $8,$1,0x00000008           
    --  ..
    --  x00400048  0x08100012  j 0x00400048          29   end: j   end
    --
    --  x10010000    0x00000000 0x00000005 0x00000901 0x00000345 0x00000879 0x00000100 0x00000900 0x00000000 
    --
    ----------------------------------------------------------------------------
    process
        variable ARQ_LINE : LINE;
        variable line_arq : string(1 to TAM_LINHA);
        variable code     : boolean;
        variable i, address_flag : integer;
    begin  
        go_i <= '0';
        go_d <= '0';
        rstCPU <= '1';           -- hold the processor during file reading
        code:=true;              -- default value of code is 1 (CODE)
                                 
        wait until rst = '1';
        
        while NOT (endfile(ARQ)) loop    -- INÍCIO DA LEITURA DO ARQUIVO CONTENDO INSTRUÇÃO E DADOS -----
            readline(ARQ, ARQ_LINE);      
            read(ARQ_LINE, line_arq(1 to  ARQ_LINE'length) );            
  
            i := 1;                                  
            address_flag := 0;                       -- para INSTRUÇÃO é um para (end,inst)
                                                     -- para DADO aceita (end, dado 0, dado 1, dado 2 ....)
            loop                                     
               if line_arq(i) = '0' and line_arq(i+1) = 'x' then      -- encontrou indicação de número hexa: '0x'
                      line_arq(i+1) := '-';                           -- invalida campo (importante)
                      i := i + 2;
                      if address_flag=0 then
                            for w in 0 to 7 loop
                                tb_add( (31-w*4) downto (32-(w+1)*4))  <= CONV_VECTOR(line_arq,i+w);
                            end loop;    
                            i := i + 8; 
                            address_flag := 1;
                      else

                            for w in 0 to 7 loop
                                tb_data( (31-w*4) downto (32-(w+1)*4))  <= CONV_VECTOR(line_arq,i+w);
                            end loop;    
                            i := i + 8;

                            wait for 0.1 ns;

                            if tb_add >= x"00400000"  and tb_add < x"004FFFFF" then 
                               go_i <= '1';             -- the go_i signal enables instruction memory writing
                               code := true;    
                            else
                               code := false; 
                               go_d <= '1';           -- the go_d signal enables data memory writing
                            end if;
                            
                            wait for 0.1 ns;
                            
                            tb_add <= tb_add + 4;       -- *great!* consigo ler mais de uma word por linha!
                            go_i <= '0';
                            go_d <= '0'; 
                            
                            address_flag := 2;    -- sinaliza que já leu o conteúdo do endereço;

                      end if;
               end if;
               i := i + 1;
               
               -- sai da linha quando chegou no seu final OU já leu par(endereço, instrução) no caso de código
               exit when i=TAM_LINHA or (code=true and address_flag=2);
           end loop;
            
        end loop;                        -- FINAL DA LEITURA DO ARQUIVO CONTENDO INSTRUÇÃO E DADOS -----
        
        rstCPU <= '0';   -- release the processor to execute
        wait for 2 ns;   -- To activate the RST CPU signal
        wait until rst = '1';  -- to Hold again!
        
    end process;
    
end cpu_tb;
