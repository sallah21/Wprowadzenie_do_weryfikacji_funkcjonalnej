library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_VHDL is
  --  port ();
end entity tb_VHDL;

architecture Behavioral of tb_VHDL is 
    signal clk : std_logic := '0';

    signal data_out : std_logic_vector(7 downto 0) := x"00";
    signal data_in : std_logic_vector(7 downto 0) := x"00";

    signal FIFO_clr_n : std_logic := '1';
    signal FIFO_reset_n : std_logic := '1';
    signal push : std_logic := '0';
    signal pop : std_logic := '0';

begin
    DUT: entity work.fifo
    port map (
        clk       => clk,
        rst_n     => FIFO_reset_n,
        wr_en    => push,
        rd_en    => pop,
        data_in  => data_in,
        data_out => data_out,
        empty    => open,
        full     => open
    );
    classic_tb1: process
    begin
        clk <= '1';wait for 10 ns;
        clk <= '0';wait for 10 ns;
        clk <= '1';wait for 10 ns;
        clk <= '0';wait for 10 ns;
        clk <= '1';wait for 10 ns;
        clk <= '0';wait for 10 ns;
        clk <= '1';wait for 10 ns;
        clk <= '0';wait for 10 ns;
        clk <= '1';wait for 10 ns;
        clk <= '0';wait for 10 ns;
    end process classic_tb1;

    -- classic_tb2: process
    -- begin
    --     push <= '1';pop <= '0';data_in <= x"01";wait for 10 ns;
    --     push <= '0';pop <= '1';wait for 10 ns;
    --     push <= '1';pop <= '0';data_in <= x"02";wait for 10 ns;
    --     push <= '0';pop <= '1';wait for 10 ns;
    --     push <= '1';pop <= '0';data_in <= x"03";wait for 10 ns;
    --     push <= '0';pop <= '1';wait for 10 ns;
    --     push <= '1';pop <= '0';data_in <= x"04";wait for 10 ns;

    -- end process classic_tb2;
end Behavioral;
