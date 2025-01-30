library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LookaheadAdder is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);  
           b : in  STD_LOGIC_VECTOR (3 downto 0);  
           cin : in  STD_LOGIC;                   
           sum : out  STD_LOGIC_VECTOR (3 downto 0); 
           cout : out  STD_LOGIC);                
end LookaheadAdder;

architecture Structural of LookaheadAdder is

    signal g, p : STD_LOGIC_VECTOR(3 downto 0);  
    signal c : STD_LOGIC_VECTOR(3 downto 1);     
    signal carry_out : STD_LOGIC;                

    component FullAdder
        Port ( a : in  STD_LOGIC;
               b : in  STD_LOGIC;
               cin : in  STD_LOGIC;
               sum : out  STD_LOGIC;
               cout : out  STD_LOGIC);
    end component;

    component CarryBlock
        Port ( g : in STD_LOGIC_VECTOR (3 downto 0);  
               p : in STD_LOGIC_VECTOR (3 downto 0);  
               cin : in STD_LOGIC;                    
               c : out STD_LOGIC_VECTOR (3 downto 1); 
               cout : out STD_LOGIC);                
    end component;

begin

    FA0: FullAdder Port map (a => a(0), b => b(0), cin => cin, sum => sum(0), cout => open);
    FA1: FullAdder Port map (a => a(1), b => b(1), cin => c(1), sum => sum(1), cout => open);
    FA2: FullAdder Port map (a => a(2), b => b(2), cin => c(2), sum => sum(2), cout => open);
    FA3: FullAdder Port map (a => a(3), b => b(3), cin => c(3), sum => sum(3), cout => open);

    g <= (a and b);     
    p <= (a or b);      

    Carry_Block: CarryBlock Port map (
        g => g, 
        p => p, 
        cin => cin,  
        c => c,      
        cout => carry_out  
    );

    cout <= carry_out;

end Structural;
