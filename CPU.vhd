library ieee;
use ieee.std_logic_1164.all;
use work.all;
use ieee.numeric_std.all;
USE ieee.std_logic_signed.all;
entity CPU is port (
		CLOCKCPU,RESETCPU: in std_logic
	);
	
end entity;
--Na CPU ocorre a uniao e integracao de todos os componentes

ARCHITECTURE CPU_Arch OF CPU IS

signal PCTOMEM,MEMTOREG,dadodoregstrador1,dadodoregstrador2,ENTRADADAALUA,ENTRADADAALUB,RESULTADODOALU,INSTRUCAO,saidaDaConcatenacao,muxtopc,saidadomux2x1,instructiontobeq,enderecodepulo,pctomem1: std_logic_vector(7 downto 0);
signal REGWRITEFIO,IRWRITEFIO,PCWRITEFIO,memreadfio,COUT,FIOZERO,OVL,SINALDELOAD,PCcond,fiodoand: std_logic;
signal ALUOPFIO,fioopcode,PCSOURCEFIO,fiodeselecaoderegistrador1,fiodeselecaoderegistrador2,fiodeselecaoderegistrador3: std_logic_vector(1 downto 0);
SIGNAL ENDJUMP:std_logic_vector(5 downto 0);

 component BancoDeRegistradores is port 
	(
		RegWrite, set, clock : IN STD_LOGIC;
      ReadRegister1, ReadRegister2, WriteRegister : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      WriteData : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      ReadData1, ReadData2 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)

	);
	end component;
	
		
	component ALU IS
    PORT (
       x,y: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 aluOperation: in STD_LOGIC_VECTOR(1 DOWNTO 0);
       result: OUT STD_LOGIC_VECTOR(7 downto 0);
		 cout:OUT STD_LOGIC;
		 zero:out STD_LOGIC;
		 ovl: out STD_LOGIC
    );
	END component;
	
	
	component Control_Unit is port 
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
	
end component;


component RegInst is port (
	endereco: in std_logic_vector (7 downto 0);
	IRWrite: in std_logic;
	clk : in std_logic;
	OP: out std_logic_vector (1 downto 0);
	ENDJUMP: OUT std_logic_vector (5 downto 0);
	Register1:out std_logic_vector (1 downto 0);
	Register2:out std_logic_vector (1 downto 0);
	Register3:out std_logic_vector (1 downto 0)
		);
	
end component;









component MemPrim IS
 PORT ( 
	address : IN std_logic_vector(7 DOWNTO 0);
	instruction : OUT std_logic_vector(7 DOWNTO 0);
	instructionbeq: out std_logic_vector(7 DOWNTO 0);
	MEMREAD :IN STD_LOGIC;
	clock: in STD_LOGIC
 );
END component;

component Conc is
	port (
		endereco: in std_logic_vector (5 downto 0);
		pc: in std_logic_vector (7 downto 0);
		endconcatenado: out std_logic_vector (7 downto 0)
	);
end component;


component PC is port (
		reset: in std_logic;
		novoendereco: in std_logic_vector (7 downto 0);
		endereco: out std_logic_vector (7 downto 0);
		clk : in std_logic;
		PcSource: in std_logic_vector(1 downto 0);
		PcWrite: in std_Logic
	);
	
end component;

component CompBeq is port 
	(	
	PC: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
   clock,RESULTADODOAND: IN STD_LOGIC;
   OPCODE: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
	ENDERECOCOMBRAND: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	
end component;

component mux4x1_8 is
	port (
		entrada_1: in std_logic_vector (7 downto 0);
		entrada_2: in std_logic_vector (7 downto 0);
		entrada_3: in std_logic_vector (7 downto 0);
		sinal: in std_logic_vector(1 downto 0);
		saida_escolhida: out std_logic_vector (7 downto 0)
	);
end component;

component mux2x1_8 is
	port (
		entrada_1: in std_logic_vector (7 downto 0);
		entrada_2: in std_logic_vector (7 downto 0);
		sinal: in std_logic;
		saida_escolhida: out std_logic_vector (7 downto 0)
	);
end component;

component reg8 is port 
	(	
		D : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Resetn, clock, Load : IN STD_LOGIC;
		Q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	
end component;

	BEGIN
	
	fiodoand <= (FIOZERO AND PCcond);
	pctomem1 <= PCTOMEM+"00000010";
	pc1:PC PORT MAP(RESETCPU,muxtopc,PCTOMEM,CLOCKCPU,PCSOURCEFIO,PCWRITEFIO);
	MemoriaDeIntrucao: MemPrim Port Map(PCTOMEM,INSTRUCAO,instructiontobeq,memreadfio,CLOCKCPU);
	unidadedecontrole:Control_Unit PORT MAP (CLOCKCPU,fioopcode,RESETCPU,PCSOURCEFIO,PCWRITEFIO,REGWRITEFIO,IRWRITEFIO,ALUOPFIO,memreadfio,PCcond);
	regsinstrucao:RegInst PORT MAP(INSTRUCAO,IRWRITEFIO,CLOCKCPU,fioopcode,ENDJUMP,fiodeselecaoderegistrador1,fiodeselecaoderegistrador2,fiodeselecaoderegistrador3);
	Banco:BancoDeRegistradores PORT MAP(REGWRITEFIO,RESETCPU,CLOCKCPU,fiodeselecaoderegistrador1,fiodeselecaoderegistrador2,fiodeselecaoderegistrador3,RESULTADODOALU,dadodoregstrador1,dadodoregstrador2);
 	ALU1:ALU PORT MAP(dadodoregstrador1,dadodoregstrador2,ALUOPFIO,RESULTADODOALU,COUT,FIOZERO,OVL);
	CONCATENACAO: Conc Port Map(ENDJUMP,PCTOMEM,saidaDaConcatenacao);
	multi4: mux4x1_8 Port Map(PCTOMEM,saidaDaConcatenacao,saidadomux2x1,PCSOURCEFIO,muxtopc);
	multi2: mux2x1_8 Port Map(pctomem1,enderecodepulo,fiodoand,saidadomux2x1);
	REGISTRADORDEENDERECODOBRANCH: reg8 Port Map(instructiontobeq,RESETCPU,CLOCKCPU,memreadfio,enderecodepulo);
	
 
END ARCHITECTURE;