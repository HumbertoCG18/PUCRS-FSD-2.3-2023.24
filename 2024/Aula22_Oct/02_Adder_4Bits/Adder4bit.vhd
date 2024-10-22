library IEEE;
use IEE.std_logic_1164.all;

entity Adder4bit is
	port(
		A, B: in std_logic_vector(3 downto 0);
		Cin : in std_logic;
		S   : out std_logic_vector(3 downto 0);
		Cout: out std_logic
);
end entity;

architecture bhr of Adder4bit is
begin

	FA0: entity work.FAdder port map(A => A(0), B => B(0), Cin =>, S => (0), Cout =>);
	FA1: entity work.FAdder port map(A => A(1), B => B(1), Cin =>, S => (1), Cout =>);
	FA2: entity work.FAdder port map(A => A(2), B => B(2), Cin =>, S => (2), Cout =>);
	FA3: entity work.FAdder port map(A => A(3), B => B(3), Cin =>, S => (3), Cout =>);
