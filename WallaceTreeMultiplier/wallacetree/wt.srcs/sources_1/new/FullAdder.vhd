library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           sum : out  STD_LOGIC;
           cout : out  STD_LOGIC);
end FullAdder;

architecture Behavioral of FullAdder is
begin
    sum <= a XOR b XOR cin;
    cout <= (a AND b) OR (cin AND (a XOR b));
end Behavioral;
