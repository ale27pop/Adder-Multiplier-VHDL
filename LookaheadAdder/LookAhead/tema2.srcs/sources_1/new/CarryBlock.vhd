library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CarryBlock is
    Port ( g : in STD_LOGIC_VECTOR (3 downto 0);  
           p : in STD_LOGIC_VECTOR (3 downto 0);  
           cin : in STD_LOGIC;                    
           c : out STD_LOGIC_VECTOR (3 downto 1); 
           cout : out STD_LOGIC);                 
end CarryBlock;

architecture Behavioral of CarryBlock is
signal temp_c : STD_LOGIC_VECTOR(3 downto 0); 
begin
   
    temp_c(0) <= cin;
    temp_c(1) <= (g(0)) or (p(0) and temp_c(0));
    temp_c(2) <= (g(1)) or (p(1) and temp_c(1));
    temp_c(3) <= (g(2)) or (p(2) and temp_c(2));
    cout <= (g(3)) or (p(3) and temp_c(3));

    c <= temp_c(3 downto 1);
end Behavioral;
