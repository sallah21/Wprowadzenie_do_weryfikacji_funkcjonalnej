library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity fifo_tb is
end entity fifo_tb;

architecture behavior of fifo_tb is
    -- Component Declaration
    component fifo
        generic (
            DATA_WIDTH : integer := 8;
            FIFO_DEPTH : integer := 16
        );
        port (
            clk         : in  std_logic;
            rst_n       : in  std_logic;
            wr_en      : in  std_logic;
            rd_en      : in  std_logic;
            data_in    : in  std_logic_vector(DATA_WIDTH-1 downto 0);
            data_out   : out std_logic_vector(DATA_WIDTH-1 downto 0);
            empty      : out std_logic;
            full       : out std_logic
        );
    end component;

    -- Constants
    constant CLK_PERIOD : time := 10 ns;
    constant DATA_WIDTH : integer := 8;
    constant FIFO_DEPTH : integer := 16;

    -- Signals
    signal clk         : std_logic := '0';
    signal rst_n       : std_logic := '0';
    signal wr_en      : std_logic := '0';
    signal rd_en      : std_logic := '0';
    signal data_in    : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    signal data_out   : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal empty      : std_logic;
    signal full       : std_logic;

    -- Test status
    signal test_done : boolean := false;

begin
    -- Clock generation
    clk <= not clk after CLK_PERIOD/2 when not test_done else '0';

    -- DUT instantiation
    DUT: fifo
    generic map (
        DATA_WIDTH => DATA_WIDTH,
        FIFO_DEPTH => FIFO_DEPTH
    )
    port map (
        clk       => clk,
        rst_n     => rst_n,
        wr_en    => wr_en,
        rd_en    => rd_en,
        data_in  => data_in,
        data_out => data_out,
        empty    => empty,
        full     => full
    );

    -- Test process
    test_proc: process
        -- Procedure for writing to FIFO
        procedure write_fifo(data : in std_logic_vector(DATA_WIDTH-1 downto 0)) is
        begin
            wait until rising_edge(clk);
            wr_en <= '1';
            data_in <= data;
            wait until rising_edge(clk);
            wr_en <= '0';
        end procedure;

        -- Procedure for reading from FIFO
        procedure read_fifo is
        begin
            wait until rising_edge(clk);
            rd_en <= '1';
            wait until rising_edge(clk);
            rd_en <= '0';
        end procedure;

    begin
        -- Initial reset
        rst_n <= '0';
        wait for CLK_PERIOD * 2;
        rst_n <= '1';
        wait for CLK_PERIOD;

        -- Test 1: Write and read single value
        report "Test 1: Write and read single value";
        write_fifo(x"A5");
        wait for CLK_PERIOD;
        assert empty = '0' report "FIFO should not be empty after write" severity error;
        read_fifo;
        wait for CLK_PERIOD;
        assert data_out = x"A5" report "Read data mismatch" severity error;
        assert empty = '1' report "FIFO should be empty after read" severity error;

        -- Test 2: Fill FIFO
        report "Test 2: Fill FIFO";
        for i in 0 to FIFO_DEPTH-1 loop
            write_fifo(std_logic_vector(to_unsigned(i, DATA_WIDTH)));
            wait for CLK_PERIOD;
        end loop;
        assert full = '1' report "FIFO should be full" severity error;

        -- Test 3: Read all values
        report "Test 3: Read all values";
        for i in 0 to FIFO_DEPTH-1 loop
            read_fifo;
            wait for CLK_PERIOD;
            assert data_out = std_logic_vector(to_unsigned(i, DATA_WIDTH))
                report "Read data mismatch at index " & integer'image(i) severity error;
        end loop;
        assert empty = '1' report "FIFO should be empty after reading all values" severity error;

        -- Test 4: Write/Read alternating
        report "Test 4: Write/Read alternating";
        for i in 0 to 4 loop
            write_fifo(std_logic_vector(to_unsigned(i, DATA_WIDTH)));
            wait for CLK_PERIOD;
            read_fifo;
            wait for CLK_PERIOD;
            assert data_out = std_logic_vector(to_unsigned(i, DATA_WIDTH))
                report "Read data mismatch in alternating test" severity error;
        end loop;

        -- Test 5: Reset during operation
        report "Test 5: Reset during operation";
        write_fifo(x"FF");
        write_fifo(x"EE");
        rst_n <= '0';
        wait for CLK_PERIOD * 2;
        rst_n <= '1';
        wait for CLK_PERIOD;
        assert empty = '1' report "FIFO should be empty after reset" severity error;

        -- End simulation
        report "All tests completed";
        test_done <= true;
        wait;
    end process;

end architecture behavior;