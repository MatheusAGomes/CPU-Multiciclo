library ieee;
use ieee.std_logic_1164.all;
use work.all;
use ieee.numeric_std.all;

entity mux4x1_8 is
	port (
		entrada_1: in std_logic_vector (7 downto 0);
		entrada_2: in std_logic_vector (7 downto 0);
		entrada_3: in std_logic_vector (7 downto 0);
		sinal: in std_logic_vector(1 downto 0);
		saida_escolhida: out std_logic_vector (7 downto 0)
	);
end entity;

architecture mux4x1_8_Arch of mux4x1_8 is
--multiplexador com 4 entradas e 1 saida
begin
	process(entrada_1,entrada_2,sinal)
	begin
	  case sinal is
		when "00" => saida_escolhida <= entrada_1 ;
		when "01" => saida_escolhida <= entrada_2 ;
		when "10" => saida_escolhida <= entrada_3 ;
		when others => saida_escolhida <= entrada_1 ;
	  end case;
	end process;
end architecture;