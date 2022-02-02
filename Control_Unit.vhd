LIBRARY work;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Control_Unit is port 
	(
	clock: in STD_LOGIC;
	OPCODE: in STD_LOGIC_VECTOR(1 DOWNTO 0);
	reset: in STD_LOGIC;
	PcSource: out std_logic_vector(1 DOWNTO 0);
	PcWrite: out STD_LOGIC;
	RegWrite: out STD_LOGIC;
	IRWrite: out STD_LOGIC;
	AluOP: out STD_LOGIC_VECTOR(1 DOWNTO 0);
	MEMREAD: out STD_LOGIC;
	PcWriteCond: out STD_LOGIC
	);
	
end entity;
--Na unidade de controle usa-se 3 processos 1 para iniciar e passar de estado
--outro para "prever" o proximo estado
-- e outro para alterar os sinais de saida
	
architecture Control_Unit_arch of Control_Unit is 
	TYPE State_type is (resetado,fetch,decodificacao,add,sub,beq,beq2,jump);
	SIGNAL estado_atual,proximo_estado: State_type;
	

			Begin
				STATE_MEMORY : process(clock,reset)
				begin
					if (clock'event and clock='1') then
						if(reset = '0') then
							estado_atual <= resetado;
							else
							estado_atual <= proximo_estado;
							end if;
					end if ;
				
				end process;


	Next_State_Logic : process (estado_atual,OPCODE)
		BEGIN
			if(estado_atual = resetado) then
																									proximo_estado <= fetch;
			elsif(estado_atual = fetch) then
																									proximo_estado <= decodificacao;
			elsif(estado_atual = decodificacao) then
					case( OPCODE ) is
						when "00" => 
						proximo_estado <= add;
						when "01" => 
						proximo_estado <= sub;
						when "10" => 
						proximo_estado <= jump;
						when "11" => 
						proximo_estado <= beq;
						when others => proximo_estado <= resetado;
					end case ;													
			elsif(estado_atual = add) then 
																									proximo_estado <= fetch;
				
			elsif(estado_atual = sub) then	
																									proximo_estado <= fetch;
			
			elsif(estado_atual = beq) then	
																									proximo_estado <= beq2;	
			elsif(estado_atual = beq2 or estado_atual = jump)  then	
																									proximo_estado<= fetch;
																									
	
																									
			end if;
		end process;
		
		
	OUTPUT_STATE_LOGIC: process(estado_atual)
	begin
	case(estado_atual) is
		when resetado =>
		PcWriteCond <= '0';
		PcWrite <= '0';
		PcSource <= "00";
		AluOP<="00";
		RegWrite <= '0';
		IRWrite <= '0';
		MEMREAD <= '0';
		when fetch =>
		PcWriteCond <= '0'; 
		PcWrite <= '1';
		PcSource <= "00";
		AluOP<="00";
		RegWrite <= '0';
		IRWrite <= '0';
		MEMREAD <= '1';
	 when decodificacao =>
	 	PcWriteCond <= '0';
		PcWrite <= '0';
		PcSource <= "00";
		AluOP<="00";
		RegWrite <= '0';
		IRWrite <= '1';
		MEMREAD <= '0';
	when jump =>
		PcWriteCond <= '0';
		PcSource <= "01";
		PcWrite <= '0';
		AluOP<="00";
		RegWrite <= '0';
		IRWrite <= '0';
		MEMREAD <= '0';
	 when add =>
		PcWriteCond <= '0';
	    PcWrite <= '0';
		PcSource <= "00";
		AluOP<="10";
		RegWrite <= '1';
		IRWrite <= '0';
		MEMREAD <= '0';
	 when sub =>
	    PcWriteCond <= '0';
		PcWrite <= '0';
		PcSource <= "00";
		AluOP<="11";
		RegWrite <= '1';
		IRWrite <= '0';
		MEMREAD <= '0';
	 when beq =>
	    PcWriteCond <= '1';
	    PcWrite <= '0';
		PcSource <= "00";
		AluOP<="11";
		RegWrite <= '0';
		IRWrite <= '0';
		MEMREAD <= '0';
	when beq2 =>
	    PcWriteCond <= '1';
	    PcWrite <= '0';
		 PcSource <= "10";
		 AluOP<="11";
		 RegWrite <= '0';
		 IRWrite <= '0';
		 MEMREAD <= '0';
	 end case;
	end process;
		
		
		
		
	 
		

			  
end architecture;