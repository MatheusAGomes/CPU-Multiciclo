library ieee;
use ieee.std_logic_1164.all;
use work.all;
use ieee.numeric_std.all;

entity mux2x1_8 is
	port (
		entrada_1: in std_logic_vector (7 downto 0);
		entrada_2: in std_logic_vector (7 downto 0);
		sinal: in std_logic;
		saida_escolhida: out std_logic_vector (7 downto 0)
	);
end entity;
--multiplexador com 2 entradas e 1 saida
architecture mux2x1_8_Arch of mux2x1_8 is
begin
	process(entrada_1,entrada_2,sinal)
	begin
	  case sinal is
		when '1' => saida_escolhida <= entrada_2 ;
		when '0' => saida_escolhida <= entrada_1 ;
		when others => saida_escolhida <= entrada_1 ;
	  end case;
	end process;
END ARCHITECTURE;