---------------------------------------------------------------------------
-- Fernando Moraes - 11/out/2021
-- package with basic types for the MIPS FSD processor
---------------------------------------------------------------------------
library IEEE;
use ieee.std_Logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

package pMips is

    -- inst_type defines the instructions decodeable by the control unit
    type inst_type is
        ( ADD, SUB, XXOR, AAND, OOR, SLT, ADDI, ANDI, ORI, XORI,
          LUI, SLTI, SSLL, LW, SW, BEQ, BNE, J, JAL, JR, invalid_instruction);

    type microinstruction is record
        CY1  : std_logic; -- command of the first stage
        CY2  : std_logic; --    "    of the second stage
        CY3  : std_logic; --    "    of the third stage
        wreg : std_logic; -- register bank write enable
        wpc  : std_logic; -- PC write enable
        ce   : std_logic; -- memory enable and write enable
        we   : std_logic;
        i    : inst_type; -- operation specification
    end record;

    subtype reg32 is std_logic_vector(31 downto 0);
    subtype reg5  is std_logic_vector(4 downto 0);

    --
    --   functions for file reading and printing
    --
    constant TAM_LINHA : integer := 200;
   
    function CONV_VECTOR( letra : string(1 to TAM_LINHA);  pos: integer ) return std_logic_vector;
    function CONV_HEX( value : std_logic_vector(3 downto 0) ) return string;
    function CONV_STRING_32BITS( dado : std_logic_vector(31 downto 0)) return string;
      
end pMips;

package body pMips is

  -- converts a character from a given line to a std_logic_vector
  function CONV_VECTOR( letra:string(1 to TAM_LINHA);  pos: integer ) return std_logic_vector is         
     variable bin: std_logic_vector(3 downto 0);
   begin
      case (letra(pos)) is  
              when '0' => bin := "0000";
              when '1' => bin := "0001";
              when '2' => bin := "0010";
              when '3' => bin := "0011";
              when '4' => bin := "0100";
              when '5' => bin := "0101";
              when '6' => bin := "0110";
              when '7' => bin := "0111";
              when '8' => bin := "1000";
              when '9' => bin := "1001";
              when 'A' | 'a' => bin := "1010";
              when 'B' | 'b' => bin := "1011";
              when 'C' | 'c' => bin := "1100";
              when 'D' | 'd' => bin := "1101";
              when 'E' | 'e' => bin := "1110";
              when 'F' | 'f' => bin := "1111";
              when others =>  bin := "0000";  
      end case;
     return bin;
  end CONV_VECTOR;

  function CONV_HEX( value : std_logic_vector(3 downto 0) ) return string is
                variable str : string(1 to 1);
        begin
                case(value) is
                        when "0000" => str := "0";
                        when "0001" => str := "1";
                        when "0010" => str := "2";
                        when "0011" => str := "3";
                        when "0100" => str := "4";
                        when "0101" => str := "5";
                        when "0110" => str := "6";
                        when "0111" => str := "7";
                        when "1000" => str := "8";
                        when "1001" => str := "9";
                        when "1010" => str := "A";
                        when "1011" => str := "B";
                        when "1100" => str := "C";
                        when "1101" => str := "D";
                        when "1110" => str := "E";
                        when "1111" => str := "F";
                        when others => str := "U";
                end case;
                return str;
   end CONV_HEX;

   function CONV_STRING_32BITS(dado : std_logic_vector(31 downto 0)) return string is
        begin
                return(CONV_HEX(dado(31 downto 28)) & CONV_HEX(dado(27 downto 24)) & 
                       CONV_HEX(dado(23 downto 20)) & CONV_HEX(dado(19 downto 16)) &
                       CONV_HEX(dado(15 downto 12)) & CONV_HEX(dado(11 downto  8)) &
                       CONV_HEX(dado( 7 downto  4)) & CONV_HEX(dado( 3 downto  0)));
   end CONV_STRING_32BITS;

end pMips; 