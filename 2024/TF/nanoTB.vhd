library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity NanoCPU_TB is
end NanoCPU_TB;

architecture TB of NanoCPU_TB is

	signal ck, rst: std_logic := '0';
	signal dataR, dataW: std_logic_vector(15 downto 0);
	signal address: std_logic_vector(7 downto 0);
	signal we, ce: std_logic;

	-- Memory array signal for 256 x 16-bit positions
	type memoryArray is array (0 to 255) of std_logic_vector(15 downto 0);

	signal memory: memoryArray :=
	(
		0  => X"0321",      -- R1 = PMEM[50] que é B
		1  => X"4200",      -- R2 = 0 (C)
		2  => X"4300",      -- R3 = 0 (i)
		-- bloco de codigo do while
		3  => X"0330",      -- R0 = PMEM[51] que é A
		4  => X"6220",      -- R2 = R2 + R0
		5  => X"8330",      -- R3++
		-- trecho de comparacao do while
		6  => X"7031",      -- R0 <= 1 se r0(i) < r3(B) senão 0
		7  => X"3030",      -- R3++
		8  => X"F000",      -- FIM
		50=>  X"0005",      --valor inicial de B
		51=>  X"0002",		--valor inicial de A
		others => (others => '0')
	);

begin

	rst <= '1', '0' after 2 ns;        -- generates the reset signal
	ck  <= not ck after 1 ns;          -- generates the clock signal 

	CPU: entity work.nanoCPU port map
	(
		ck      => ck,
		rst     => rst,
		address => address,
		dataR   => dataR,
		dataW   => dataW,
		ce      => ce,
		we      => we
	); 

	-- write to memory
	process(ck)
	begin
		if ck'event and ck = '1' then
			if we = '1' then
				memory(CONV_INTEGER(address)) <= dataW; 
			end if;
		end if;
	end process;

	dataR <= memory(CONV_INTEGER(address));   -- read from memory

end TB;
