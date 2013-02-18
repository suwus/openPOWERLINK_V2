-------------------------------------------------------------------------------
--! @file toplevel.vhd
--
--! @brief Toplevel of dual Nios MN design
--
--! @details This is the toplevel of the dual Nios MN FPGA design for the
--! INK DE2-115 Evaluation Board.
--
-------------------------------------------------------------------------------
--
--    (c) B&R, 2012
--
--    Redistribution and use in source and binary forms, with or without
--    modification, are permitted provided that the following conditions
--    are met:
--
--    1. Redistributions of source code must retain the above copyright
--       notice, this list of conditions and the following disclaimer.
--
--    2. Redistributions in binary form must reproduce the above copyright
--       notice, this list of conditions and the following disclaimer in the
--       documentation and/or other materials provided with the distribution.
--
--    3. Neither the name of B&R nor the names of its
--       contributors may be used to endorse or promote products derived
--       from this software without prior written permission. For written
--       permission, please contact office@br-automation.com
--
--    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
--    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
--    COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
--    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
--    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
--    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
--    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
--    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
--    POSSIBILITY OF SUCH DAMAGE.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;

entity toplevel is
    port (
        -- 50 MHZ CLK IN
        EXT_CLK :  in  std_logic;
        -- PHY0 Interface
        PHY0_GXCLK :  out  std_logic;
        PHY0_RXCLK :  in  std_logic;
        PHY0_RXER :  in  std_logic;
        PHY0_RXDV :  in  std_logic;
        PHY0_RXD :  in  std_logic_vector(3 downto 0);
        PHY0_TXCLK :  in  std_logic;
        PHY0_TXER :  out  std_logic;
        PHY0_TXEN :  out  std_logic;
        PHY0_TXD :  out  std_logic_vector(3 downto 0);
        PHY0_LINK :  in  std_logic;
        PHY0_MDIO :  inout  std_logic;
        PHY0_MDC :  out  std_logic;
        PHY0_RESET_n :  out  std_logic;
        -- PHY1 Interface
        PHY1_GXCLK :  out  std_logic;
        PHY1_RXCLK :  in  std_logic;
        PHY1_RXER :  in  std_logic;
        PHY1_RXDV :  in  std_logic;
        PHY1_RXD :  in  std_logic_vector(3 downto 0);
        PHY1_TXCLK :  in  std_logic;
        PHY1_TXER :  out  std_logic;
        PHY1_TXEN :  out  std_logic;
        PHY1_TXD :  out  std_logic_vector(3 downto 0);
        PHY1_LINK :  in  std_logic;
        PHY1_MDIO :  inout  std_logic;
        PHY1_MDC :  out  std_logic;
        PHY1_RESET_n :  out  std_logic;
        -- EPCS
        EPCS_DCLK :  out  std_logic;
        EPCS_SCE :  out  std_logic;
        EPCS_SDO :  out  std_logic;
        EPCS_DATA0 :  in  std_logic;
        -- 2 MB SRAM
        SRAM_CE_n :  out  std_logic;
        SRAM_OE_n :  out  std_logic;
        SRAM_WE_n :  out  std_logic;
        SRAM_ADDR :  out  std_logic_vector(20 downto 1);
        SRAM_BE_n :  out  std_logic_vector(1 downto 0);
        SRAM_DQ :  inout  std_logic_vector(15 downto 0);
        -- 64 MBx2 SDRAM
        SDRAM_CLK :  out  std_logic;
        SDRAM_CAS_n :  out  std_logic;
        SDRAM_CKE :  out  std_logic;
        SDRAM_CS_n :  out  std_logic;
        SDRAM_RAS_n :  out  std_logic;
        SDRAM_WE_n :  out  std_logic;
        SDRAM_ADDR :  out  std_logic_vector(12 downto 0);
        SDRAM_BA :  out  std_logic_vector(1 downto 0);
        SDRAM_DQM :  out  std_logic_vector(3 downto 0);
        SDRAM_DQ :  inout  std_logic_vector(31 downto 0);
        -- KEY
        KEY :  in  std_logic_vector(3 downto 0);
        -- SW
        SW :  in  std_logic_vector(7 downto 0);
        -- LED green
        LEDG :  out  std_logic_vector(1 downto 0);
        -- LED red
        LEDR :  out  std_logic_vector(3 downto 0);
        -- LCD
        LCD_EN :  out  std_logic;
        LCD_RS :  out  std_logic;
        LCD_ON :  out  std_logic;
        LCD_RW :  out  std_logic;
        LCD_DATA :  inout  std_logic_vector(7 downto 0);
        BENCHMARK_IO : out std_logic_vector(7 downto 0)
    );
end toplevel;

architecture rtl of toplevel is

    component top_mn is
        port (
            clk_clk                                               : in    std_logic                     := 'X';             -- clk
            reset_reset_n                                         : in    std_logic                     := 'X';             -- reset_n
            clk100sdram_clk                                       : out   std_logic;                                        -- clk
            altpll_0_areset_conduit_export                        : in    std_logic                     := 'X';             -- export
            altpll_0_locked_conduit_export                        : out   std_logic;                                        -- export
            altpll_0_phasedone_conduit_export                     : out   std_logic;                                        -- export
            pcp_0_tri_state_0_tcm_address_out                     : out   std_logic_vector(20 downto 0);                    -- tcm_address_out
            pcp_0_tri_state_0_tcm_byteenable_n_out                : out   std_logic_vector(1 downto 0);                     -- tcm_byteenable_n_out
            pcp_0_tri_state_0_tcm_read_n_out                      : out   std_logic;                                        -- tcm_read_n_out
            pcp_0_tri_state_0_tcm_write_n_out                     : out   std_logic;                                        -- tcm_write_n_out
            pcp_0_tri_state_0_tcm_data_out                        : inout std_logic_vector(15 downto 0) := (others => 'X'); -- tcm_data_out
            pcp_0_tri_state_0_tcm_chipselect_n_out                : out   std_logic;                                        -- tcm_chipselect_n_out
            pcp_0_benchmark_pio_external_connection_export        : out   std_logic_vector(7 downto 0);                     -- export
            pcp_0_powerlink_0_phym0_SMIClk                        : out   std_logic;                                        -- SMIClk
            pcp_0_powerlink_0_phym0_SMIDat                        : inout std_logic                     := 'X';             -- SMIDat
            pcp_0_powerlink_0_phym0_Rst_n                         : out   std_logic;                                        -- Rst_n
            pcp_0_powerlink_0_phym1_SMIClk                        : out   std_logic;                                        -- SMIClk
            pcp_0_powerlink_0_phym1_SMIDat                        : inout std_logic                     := 'X';             -- SMIDat
            pcp_0_powerlink_0_phym1_Rst_n                         : out   std_logic;                                        -- Rst_n
            pcp_0_powerlink_0_mii0_phyMii0_TxClk                  : in    std_logic                     := 'X';             -- phyMii0_TxClk
            pcp_0_powerlink_0_mii0_phyMii0_TxEn                   : out   std_logic;                                        -- phyMii0_TxEn
            pcp_0_powerlink_0_mii0_phyMii0_TxEr                   : out   std_logic;                                        -- phyMii0_TxEr
            pcp_0_powerlink_0_mii0_phyMii0_TxDat                  : out   std_logic_vector(3 downto 0);                     -- phyMii0_TxDat
            pcp_0_powerlink_0_mii0_phyMii0_RxClk                  : in    std_logic                     := 'X';             -- phyMii0_RxClk
            pcp_0_powerlink_0_mii0_phyMii0_RxDv                   : in    std_logic                     := 'X';             -- phyMii0_RxDv
            pcp_0_powerlink_0_mii0_phyMii0_RxEr                   : in    std_logic                     := 'X';             -- phyMii0_RxEr
            pcp_0_powerlink_0_mii0_phyMii0_RxDat                  : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- phyMii0_RxDat
            pcp_0_powerlink_0_mii0_phyMii1_RxEr                   : in    std_logic                     := 'X';             -- phyMii1_RxEr
            pcp_0_powerlink_0_mii1_TxClk                          : in    std_logic                     := 'X';             -- TxClk
            pcp_0_powerlink_0_mii1_TxEn                           : out   std_logic;                                        -- TxEn
            pcp_0_powerlink_0_mii1_TxEr                           : out   std_logic;                                        -- TxEr
            pcp_0_powerlink_0_mii1_TxDat                          : out   std_logic_vector(3 downto 0);                     -- TxDat
            pcp_0_powerlink_0_mii1_RxClk                          : in    std_logic                     := 'X';             -- RxClk
            pcp_0_powerlink_0_mii1_RxDv                           : in    std_logic                     := 'X';             -- RxDv
            pcp_0_powerlink_0_mii1_RxDat                          : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- RxDat
            host_0_benchmark_pio_external_connection_export       : out   std_logic_vector(7 downto 0);                     -- export
            host_0_sw_pio_external_connection_export              : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export
            host_0_key_pio_external_connection_export             : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
            host_0_led_pio_external_connection_export             : out   std_logic_vector(3 downto 0);                     -- export
            host_0_led_status_error_pio_external_connection_export: out   std_logic_vector(1 downto 0);                     -- export
            host_0_lcd_0_external_data                            : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- data
            host_0_lcd_0_external_E                               : out   std_logic;                                        -- E
            host_0_lcd_0_external_RS                              : out   std_logic;                                        -- RS
            host_0_lcd_0_external_RW                              : out   std_logic;                                        -- RW
            host_0_epcs_flash_controller_0_external_dclk          : out   std_logic;                                        -- dclk
            host_0_epcs_flash_controller_0_external_sce           : out   std_logic;                                        -- sce
            host_0_epcs_flash_controller_0_external_sdo           : out   std_logic;                                        -- sdo
            host_0_epcs_flash_controller_0_external_data0         : in    std_logic                     := 'X';             -- data0
            host_0_sdram_0_wire_addr                              : out   std_logic_vector(12 downto 0);                    -- addr
            host_0_sdram_0_wire_ba                                : out   std_logic_vector(1 downto 0);                     -- ba
            host_0_sdram_0_wire_cas_n                             : out   std_logic;                                        -- cas_n
            host_0_sdram_0_wire_cke                               : out   std_logic;                                        -- cke
            host_0_sdram_0_wire_cs_n                              : out   std_logic;                                        -- cs_n
            host_0_sdram_0_wire_dq                                : inout std_logic_vector(31 downto 0) := (others => 'X'); -- dq
            host_0_sdram_0_wire_dqm                               : out   std_logic_vector(3 downto 0);                     -- dqm
            host_0_sdram_0_wire_ras_n                             : out   std_logic;                                        -- ras_n
            host_0_sdram_0_wire_we_n                              : out   std_logic                                         -- we_n
        );
    end component top_mn;

    signal pllLocked : std_logic;
    signal sramAddr : std_logic_vector(SRAM_ADDR'high downto 0);

begin

    LCD_ON <= '1';

    SRAM_ADDR <= sramAddr(SRAM_ADDR'range);

    PHY0_GXCLK <= '0';
    PHY1_GXCLK <= '0';

    inst : component top_mn
        port map (
            clk_clk                                                 => EXT_CLK,
            altpll_0_areset_conduit_export                          => '0',
            altpll_0_locked_conduit_export                          => pllLocked,
            altpll_0_phasedone_conduit_export                       => open,
            reset_reset_n                                           => pllLocked,

            pcp_0_powerlink_0_mii0_phyMii0_TxClk                    => PHY0_TXCLK,
            pcp_0_powerlink_0_mii0_phyMii0_TxEn                     => PHY0_TXEN,
            pcp_0_powerlink_0_mii0_phyMii0_TxEr                     => PHY0_TXER,
            pcp_0_powerlink_0_mii0_phyMii0_TxDat                    => PHY0_TXD,
            pcp_0_powerlink_0_mii0_phyMii0_RxClk                    => PHY0_RXCLK,
            pcp_0_powerlink_0_mii0_phyMii0_RxDv                     => PHY0_RXDV,
            pcp_0_powerlink_0_mii0_phyMii0_RxEr                     => PHY0_RXER,
            pcp_0_powerlink_0_mii0_phyMii0_RxDat                    => PHY0_RXD,
            pcp_0_powerlink_0_phym0_SMIClk                          => PHY0_MDC,
            pcp_0_powerlink_0_phym0_SMIDat                          => PHY0_MDIO,
            pcp_0_powerlink_0_phym0_Rst_n                           => PHY0_RESET_n,

            pcp_0_powerlink_0_mii1_TxClk                            => PHY1_TXCLK,
            pcp_0_powerlink_0_mii1_TxEn                             => PHY1_TXEN,
            pcp_0_powerlink_0_mii1_TxEr                             => PHY1_TXER,
            pcp_0_powerlink_0_mii1_TxDat                            => PHY1_TXD,
            pcp_0_powerlink_0_mii1_RxClk                            => PHY1_RXCLK,
            pcp_0_powerlink_0_mii1_RxDv                             => PHY1_RXDV,
            pcp_0_powerlink_0_mii1_RxDat                            => PHY1_RXD,
            pcp_0_powerlink_0_mii0_phyMii1_RxEr                     => PHY1_RXER,
            pcp_0_powerlink_0_phym1_SMIClk                          => PHY1_MDC,
            pcp_0_powerlink_0_phym1_SMIDat                          => PHY1_MDIO,
            pcp_0_powerlink_0_phym1_Rst_n                           => PHY1_RESET_n,

            pcp_0_tri_state_0_tcm_address_out                       => sramAddr,
            pcp_0_tri_state_0_tcm_read_n_out                        => SRAM_OE_n,
            pcp_0_tri_state_0_tcm_byteenable_n_out                  => SRAM_BE_n,
            pcp_0_tri_state_0_tcm_write_n_out                       => SRAM_WE_n,
            pcp_0_tri_state_0_tcm_data_out                          => SRAM_DQ,
            pcp_0_tri_state_0_tcm_chipselect_n_out                  => SRAM_CE_n,

            pcp_0_benchmark_pio_external_connection_export          => BENCHMARK_IO,

            host_0_led_status_error_pio_external_connection_export  => LEDG,

            host_0_benchmark_pio_external_connection_export         => open,

            host_0_key_pio_external_connection_export               => KEY,

            host_0_sw_pio_external_connection_export                => SW,

            host_0_led_pio_external_connection_export               => LEDR,

            host_0_lcd_0_external_data                              => LCD_DATA,
            host_0_lcd_0_external_E                                 => LCD_EN,
            host_0_lcd_0_external_RS                                => LCD_RS,
            host_0_lcd_0_external_RW                                => LCD_RW,

            host_0_epcs_flash_controller_0_external_dclk            => EPCS_DCLK,
            host_0_epcs_flash_controller_0_external_sce             => EPCS_SCE,
            host_0_epcs_flash_controller_0_external_sdo             => EPCS_SDO,
            host_0_epcs_flash_controller_0_external_data0           => EPCS_DATA0,

            clk100sdram_clk                                         => SDRAM_CLK,
            host_0_sdram_0_wire_addr                                => SDRAM_ADDR,
            host_0_sdram_0_wire_ba                                  => SDRAM_BA,
            host_0_sdram_0_wire_cas_n                               => SDRAM_CAS_n,
            host_0_sdram_0_wire_cke                                 => SDRAM_CKE,
            host_0_sdram_0_wire_cs_n                                => SDRAM_CS_n,
            host_0_sdram_0_wire_dq                                  => SDRAM_DQ,
            host_0_sdram_0_wire_dqm                                 => SDRAM_DQM,
            host_0_sdram_0_wire_ras_n                               => SDRAM_RAS_n,
            host_0_sdram_0_wire_we_n                                => SDRAM_WE_n
        );

end rtl;