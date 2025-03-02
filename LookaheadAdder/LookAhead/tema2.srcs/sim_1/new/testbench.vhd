library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LookaheadAdder_tb is
end LookaheadAdder_tb;

architecture Behavioral of LookaheadAdder_tb is

    component LookaheadAdder
        Port ( a : in  STD_LOGIC_VECTOR(3 downto 0);   
               b : in  STD_LOGIC_VECTOR(3 downto 0);   
               cin : in  STD_LOGIC;                   
               sum : out STD_LOGIC_VECTOR(3 downto 0); 
               cout : out STD_LOGIC                   
             );
    end component;

    signal a, b : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal cin : STD_LOGIC := '0';
    signal sum : STD_LOGIC_VECTOR(3 downto 0);
    signal cout : STD_LOGIC;

    signal bcd_ones : STD_LOGIC_VECTOR(3 downto 0);
    signal bcd_tens : STD_LOGIC_VECTOR(3 downto 0);

    signal expected_sum : STD_LOGIC_VECTOR(3 downto 0);
    signal expected_cout : STD_LOGIC;

begin

    DUT: LookaheadAdder
        Port map ( a => a,
                   b => b,
                   cin => cin,
                   sum => sum,
                   cout => cout );
                   
    stimulus: process
    begin
        -- Test Case 1: Adding zero (3 + 0 = 3)
        a <= "0011";  -- 3 in binary
        b <= "0000";  -- 0 in binary
        cin <= '0';
        expected_sum <= "0011";  -- Expected sum = 3
        expected_cout <= '0';
        wait for 10 ns;
        assert (sum = expected_sum and cout = expected_cout)
        report "Test Case 1 Failed: 3 + 0"
        severity failure;

        -- Test Case 2: Adding with carry-in (7 + 1 + 1 = 9)
        a <= "0111";  -- 7 in binary
        b <= "0001";  -- 1 in binary
        cin <= '1';
        expected_sum <= "1001";  -- Expected sum = 9
        expected_cout <= '0';
        wait for 10 ns;
        assert (sum = expected_sum and cout = expected_cout)
        report "Test Case 2 Failed: 7 + 1 + carry-in 1"
        severity failure;

        -- Test Case 3: Simple addition (2 + 3 = 5)
        a <= "0010";  -- 2 in binary
        b <= "0011";  -- 3 in binary
        cin <= '0';
        expected_sum <= "0101";  -- Expected sum = 5
        expected_cout <= '0';
        wait for 10 ns;
        assert (sum = expected_sum and cout = expected_cout)
        report "Test Case 3 Failed: 2 + 3"
        severity failure;

        -- Test Case 4: Addition with carry-out (15 + 1 = 16)
        a <= "1111";  -- 15 in binary
        b <= "0001";  -- 1 in binary
        cin <= '0';
        expected_sum <= "0000";  -- Expected sum = 0 (16 in binary is 10000)
        expected_cout <= '1';
        wait for 10 ns;
        assert (sum = expected_sum and cout = expected_cout)
        report "Test Case 4 Failed: 15 + 1"
        severity failure;

        -- Test Case 5: Addition with larger numbers (15 + 12 = 27)
        a <= "1111";  -- 15 in binary
        b <= "1100";  -- 12 in binary
        cin <= '0';
        expected_sum <= "1011";  -- Expected sum (27) 
        expected_cout <= '1';    -- Expected carry out due to overflow (27 > 16)
        wait for 10 ns;
        assert (sum = expected_sum and cout = expected_cout)
        report "Test Case 5 Failed: 15 + 12"
        severity failure;

        wait;
    end process;

    bcd_converter: process(sum)
        variable temp: INTEGER;
    begin
        temp := CONV_INTEGER(sum) + (CONV_INTEGER(cout) * 16); 

        bcd_tens <= conv_std_logic_vector((temp / 10) mod 10, 4);
        bcd_ones <= conv_std_logic_vector(temp mod 10, 4);
    end process;

end Behavioral;
