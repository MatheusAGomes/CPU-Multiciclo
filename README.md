# CPU-Multiciclo
1. Descrição com topologia do projeto
  O projeto da CPU (Multiciclo) é composto por 9 componentes sendo
  eles,(Unidade de controle, Banco de registradores, Program Counter (PC),
  Multiplexador 2 para 1, Registrador de Instrução, ALU, Memória
  Principal,Concatenador).
  
  
  Unidade de controle: Designa o estado e respectivamente as saídas que serão
  utilizadas nesses estados.
  
  
  Banco de registradores: A partir dos endereços e das instruções seta quais os
  registradores serão usados para tal.
  
  
  Program Counter: Funciona como um contador designando o endereço da
  instrução que será utilizada.
  
  
  Multiplexador 2 para 1: Seleciona a partir de duas opções de entrada qual será a
  entrada a ser utilizada a seguir.
  
  
  Registrador de Instrução: Recebe a instrução e a decodifica enviando as suas
  partições resultantes para o banco de registrador ou devolvendo a para o Program
  Counter.
  
  
  Alu: Efetua operações lógicas e aritméticas com os dados recebidos dos
  registradores.
  
  
  <img width="1618" alt="1" src="https://user-images.githubusercontent.com/42185948/152202063-f1deef85-a985-4420-82d7-2e27813e287f.png">
  
  Memória principal: Armazena as instruções que se destinam para cada endereço de memória.
  
  
 Concatenador: Componente responsável por concatenar os dois dígitos mais significativo de pc com o endereço de uma instrução jump para efetuar o pulo.

 Especificações
2.1 Registradores
	Foram utilizados 4 registradores no banco de registradores de 8 bits com endereço de:
  
00

01

10

11

 
 E 1 para armazenamento do endereço de Branch no qual é ligado a memória principal tem tamanho de 8 bits.
	
2.2 Formato das instruções
Tipo R:
 
    
OPCODE(2 bits): Soma(00) e subtração(01);

3 registradores(6 bits): RS(2 bits),RT(2 bits) e RD(2 bits).


JUMP:

OPCODE(2 bits):10;
Endereço(6 bits).


BEQ:
    
OPCODE(2 bits):11


2 registradores(4 bits):RS(2 bits) e RT(2bits).


2.3 Unidade de controle

Diagrama


  <img width="1618" alt="1" src="https://user-images.githubusercontent.com/42185948/152202179-55993e91-419e-46a3-99eb-23f4ceaf8655.png">
  
  
Tabela de estados


![tabela1](https://user-images.githubusercontent.com/42185948/152202449-97820e28-c4fc-43e1-b3a2-e0fddce2b8c5.png)


![tabela2](https://user-images.githubusercontent.com/42185948/152203421-ba3919c1-6092-4c63-a672-f82914872b31.png)




Sinais


PcWrite: Sinal para efetuar a saída do endereço de Program Counter.


PcWriteCond: Sinal para indicar que a instrução é um beq, então se o fio zero for 1
quer dizer que será necessário o pulo.


PcSource: Sinal para indicar qual será a entrada de pc, se o próprio endereço de pc,
endereço concatenado para o jump ou o resultado do beq.


ALUOP: Seleciona a operação do ALU.


RegWrite: Sinal para gravar os dados no banco do registrador.


IRWrite: Sinal para a decodificação da instrução do regs inst.


MemRead: Sinal para a leitura da memória.


3. Resultados


3.1 Testes realizados

Instruções:


add r0,r1,r0


sub r3,r4,r4


beq r0,r4


beq r2,r3


jump 0


Modo de uso:

Clock iniciando de 0 até 2ns, em períodos de 100 com quedas na metade;

Reset = 0 junto ao primeiro sinal de clock = 1;

Todos os registradores iguais a 1;

3.2 Resultados obtidos

![resultado](https://user-images.githubusercontent.com/42185948/152202625-705184d4-81b9-4010-b5d9-7699cd37ff88.png)

Referência Bibliográfica

1 – BROWN, Stephen e VRANESIC, Svonko – Fundamentals of Digital Logic with 
VHDL Design. 

2 - PATTERSON, David A. e HENNESSY, John L. – Computer Organization and 
Design – The Hardware and Software Interface.






