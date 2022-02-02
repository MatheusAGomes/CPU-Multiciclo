LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY FullAdder IS
    PORT (
       cin,x,y: IN STD_LOGIC;
        S,cout : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE FullAdder_arch OF FullAdder IS
BEGIN
		S <= (cin XOR (x XOR y));
		cout <= ((x AND y) OR (cin AND X) OR (cin AND y));
END ARCHITECTURE;