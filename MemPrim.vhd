LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY MemPrim IS
 PORT ( 
 address : IN std_logic_vector(7 DOWNTO 0);
 instruction : OUT std_logic_vector(7 DOWNTO 0);
 instructionbeq: out std_logic_vector(7 DOWNTO 0);
 MEMREAD :IN STD_LOGIC;
 clock: in STD_LOGIC
 );
END ENTITY
;
--A MEMORIA PRINCIPAL UTILIZASE DE UM ARRAY PARA ARMAZENAR AS INSTRUCOES
--COM O ENDERECO VINDO DE PC SELECIONA-SE A INSTUCAO
ARCHITECTURE MemPrim_Arch OF MemPrim IS
 TYPE mem IS ARRAY (7 downto 0) OF std_logic_vector(7 DOWNTO 0);
 CONSTANT my_rom : mem := (
 0 => "00000100", --add 
 1 => "01101111", --sub 
 2 => "11001100", --beq 
 3 => "00000110", --end 
 4 => "11011000", --beq
 5 => "00000111", --end
 6 => "00000111", --add
 7 => "10000000"); -- jump
BEGIN
PROCESS (MEMREAD,address)
 BEGIN
 if MEMREAD='1' then 
 CASE address IS
    WHEN "00000000" => instruction <= my_rom(0);
                       instructionbeq <= my_rom(1);
    WHEN "00000001" => instruction <= my_rom(1);
                        instructionbeq <= my_rom(2);
    WHEN "00000010" => instruction <= my_rom(2);
                        instructionbeq <= my_rom(3);
    WHEN "00000011" => instruction <= my_rom(3);
                       instructionbeq <= my_rom(4);
    WHEN "00000100" => instruction <= my_rom(4);
                       instructionbeq <= my_rom(5);
    WHEN "00000101" => instruction <= my_rom(5);
                       instructionbeq <= my_rom(6);
    WHEN "00000110" => instruction <= my_rom(6);
                        instructionbeq <= my_rom(7);
    WHEN "00000111" => instruction <= my_rom(7);
                       -- instructionbeq <= my_rom(8);
    WHEN others => instruction <= my_rom(0);
 END CASE;
 END IF;
 END PROCESS;
END ARCHITECTURE;