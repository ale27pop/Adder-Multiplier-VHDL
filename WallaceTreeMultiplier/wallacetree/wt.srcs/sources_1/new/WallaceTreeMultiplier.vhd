library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WallaceTreeMultiplier is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);  
           y : in  STD_LOGIC_VECTOR (3 downto 0); 
           p : out  STD_LOGIC_VECTOR (7 downto 0) 
         );
end WallaceTreeMultiplier;

architecture Structural of WallaceTreeMultiplier is

    signal pp : STD_LOGIC_VECTOR (15 downto 0);  
    
    signal sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8, sum9 : STD_LOGIC;
    signal carry1, carry2, carry3, carry4, carry5, carry6, carry7, carry8, carry9 : STD_LOGIC;

    component FullAdder
        Port ( a : in  STD_LOGIC;
               b : in  STD_LOGIC;
               cin : in  STD_LOGIC;
               sum : out  STD_LOGIC;
               cout : out  STD_LOGIC);
    end component;

begin

    -- Partial products
    pp(0) <= x(0) AND y(0);
    pp(1) <= x(0) AND y(1);
    pp(2) <= x(0) AND y(2);
    pp(3) <= x(0) AND y(3);
    pp(4) <= x(1) AND y(0);
    pp(5) <= x(1) AND y(1);
    pp(6) <= x(1) AND y(2);
    pp(7) <= x(1) AND y(3);
    pp(8) <= x(2) AND y(0);
    pp(9) <= x(2) AND y(1);
    pp(10) <= x(2) AND y(2);
    pp(11) <= x(2) AND y(3);
    pp(12) <= x(3) AND y(0);
    pp(13) <= x(3) AND y(1);
    pp(14) <= x(3) AND y(2);
    pp(15) <= x(3) AND y(3);

    -- First layer 
    FA1: FullAdder Port map (a => pp(1), b => pp(4), cin => '0', sum => p(1), cout => carry1);
    FA2: FullAdder Port map (a => pp(2), b => pp(5), cin => pp(8), sum => sum1, cout => carry2);
    FA3: FullAdder Port map (a => pp(3), b => pp(6), cin => pp(9), sum => sum2, cout => carry3);
    FA4: FullAdder Port map (a => pp(10), b => pp(13), cin => '0', sum => sum3, cout => carry4);

    -- Second layer 
    FA5: FullAdder Port map (a => sum1, b => carry1, cin => '0', sum => p(2), cout => carry5);
    FA6: FullAdder Port map (a => sum2, b => carry2, cin => pp(12), sum => sum4, cout => carry6);
    FA7: FullAdder Port map (a => sum3, b => carry3, cin => carry4, sum => sum5, cout => carry7);

    -- Third layer 
    FA8: FullAdder Port map (a => sum4, b => carry5, cin => '0', sum => p(3), cout => carry8);
    FA9: FullAdder Port map (a => sum5, b => carry6, cin => carry7, sum => p(4), cout => carry9);

    -- Final layer for most significant bits
    p(0) <= pp(0);
    p(5) <= carry8;
    p(6) <= carry9;
    p(7) <= pp(15);  

end Structural;
