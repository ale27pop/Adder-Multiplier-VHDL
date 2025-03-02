library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity WallaceTreeMultiplier_tb is
end WallaceTreeMultiplier_tb;

architecture Behavioral of WallaceTreeMultiplier_tb is

    component WallaceTreeMultiplier
        Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);  
               y : in  STD_LOGIC_VECTOR (3 downto 0);  
               p : out  STD_LOGIC_VECTOR (7 downto 0)  
             );
    end component;

    signal x : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal y : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal p : STD_LOGIC_VECTOR(7 downto 0);

    signal bcd_ones : STD_LOGIC_VECTOR(3 downto 0);
    signal bcd_tens : STD_LOGIC_VECTOR(3 downto 0);
    signal bcd_hundreds : STD_LOGIC_VECTOR(3 downto 0);

    -- Variable for expected result
    signal expected_result : STD_LOGIC_VECTOR(7 downto 0);

begin

    DUT: WallaceTreeMultiplier
        Port map ( x => x,
                   y => y,
                   p => p );

    stimulus: process
    begin
        -- Test Case 1: Multiply by 0 (3 * 0 = 0)
        x <= "0011";  -- 3 in binary
        y <= "0000";  -- 0 in binary
        expected_result <= "00000000";  -- Expected product = 0
        wait for 10 ns;
        assert p = expected_result
        report "Test Case 1 Failed: 3 * 0"
        severity failure;

        -- Test Case 2: Multiply by 1 (7 * 1 = 7)
        x <= "0111";  -- 7 in binary
        y <= "0001";  -- 1 in binary
        expected_result <= "00000111";  -- Expected product = 7
        wait for 10 ns;
        assert p = expected_result
        report "Test Case 2 Failed: 7 * 1"
        severity failure;

        -- Test Case 3: Simple multiplication (2 * 3 = 6)
        x <= "0010";  -- 2 in binary
        y <= "0011";  -- 3 in binary
        expected_result <= "00000110";  -- Expected product = 6
        wait for 10 ns;
        assert p = expected_result
        report "Test Case 3 Failed: 2 * 3"
        severity failure;

        -- Test Case 4: Large result (15 * 15 = 225)
        x <= "1111";  -- 15 in binary
        y <= "1111";  -- 15 in binary
        expected_result <= "11100001";  -- Expected product = 225
        wait for 10 ns;
        assert p = expected_result
        report "Test Case 4 Failed: 15 * 15"
        severity failure;

        wait;
    end process;

    bcd_converter: process(p)
        variable temp: INTEGER;
    begin
        -- Convert binary to integer
        temp := CONV_INTEGER(p);

        -- Convert integer to BCD 
        bcd_hundreds <= conv_std_logic_vector((temp / 100), 4);
        bcd_tens <= conv_std_logic_vector((temp / 10) mod 10, 4);
        bcd_ones <= conv_std_logic_vector(temp mod 10, 4);
    end process;

end Behavioral;
