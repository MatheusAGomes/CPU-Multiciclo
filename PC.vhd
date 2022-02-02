LIBRARY work;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity PC is port (
		reset: in std_logic;
		novoendereco: in std_logic_vector (7 downto 0);
		endereco: out std_logic_vector (7 downto 0);
		clk : in std_logic;
		PcSource: in std_logic_vector(1 downto 0);
		PcWrite: in std_Logic
	);
	
end entity;
-- O pc funciona como um contador mas nao a todos os momentos,
-- o sinal de pcsource é utilizado para informar que a nao utilizacao desse metodo e passar diretamente os enderecos de beq ou jump
-- quando nao é utilizado estes recurso ocorre somente a soma de seu proprio endereco fazendo como dito anteriormente um contador
ARCHITECTURE PC_arch OF PC IS
		SIGNAL Count : STD_LOGIC_VECTOR (7 DOWNTO 0) ;
	Begin 

	PROCESS (clk,PcWrite,reset,PcSource)
	BEGIN
			if clk = '1' then
			IF reset = '0'THEN
			Count <= "00000000" ;
			elsif PcSource = "01" or PcSource = "10" then 
			Count <= novoendereco;
			endereco <= novoendereco;
			elsif PcWrite'Event and PcWrite = '1' then
			Count <= Count + "00000001";
			endereco <= Count;
			END IF;
			end if;
			
	END PROCESS;
	
END ARCHITECTURE;