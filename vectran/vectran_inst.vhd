	component vectran is
		port (
			clk    : in  std_logic                     := 'X';             -- clk
			areset : in  std_logic                     := 'X';             -- reset
			x      : in  std_logic_vector(15 downto 0) := (others => 'X'); -- x
			y      : in  std_logic_vector(15 downto 0) := (others => 'X'); -- y
			q      : out std_logic_vector(15 downto 0);                    -- q
			r      : out std_logic_vector(15 downto 0);                    -- r
			en     : in  std_logic_vector(0 downto 0)  := (others => 'X')  -- en
		);
	end component vectran;

	u0 : component vectran
		port map (
			clk    => CONNECTED_TO_clk,    --    clk.clk
			areset => CONNECTED_TO_areset, -- areset.reset
			x      => CONNECTED_TO_x,      --      x.x
			y      => CONNECTED_TO_y,      --      y.y
			q      => CONNECTED_TO_q,      --      q.q
			r      => CONNECTED_TO_r,      --      r.r
			en     => CONNECTED_TO_en      --     en.en
		);

