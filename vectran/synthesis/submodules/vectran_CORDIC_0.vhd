-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 18.1 (Release Build #625)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2018 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from vectran_CORDIC_0
-- VHDL created on Thu Mar 21 17:27:36 2019


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity vectran_CORDIC_0 is
    port (
        x : in std_logic_vector(15 downto 0);  -- sfix16_en15
        y : in std_logic_vector(15 downto 0);  -- sfix16_en15
        en : in std_logic_vector(0 downto 0);  -- ufix1
        q : out std_logic_vector(15 downto 0);  -- sfix16_en13
        r : out std_logic_vector(15 downto 0);  -- ufix16_en14
        clk : in std_logic;
        areset : in std_logic
    );
end vectran_CORDIC_0;

architecture normal of vectran_CORDIC_0 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal constantZero_uid6_vecTranslateTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal signX_uid7_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signY_uid8_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal invSignX_uid9_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal absXE_uid10_vecTranslateTest_a : STD_LOGIC_VECTOR (17 downto 0);
    signal absXE_uid10_vecTranslateTest_b : STD_LOGIC_VECTOR (17 downto 0);
    signal absXE_uid10_vecTranslateTest_o : STD_LOGIC_VECTOR (17 downto 0);
    signal absXE_uid10_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal absXE_uid10_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal invSignY_uid11_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal absYE_uid12_vecTranslateTest_a : STD_LOGIC_VECTOR (17 downto 0);
    signal absYE_uid12_vecTranslateTest_b : STD_LOGIC_VECTOR (17 downto 0);
    signal absYE_uid12_vecTranslateTest_o : STD_LOGIC_VECTOR (17 downto 0);
    signal absYE_uid12_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal absYE_uid12_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal absX_uid13_vecTranslateTest_in : STD_LOGIC_VECTOR (15 downto 0);
    signal absX_uid13_vecTranslateTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal absY_uid14_vecTranslateTest_in : STD_LOGIC_VECTOR (15 downto 0);
    signal absY_uid14_vecTranslateTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal yNotZero_uid15_vecTranslateTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal yNotZero_uid15_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal yZero_uid16_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xNotZero_uid17_vecTranslateTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal xNotZero_uid17_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xZero_uid18_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_1_uid23_vecTranslateTest_a : STD_LOGIC_VECTOR (16 downto 0);
    signal xip1E_1_uid23_vecTranslateTest_b : STD_LOGIC_VECTOR (16 downto 0);
    signal xip1E_1_uid23_vecTranslateTest_o : STD_LOGIC_VECTOR (16 downto 0);
    signal xip1E_1_uid23_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal yip1E_1_uid24_vecTranslateTest_a : STD_LOGIC_VECTOR (16 downto 0);
    signal yip1E_1_uid24_vecTranslateTest_b : STD_LOGIC_VECTOR (16 downto 0);
    signal yip1E_1_uid24_vecTranslateTest_o : STD_LOGIC_VECTOR (16 downto 0);
    signal yip1E_1_uid24_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal xMSB_uid32_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal invSignOfSelectionSignal_uid37_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_2NA_uid39_vecTranslateTest_q : STD_LOGIC_VECTOR (17 downto 0);
    signal xip1E_2sumAHighB_uid40_vecTranslateTest_a : STD_LOGIC_VECTOR (20 downto 0);
    signal xip1E_2sumAHighB_uid40_vecTranslateTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal xip1E_2sumAHighB_uid40_vecTranslateTest_o : STD_LOGIC_VECTOR (20 downto 0);
    signal xip1E_2sumAHighB_uid40_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_2sumAHighB_uid40_vecTranslateTest_q : STD_LOGIC_VECTOR (19 downto 0);
    signal yip1E_2NA_uid42_vecTranslateTest_q : STD_LOGIC_VECTOR (17 downto 0);
    signal yip1E_2sumAHighB_uid43_vecTranslateTest_a : STD_LOGIC_VECTOR (19 downto 0);
    signal yip1E_2sumAHighB_uid43_vecTranslateTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal yip1E_2sumAHighB_uid43_vecTranslateTest_o : STD_LOGIC_VECTOR (19 downto 0);
    signal yip1E_2sumAHighB_uid43_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_2sumAHighB_uid43_vecTranslateTest_q : STD_LOGIC_VECTOR (18 downto 0);
    signal xip1_2_uid48_vecTranslateTest_in : STD_LOGIC_VECTOR (17 downto 0);
    signal xip1_2_uid48_vecTranslateTest_b : STD_LOGIC_VECTOR (17 downto 0);
    signal yip1_2_uid49_vecTranslateTest_in : STD_LOGIC_VECTOR (17 downto 0);
    signal yip1_2_uid49_vecTranslateTest_b : STD_LOGIC_VECTOR (17 downto 0);
    signal xMSB_uid51_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal invSignOfSelectionSignal_uid56_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_3CostZeroPaddingA_uid57_vecTranslateTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal xip1E_3NA_uid58_vecTranslateTest_q : STD_LOGIC_VECTOR (19 downto 0);
    signal xip1E_3sumAHighB_uid59_vecTranslateTest_a : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1E_3sumAHighB_uid59_vecTranslateTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1E_3sumAHighB_uid59_vecTranslateTest_o : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1E_3sumAHighB_uid59_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_3sumAHighB_uid59_vecTranslateTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal yip1E_3NA_uid61_vecTranslateTest_q : STD_LOGIC_VECTOR (19 downto 0);
    signal yip1E_3sumAHighB_uid62_vecTranslateTest_a : STD_LOGIC_VECTOR (21 downto 0);
    signal yip1E_3sumAHighB_uid62_vecTranslateTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal yip1E_3sumAHighB_uid62_vecTranslateTest_o : STD_LOGIC_VECTOR (21 downto 0);
    signal yip1E_3sumAHighB_uid62_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_3sumAHighB_uid62_vecTranslateTest_q : STD_LOGIC_VECTOR (20 downto 0);
    signal xip1_3_uid67_vecTranslateTest_in : STD_LOGIC_VECTOR (19 downto 0);
    signal xip1_3_uid67_vecTranslateTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal yip1_3_uid68_vecTranslateTest_in : STD_LOGIC_VECTOR (18 downto 0);
    signal yip1_3_uid68_vecTranslateTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal xMSB_uid70_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal invSignOfSelectionSignal_uid75_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_4CostZeroPaddingA_uid76_vecTranslateTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal xip1E_4NA_uid77_vecTranslateTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1E_4sumAHighB_uid78_vecTranslateTest_a : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_4sumAHighB_uid78_vecTranslateTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_4sumAHighB_uid78_vecTranslateTest_o : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_4sumAHighB_uid78_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_4sumAHighB_uid78_vecTranslateTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal yip1E_4NA_uid80_vecTranslateTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal yip1E_4sumAHighB_uid81_vecTranslateTest_a : STD_LOGIC_VECTOR (23 downto 0);
    signal yip1E_4sumAHighB_uid81_vecTranslateTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal yip1E_4sumAHighB_uid81_vecTranslateTest_o : STD_LOGIC_VECTOR (23 downto 0);
    signal yip1E_4sumAHighB_uid81_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_4sumAHighB_uid81_vecTranslateTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1_4_uid86_vecTranslateTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1_4_uid86_vecTranslateTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1_4_uid87_vecTranslateTest_in : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1_4_uid87_vecTranslateTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal xMSB_uid89_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal invSignOfSelectionSignal_uid94_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_5CostZeroPaddingA_uid95_vecTranslateTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal xip1E_5NA_uid96_vecTranslateTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal xip1E_5sumAHighB_uid97_vecTranslateTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1E_5sumAHighB_uid97_vecTranslateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1E_5sumAHighB_uid97_vecTranslateTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1E_5sumAHighB_uid97_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_5sumAHighB_uid97_vecTranslateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal yip1E_5NA_uid99_vecTranslateTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal yip1E_5sumAHighB_uid100_vecTranslateTest_a : STD_LOGIC_VECTOR (26 downto 0);
    signal yip1E_5sumAHighB_uid100_vecTranslateTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal yip1E_5sumAHighB_uid100_vecTranslateTest_o : STD_LOGIC_VECTOR (26 downto 0);
    signal yip1E_5sumAHighB_uid100_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_5sumAHighB_uid100_vecTranslateTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1_5_uid105_vecTranslateTest_in : STD_LOGIC_VECTOR (26 downto 0);
    signal xip1_5_uid105_vecTranslateTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal yip1_5_uid106_vecTranslateTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal yip1_5_uid106_vecTranslateTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal xMSB_uid108_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal invSignOfSelectionSignal_uid113_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_6CostZeroPaddingA_uid114_vecTranslateTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal xip1E_6NA_uid115_vecTranslateTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal xip1E_6sumAHighB_uid116_vecTranslateTest_a : STD_LOGIC_VECTOR (34 downto 0);
    signal xip1E_6sumAHighB_uid116_vecTranslateTest_b : STD_LOGIC_VECTOR (34 downto 0);
    signal xip1E_6sumAHighB_uid116_vecTranslateTest_o : STD_LOGIC_VECTOR (34 downto 0);
    signal xip1E_6sumAHighB_uid116_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_6sumAHighB_uid116_vecTranslateTest_q : STD_LOGIC_VECTOR (33 downto 0);
    signal yip1E_6NA_uid118_vecTranslateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal yip1E_6sumAHighB_uid119_vecTranslateTest_a : STD_LOGIC_VECTOR (30 downto 0);
    signal yip1E_6sumAHighB_uid119_vecTranslateTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal yip1E_6sumAHighB_uid119_vecTranslateTest_o : STD_LOGIC_VECTOR (30 downto 0);
    signal yip1E_6sumAHighB_uid119_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_6sumAHighB_uid119_vecTranslateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_6_uid124_vecTranslateTest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal xip1_6_uid124_vecTranslateTest_b : STD_LOGIC_VECTOR (31 downto 0);
    signal yip1_6_uid125_vecTranslateTest_in : STD_LOGIC_VECTOR (27 downto 0);
    signal yip1_6_uid125_vecTranslateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal xMSB_uid127_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid131_vecTranslateTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal twoToMiSiYip_uid132_vecTranslateTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal invSignOfSelectionSignal_uid134_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_7NA_uid136_vecTranslateTest_q : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1E_7sumAHighB_uid137_vecTranslateTest_a : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_7sumAHighB_uid137_vecTranslateTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_7sumAHighB_uid137_vecTranslateTest_o : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_7sumAHighB_uid137_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_7sumAHighB_uid137_vecTranslateTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal yip1E_7NA_uid139_vecTranslateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal yip1E_7sumAHighB_uid140_vecTranslateTest_a : STD_LOGIC_VECTOR (30 downto 0);
    signal yip1E_7sumAHighB_uid140_vecTranslateTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal yip1E_7sumAHighB_uid140_vecTranslateTest_o : STD_LOGIC_VECTOR (30 downto 0);
    signal yip1E_7sumAHighB_uid140_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_7sumAHighB_uid140_vecTranslateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_7_uid145_vecTranslateTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1_7_uid145_vecTranslateTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1_7_uid146_vecTranslateTest_in : STD_LOGIC_VECTOR (27 downto 0);
    signal yip1_7_uid146_vecTranslateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal xMSB_uid148_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid152_vecTranslateTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal twoToMiSiYip_uid153_vecTranslateTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal invSignOfSelectionSignal_uid155_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_8_uid156_vecTranslateTest_a : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_8_uid156_vecTranslateTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_8_uid156_vecTranslateTest_o : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_8_uid156_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_8_uid156_vecTranslateTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal yip1E_8_uid157_vecTranslateTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal yip1E_8_uid157_vecTranslateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal yip1E_8_uid157_vecTranslateTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal yip1E_8_uid157_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_8_uid157_vecTranslateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal xip1_8_uid162_vecTranslateTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1_8_uid162_vecTranslateTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1_8_uid163_vecTranslateTest_in : STD_LOGIC_VECTOR (26 downto 0);
    signal yip1_8_uid163_vecTranslateTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal xMSB_uid165_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid169_vecTranslateTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal twoToMiSiYip_uid170_vecTranslateTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal invSignOfSelectionSignal_uid172_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_9_uid173_vecTranslateTest_a : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_9_uid173_vecTranslateTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_9_uid173_vecTranslateTest_o : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_9_uid173_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_9_uid173_vecTranslateTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal yip1E_9_uid174_vecTranslateTest_a : STD_LOGIC_VECTOR (28 downto 0);
    signal yip1E_9_uid174_vecTranslateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal yip1E_9_uid174_vecTranslateTest_o : STD_LOGIC_VECTOR (28 downto 0);
    signal yip1E_9_uid174_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_9_uid174_vecTranslateTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal xip1_9_uid179_vecTranslateTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1_9_uid179_vecTranslateTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1_9_uid180_vecTranslateTest_in : STD_LOGIC_VECTOR (25 downto 0);
    signal yip1_9_uid180_vecTranslateTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal xMSB_uid182_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid186_vecTranslateTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal twoToMiSiYip_uid187_vecTranslateTest_b : STD_LOGIC_VECTOR (16 downto 0);
    signal invSignOfSelectionSignal_uid189_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_10_uid190_vecTranslateTest_a : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_10_uid190_vecTranslateTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_10_uid190_vecTranslateTest_o : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_10_uid190_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_10_uid190_vecTranslateTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal yip1E_10_uid191_vecTranslateTest_a : STD_LOGIC_VECTOR (27 downto 0);
    signal yip1E_10_uid191_vecTranslateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal yip1E_10_uid191_vecTranslateTest_o : STD_LOGIC_VECTOR (27 downto 0);
    signal yip1E_10_uid191_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_10_uid191_vecTranslateTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal xip1_10_uid196_vecTranslateTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1_10_uid196_vecTranslateTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1_10_uid197_vecTranslateTest_in : STD_LOGIC_VECTOR (24 downto 0);
    signal yip1_10_uid197_vecTranslateTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal xMSB_uid199_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid203_vecTranslateTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal twoToMiSiYip_uid204_vecTranslateTest_b : STD_LOGIC_VECTOR (14 downto 0);
    signal invSignOfSelectionSignal_uid206_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_11_uid207_vecTranslateTest_a : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_11_uid207_vecTranslateTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_11_uid207_vecTranslateTest_o : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_11_uid207_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_11_uid207_vecTranslateTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal yip1E_11_uid208_vecTranslateTest_a : STD_LOGIC_VECTOR (26 downto 0);
    signal yip1E_11_uid208_vecTranslateTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal yip1E_11_uid208_vecTranslateTest_o : STD_LOGIC_VECTOR (26 downto 0);
    signal yip1E_11_uid208_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_11_uid208_vecTranslateTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1_11_uid213_vecTranslateTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1_11_uid213_vecTranslateTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1_11_uid214_vecTranslateTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal yip1_11_uid214_vecTranslateTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal xMSB_uid216_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid220_vecTranslateTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal twoToMiSiYip_uid221_vecTranslateTest_b : STD_LOGIC_VECTOR (12 downto 0);
    signal invSignOfSelectionSignal_uid223_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_12_uid224_vecTranslateTest_a : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_12_uid224_vecTranslateTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_12_uid224_vecTranslateTest_o : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_12_uid224_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_12_uid224_vecTranslateTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal yip1E_12_uid225_vecTranslateTest_a : STD_LOGIC_VECTOR (25 downto 0);
    signal yip1E_12_uid225_vecTranslateTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal yip1E_12_uid225_vecTranslateTest_o : STD_LOGIC_VECTOR (25 downto 0);
    signal yip1E_12_uid225_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_12_uid225_vecTranslateTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal xip1_12_uid230_vecTranslateTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1_12_uid230_vecTranslateTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1_12_uid231_vecTranslateTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1_12_uid231_vecTranslateTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal xMSB_uid233_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid237_vecTranslateTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal twoToMiSiYip_uid238_vecTranslateTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal invSignOfSelectionSignal_uid240_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_13_uid241_vecTranslateTest_a : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_13_uid241_vecTranslateTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_13_uid241_vecTranslateTest_o : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_13_uid241_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_13_uid241_vecTranslateTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal yip1E_13_uid242_vecTranslateTest_a : STD_LOGIC_VECTOR (24 downto 0);
    signal yip1E_13_uid242_vecTranslateTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal yip1E_13_uid242_vecTranslateTest_o : STD_LOGIC_VECTOR (24 downto 0);
    signal yip1E_13_uid242_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_13_uid242_vecTranslateTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal xip1_13_uid247_vecTranslateTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1_13_uid247_vecTranslateTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1_13_uid248_vecTranslateTest_in : STD_LOGIC_VECTOR (21 downto 0);
    signal yip1_13_uid248_vecTranslateTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal xMSB_uid250_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid254_vecTranslateTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal twoToMiSiYip_uid255_vecTranslateTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal invSignOfSelectionSignal_uid257_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_14_uid258_vecTranslateTest_a : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_14_uid258_vecTranslateTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_14_uid258_vecTranslateTest_o : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_14_uid258_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_14_uid258_vecTranslateTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal yip1E_14_uid259_vecTranslateTest_a : STD_LOGIC_VECTOR (23 downto 0);
    signal yip1E_14_uid259_vecTranslateTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal yip1E_14_uid259_vecTranslateTest_o : STD_LOGIC_VECTOR (23 downto 0);
    signal yip1E_14_uid259_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_14_uid259_vecTranslateTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1_14_uid264_vecTranslateTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1_14_uid264_vecTranslateTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1_14_uid265_vecTranslateTest_in : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1_14_uid265_vecTranslateTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal xMSB_uid267_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid271_vecTranslateTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal twoToMiSiYip_uid272_vecTranslateTest_b : STD_LOGIC_VECTOR (6 downto 0);
    signal invSignOfSelectionSignal_uid274_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_15_uid275_vecTranslateTest_a : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_15_uid275_vecTranslateTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_15_uid275_vecTranslateTest_o : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_15_uid275_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_15_uid275_vecTranslateTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal yip1E_15_uid276_vecTranslateTest_a : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1E_15_uid276_vecTranslateTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1E_15_uid276_vecTranslateTest_o : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1E_15_uid276_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_15_uid276_vecTranslateTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal xip1_15_uid281_vecTranslateTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1_15_uid281_vecTranslateTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1_15_uid282_vecTranslateTest_in : STD_LOGIC_VECTOR (19 downto 0);
    signal yip1_15_uid282_vecTranslateTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal xMSB_uid284_vecTranslateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiYip_uid289_vecTranslateTest_b : STD_LOGIC_VECTOR (4 downto 0);
    signal invSignOfSelectionSignal_uid291_vecTranslateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_16_uid292_vecTranslateTest_a : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_16_uid292_vecTranslateTest_b : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_16_uid292_vecTranslateTest_o : STD_LOGIC_VECTOR (35 downto 0);
    signal xip1E_16_uid292_vecTranslateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_16_uid292_vecTranslateTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal xip1_16_uid298_vecTranslateTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1_16_uid298_vecTranslateTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal concSignVector_uid301_vecTranslateTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal table_l3_uid303_vecTranslateTest_q : STD_LOGIC_VECTOR (20 downto 0);
    signal table_l7_uid307_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal table_l11_uid311_vecTranslateTest_q : STD_LOGIC_VECTOR (12 downto 0);
    signal table_l15_uid315_vecTranslateTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal lev1_a0_uid318_vecTranslateTest_a : STD_LOGIC_VECTOR (21 downto 0);
    signal lev1_a0_uid318_vecTranslateTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal lev1_a0_uid318_vecTranslateTest_o : STD_LOGIC_VECTOR (21 downto 0);
    signal lev1_a0_uid318_vecTranslateTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal lev1_a1_uid319_vecTranslateTest_a : STD_LOGIC_VECTOR (13 downto 0);
    signal lev1_a1_uid319_vecTranslateTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal lev1_a1_uid319_vecTranslateTest_o : STD_LOGIC_VECTOR (13 downto 0);
    signal lev1_a1_uid319_vecTranslateTest_q : STD_LOGIC_VECTOR (13 downto 0);
    signal lev2_a0_uid320_vecTranslateTest_a : STD_LOGIC_VECTOR (22 downto 0);
    signal lev2_a0_uid320_vecTranslateTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal lev2_a0_uid320_vecTranslateTest_o : STD_LOGIC_VECTOR (22 downto 0);
    signal lev2_a0_uid320_vecTranslateTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal atanRes_uid321_vecTranslateTest_in : STD_LOGIC_VECTOR (20 downto 0);
    signal atanRes_uid321_vecTranslateTest_b : STD_LOGIC_VECTOR (16 downto 0);
    signal cstZeroOutFormat_uid322_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal constPiP2uE_uid323_vecTranslateTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal constPio2P2u_mergedSignalTM_uid326_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal concXZeroYZero_uid328_vecTranslateTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal atanResPostExc_uid329_vecTranslateTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal atanResPostExc_uid329_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal concSigns_uid330_vecTranslateTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal constPiP2u_uid331_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal constPi_uid332_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal constantZeroOutFormat_uid333_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal constantZeroOutFormatP2u_uid334_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal firstOperand_uid336_vecTranslateTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal firstOperand_uid336_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal secondOperand_uid337_vecTranslateTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal secondOperand_uid337_vecTranslateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal outResExtended_uid338_vecTranslateTest_a : STD_LOGIC_VECTOR (17 downto 0);
    signal outResExtended_uid338_vecTranslateTest_b : STD_LOGIC_VECTOR (17 downto 0);
    signal outResExtended_uid338_vecTranslateTest_o : STD_LOGIC_VECTOR (17 downto 0);
    signal outResExtended_uid338_vecTranslateTest_q : STD_LOGIC_VECTOR (17 downto 0);
    signal atanResPostRR_uid339_vecTranslateTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal outMagPreRnd_uid341_vecTranslateTest_b : STD_LOGIC_VECTOR (16 downto 0);
    signal outMagPostRnd_uid344_vecTranslateTest_a : STD_LOGIC_VECTOR (17 downto 0);
    signal outMagPostRnd_uid344_vecTranslateTest_b : STD_LOGIC_VECTOR (17 downto 0);
    signal outMagPostRnd_uid344_vecTranslateTest_o : STD_LOGIC_VECTOR (17 downto 0);
    signal outMagPostRnd_uid344_vecTranslateTest_q : STD_LOGIC_VECTOR (17 downto 0);
    signal outMag_uid345_vecTranslateTest_in : STD_LOGIC_VECTOR (16 downto 0);
    signal outMag_uid345_vecTranslateTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal is0_uid302_vecTranslateTest_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal is0_uid302_vecTranslateTest_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal is0_uid302_vecTranslateTest_merged_bit_select_d : STD_LOGIC_VECTOR (3 downto 0);
    signal is0_uid302_vecTranslateTest_merged_bit_select_e : STD_LOGIC_VECTOR (3 downto 0);
    signal redist0_outMag_uid345_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist1_outMagPreRnd_uid341_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (16 downto 0);
    signal redist2_twoToMiSiYip_uid289_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist3_xMSB_uid284_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_xip1_15_uid281_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist5_xMSB_uid267_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_yip1_14_uid265_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (20 downto 0);
    signal redist7_xip1_14_uid264_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist8_xMSB_uid250_vecTranslateTest_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_yip1_13_uid248_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (21 downto 0);
    signal redist10_xip1_13_uid247_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist11_xMSB_uid233_vecTranslateTest_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_yip1_12_uid231_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist13_xip1_12_uid230_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist14_xMSB_uid216_vecTranslateTest_b_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_yip1_11_uid214_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist16_xip1_11_uid213_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist17_xMSB_uid199_vecTranslateTest_b_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_yip1_10_uid197_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (24 downto 0);
    signal redist19_xip1_10_uid196_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist20_xMSB_uid182_vecTranslateTest_b_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_yip1_9_uid180_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (25 downto 0);
    signal redist22_xip1_9_uid179_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist23_xMSB_uid165_vecTranslateTest_b_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_yip1_8_uid163_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (26 downto 0);
    signal redist25_xip1_8_uid162_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist26_xMSB_uid148_vecTranslateTest_b_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist27_yip1_7_uid146_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist28_xip1_7_uid145_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist29_xMSB_uid127_vecTranslateTest_b_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist30_yip1_6_uid125_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist31_xip1_6_uid124_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist32_xMSB_uid108_vecTranslateTest_b_10_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_yip1_5_uid106_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist34_xip1_5_uid105_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (26 downto 0);
    signal redist35_xMSB_uid89_vecTranslateTest_b_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_yip1_4_uid87_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (20 downto 0);
    signal redist37_xip1_4_uid86_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist38_xMSB_uid70_vecTranslateTest_b_12_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_yip1_3_uid68_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist40_xip1_3_uid67_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (19 downto 0);
    signal redist41_xMSB_uid51_vecTranslateTest_b_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist42_yip1_2_uid49_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist43_xip1_2_uid48_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (17 downto 0);
    signal redist44_xMSB_uid32_vecTranslateTest_b_14_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist45_xNotZero_uid17_vecTranslateTest_q_17_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist46_yNotZero_uid15_vecTranslateTest_q_17_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist47_absY_uid14_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist48_absX_uid13_vecTranslateTest_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist49_signY_uid8_vecTranslateTest_b_18_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist50_signX_uid7_vecTranslateTest_b_18_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- xMSB_uid267_vecTranslateTest(BITSELECT,266)@15
    xMSB_uid267_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist6_yip1_14_uid265_vecTranslateTest_b_1_q(20 downto 20));

    -- xMSB_uid233_vecTranslateTest(BITSELECT,232)@13
    xMSB_uid233_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist12_yip1_12_uid231_vecTranslateTest_b_1_q(22 downto 22));

    -- xMSB_uid199_vecTranslateTest(BITSELECT,198)@11
    xMSB_uid199_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist18_yip1_10_uid197_vecTranslateTest_b_1_q(24 downto 24));

    -- xMSB_uid165_vecTranslateTest(BITSELECT,164)@9
    xMSB_uid165_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist24_yip1_8_uid163_vecTranslateTest_b_1_q(26 downto 26));

    -- signX_uid7_vecTranslateTest(BITSELECT,6)@0
    signX_uid7_vecTranslateTest_b <= STD_LOGIC_VECTOR(x(15 downto 15));

    -- invSignX_uid9_vecTranslateTest(LOGICAL,8)@0
    invSignX_uid9_vecTranslateTest_q <= not (signX_uid7_vecTranslateTest_b);

    -- constantZero_uid6_vecTranslateTest(CONSTANT,5)
    constantZero_uid6_vecTranslateTest_q <= "0000000000000000";

    -- absXE_uid10_vecTranslateTest(ADDSUB,9)@0
    absXE_uid10_vecTranslateTest_s <= invSignX_uid9_vecTranslateTest_q;
    absXE_uid10_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => constantZero_uid6_vecTranslateTest_q(15)) & constantZero_uid6_vecTranslateTest_q));
    absXE_uid10_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => x(15)) & x));
    absXE_uid10_vecTranslateTest_combproc: PROCESS (absXE_uid10_vecTranslateTest_a, absXE_uid10_vecTranslateTest_b, absXE_uid10_vecTranslateTest_s)
    BEGIN
        IF (absXE_uid10_vecTranslateTest_s = "1") THEN
            absXE_uid10_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(absXE_uid10_vecTranslateTest_a) + SIGNED(absXE_uid10_vecTranslateTest_b));
        ELSE
            absXE_uid10_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(absXE_uid10_vecTranslateTest_a) - SIGNED(absXE_uid10_vecTranslateTest_b));
        END IF;
    END PROCESS;
    absXE_uid10_vecTranslateTest_q <= absXE_uid10_vecTranslateTest_o(16 downto 0);

    -- absX_uid13_vecTranslateTest(BITSELECT,12)@0
    absX_uid13_vecTranslateTest_in <= absXE_uid10_vecTranslateTest_q(15 downto 0);
    absX_uid13_vecTranslateTest_b <= absX_uid13_vecTranslateTest_in(15 downto 0);

    -- redist48_absX_uid13_vecTranslateTest_b_1(DELAY,395)
    redist48_absX_uid13_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => absX_uid13_vecTranslateTest_b, xout => redist48_absX_uid13_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- signY_uid8_vecTranslateTest(BITSELECT,7)@0
    signY_uid8_vecTranslateTest_b <= STD_LOGIC_VECTOR(y(15 downto 15));

    -- invSignY_uid11_vecTranslateTest(LOGICAL,10)@0
    invSignY_uid11_vecTranslateTest_q <= not (signY_uid8_vecTranslateTest_b);

    -- absYE_uid12_vecTranslateTest(ADDSUB,11)@0
    absYE_uid12_vecTranslateTest_s <= invSignY_uid11_vecTranslateTest_q;
    absYE_uid12_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => constantZero_uid6_vecTranslateTest_q(15)) & constantZero_uid6_vecTranslateTest_q));
    absYE_uid12_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => y(15)) & y));
    absYE_uid12_vecTranslateTest_combproc: PROCESS (absYE_uid12_vecTranslateTest_a, absYE_uid12_vecTranslateTest_b, absYE_uid12_vecTranslateTest_s)
    BEGIN
        IF (absYE_uid12_vecTranslateTest_s = "1") THEN
            absYE_uid12_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(absYE_uid12_vecTranslateTest_a) + SIGNED(absYE_uid12_vecTranslateTest_b));
        ELSE
            absYE_uid12_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(absYE_uid12_vecTranslateTest_a) - SIGNED(absYE_uid12_vecTranslateTest_b));
        END IF;
    END PROCESS;
    absYE_uid12_vecTranslateTest_q <= absYE_uid12_vecTranslateTest_o(16 downto 0);

    -- absY_uid14_vecTranslateTest(BITSELECT,13)@0
    absY_uid14_vecTranslateTest_in <= absYE_uid12_vecTranslateTest_q(15 downto 0);
    absY_uid14_vecTranslateTest_b <= absY_uid14_vecTranslateTest_in(15 downto 0);

    -- redist47_absY_uid14_vecTranslateTest_b_1(DELAY,394)
    redist47_absY_uid14_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => absY_uid14_vecTranslateTest_b, xout => redist47_absY_uid14_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- yip1E_1_uid24_vecTranslateTest(SUB,23)@1 + 1
    yip1E_1_uid24_vecTranslateTest_a <= STD_LOGIC_VECTOR("0" & redist47_absY_uid14_vecTranslateTest_b_1_q);
    yip1E_1_uid24_vecTranslateTest_b <= STD_LOGIC_VECTOR("0" & redist48_absX_uid13_vecTranslateTest_b_1_q);
    yip1E_1_uid24_vecTranslateTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            yip1E_1_uid24_vecTranslateTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                yip1E_1_uid24_vecTranslateTest_o <= STD_LOGIC_VECTOR(UNSIGNED(yip1E_1_uid24_vecTranslateTest_a) - UNSIGNED(yip1E_1_uid24_vecTranslateTest_b));
            END IF;
        END IF;
    END PROCESS;
    yip1E_1_uid24_vecTranslateTest_q <= yip1E_1_uid24_vecTranslateTest_o(16 downto 0);

    -- xMSB_uid32_vecTranslateTest(BITSELECT,31)@2
    xMSB_uid32_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1E_1_uid24_vecTranslateTest_q(16 downto 16));

    -- xip1E_1_uid23_vecTranslateTest(ADD,22)@1 + 1
    xip1E_1_uid23_vecTranslateTest_a <= STD_LOGIC_VECTOR("0" & redist48_absX_uid13_vecTranslateTest_b_1_q);
    xip1E_1_uid23_vecTranslateTest_b <= STD_LOGIC_VECTOR("0" & redist47_absY_uid14_vecTranslateTest_b_1_q);
    xip1E_1_uid23_vecTranslateTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            xip1E_1_uid23_vecTranslateTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                xip1E_1_uid23_vecTranslateTest_o <= STD_LOGIC_VECTOR(UNSIGNED(xip1E_1_uid23_vecTranslateTest_a) + UNSIGNED(xip1E_1_uid23_vecTranslateTest_b));
            END IF;
        END IF;
    END PROCESS;
    xip1E_1_uid23_vecTranslateTest_q <= xip1E_1_uid23_vecTranslateTest_o(16 downto 0);

    -- yip1E_2NA_uid42_vecTranslateTest(BITJOIN,41)@2
    yip1E_2NA_uid42_vecTranslateTest_q <= yip1E_1_uid24_vecTranslateTest_q & GND_q;

    -- yip1E_2sumAHighB_uid43_vecTranslateTest(ADDSUB,42)@2
    yip1E_2sumAHighB_uid43_vecTranslateTest_s <= xMSB_uid32_vecTranslateTest_b;
    yip1E_2sumAHighB_uid43_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 18 => yip1E_2NA_uid42_vecTranslateTest_q(17)) & yip1E_2NA_uid42_vecTranslateTest_q));
    yip1E_2sumAHighB_uid43_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_1_uid23_vecTranslateTest_q));
    yip1E_2sumAHighB_uid43_vecTranslateTest_combproc: PROCESS (yip1E_2sumAHighB_uid43_vecTranslateTest_a, yip1E_2sumAHighB_uid43_vecTranslateTest_b, yip1E_2sumAHighB_uid43_vecTranslateTest_s)
    BEGIN
        IF (yip1E_2sumAHighB_uid43_vecTranslateTest_s = "1") THEN
            yip1E_2sumAHighB_uid43_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_2sumAHighB_uid43_vecTranslateTest_a) + SIGNED(yip1E_2sumAHighB_uid43_vecTranslateTest_b));
        ELSE
            yip1E_2sumAHighB_uid43_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_2sumAHighB_uid43_vecTranslateTest_a) - SIGNED(yip1E_2sumAHighB_uid43_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_2sumAHighB_uid43_vecTranslateTest_q <= yip1E_2sumAHighB_uid43_vecTranslateTest_o(18 downto 0);

    -- yip1_2_uid49_vecTranslateTest(BITSELECT,48)@2
    yip1_2_uid49_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_2sumAHighB_uid43_vecTranslateTest_q(17 downto 0));
    yip1_2_uid49_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_2_uid49_vecTranslateTest_in(17 downto 0));

    -- redist42_yip1_2_uid49_vecTranslateTest_b_1(DELAY,389)
    redist42_yip1_2_uid49_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_2_uid49_vecTranslateTest_b, xout => redist42_yip1_2_uid49_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid51_vecTranslateTest(BITSELECT,50)@3
    xMSB_uid51_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist42_yip1_2_uid49_vecTranslateTest_b_1_q(17 downto 17));

    -- invSignOfSelectionSignal_uid37_vecTranslateTest(LOGICAL,36)@2
    invSignOfSelectionSignal_uid37_vecTranslateTest_q <= not (xMSB_uid32_vecTranslateTest_b);

    -- xip1E_2NA_uid39_vecTranslateTest(BITJOIN,38)@2
    xip1E_2NA_uid39_vecTranslateTest_q <= xip1E_1_uid23_vecTranslateTest_q & GND_q;

    -- xip1E_2sumAHighB_uid40_vecTranslateTest(ADDSUB,39)@2
    xip1E_2sumAHighB_uid40_vecTranslateTest_s <= invSignOfSelectionSignal_uid37_vecTranslateTest_q;
    xip1E_2sumAHighB_uid40_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_2NA_uid39_vecTranslateTest_q));
    xip1E_2sumAHighB_uid40_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 17 => yip1E_1_uid24_vecTranslateTest_q(16)) & yip1E_1_uid24_vecTranslateTest_q));
    xip1E_2sumAHighB_uid40_vecTranslateTest_combproc: PROCESS (xip1E_2sumAHighB_uid40_vecTranslateTest_a, xip1E_2sumAHighB_uid40_vecTranslateTest_b, xip1E_2sumAHighB_uid40_vecTranslateTest_s)
    BEGIN
        IF (xip1E_2sumAHighB_uid40_vecTranslateTest_s = "1") THEN
            xip1E_2sumAHighB_uid40_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_2sumAHighB_uid40_vecTranslateTest_a) + SIGNED(xip1E_2sumAHighB_uid40_vecTranslateTest_b));
        ELSE
            xip1E_2sumAHighB_uid40_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_2sumAHighB_uid40_vecTranslateTest_a) - SIGNED(xip1E_2sumAHighB_uid40_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_2sumAHighB_uid40_vecTranslateTest_q <= xip1E_2sumAHighB_uid40_vecTranslateTest_o(19 downto 0);

    -- xip1_2_uid48_vecTranslateTest(BITSELECT,47)@2
    xip1_2_uid48_vecTranslateTest_in <= xip1E_2sumAHighB_uid40_vecTranslateTest_q(17 downto 0);
    xip1_2_uid48_vecTranslateTest_b <= xip1_2_uid48_vecTranslateTest_in(17 downto 0);

    -- redist43_xip1_2_uid48_vecTranslateTest_b_1(DELAY,390)
    redist43_xip1_2_uid48_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_2_uid48_vecTranslateTest_b, xout => redist43_xip1_2_uid48_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_3CostZeroPaddingA_uid57_vecTranslateTest(CONSTANT,56)
    xip1E_3CostZeroPaddingA_uid57_vecTranslateTest_q <= "00";

    -- yip1E_3NA_uid61_vecTranslateTest(BITJOIN,60)@3
    yip1E_3NA_uid61_vecTranslateTest_q <= redist42_yip1_2_uid49_vecTranslateTest_b_1_q & xip1E_3CostZeroPaddingA_uid57_vecTranslateTest_q;

    -- yip1E_3sumAHighB_uid62_vecTranslateTest(ADDSUB,61)@3
    yip1E_3sumAHighB_uid62_vecTranslateTest_s <= xMSB_uid51_vecTranslateTest_b;
    yip1E_3sumAHighB_uid62_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 20 => yip1E_3NA_uid61_vecTranslateTest_q(19)) & yip1E_3NA_uid61_vecTranslateTest_q));
    yip1E_3sumAHighB_uid62_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & redist43_xip1_2_uid48_vecTranslateTest_b_1_q));
    yip1E_3sumAHighB_uid62_vecTranslateTest_combproc: PROCESS (yip1E_3sumAHighB_uid62_vecTranslateTest_a, yip1E_3sumAHighB_uid62_vecTranslateTest_b, yip1E_3sumAHighB_uid62_vecTranslateTest_s)
    BEGIN
        IF (yip1E_3sumAHighB_uid62_vecTranslateTest_s = "1") THEN
            yip1E_3sumAHighB_uid62_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_3sumAHighB_uid62_vecTranslateTest_a) + SIGNED(yip1E_3sumAHighB_uid62_vecTranslateTest_b));
        ELSE
            yip1E_3sumAHighB_uid62_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_3sumAHighB_uid62_vecTranslateTest_a) - SIGNED(yip1E_3sumAHighB_uid62_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_3sumAHighB_uid62_vecTranslateTest_q <= yip1E_3sumAHighB_uid62_vecTranslateTest_o(20 downto 0);

    -- yip1_3_uid68_vecTranslateTest(BITSELECT,67)@3
    yip1_3_uid68_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_3sumAHighB_uid62_vecTranslateTest_q(18 downto 0));
    yip1_3_uid68_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_3_uid68_vecTranslateTest_in(18 downto 0));

    -- redist39_yip1_3_uid68_vecTranslateTest_b_1(DELAY,386)
    redist39_yip1_3_uid68_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 19, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_3_uid68_vecTranslateTest_b, xout => redist39_yip1_3_uid68_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid70_vecTranslateTest(BITSELECT,69)@4
    xMSB_uid70_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist39_yip1_3_uid68_vecTranslateTest_b_1_q(18 downto 18));

    -- invSignOfSelectionSignal_uid56_vecTranslateTest(LOGICAL,55)@3
    invSignOfSelectionSignal_uid56_vecTranslateTest_q <= not (xMSB_uid51_vecTranslateTest_b);

    -- xip1E_3NA_uid58_vecTranslateTest(BITJOIN,57)@3
    xip1E_3NA_uid58_vecTranslateTest_q <= redist43_xip1_2_uid48_vecTranslateTest_b_1_q & xip1E_3CostZeroPaddingA_uid57_vecTranslateTest_q;

    -- xip1E_3sumAHighB_uid59_vecTranslateTest(ADDSUB,58)@3
    xip1E_3sumAHighB_uid59_vecTranslateTest_s <= invSignOfSelectionSignal_uid56_vecTranslateTest_q;
    xip1E_3sumAHighB_uid59_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_3NA_uid58_vecTranslateTest_q));
    xip1E_3sumAHighB_uid59_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 18 => redist42_yip1_2_uid49_vecTranslateTest_b_1_q(17)) & redist42_yip1_2_uid49_vecTranslateTest_b_1_q));
    xip1E_3sumAHighB_uid59_vecTranslateTest_combproc: PROCESS (xip1E_3sumAHighB_uid59_vecTranslateTest_a, xip1E_3sumAHighB_uid59_vecTranslateTest_b, xip1E_3sumAHighB_uid59_vecTranslateTest_s)
    BEGIN
        IF (xip1E_3sumAHighB_uid59_vecTranslateTest_s = "1") THEN
            xip1E_3sumAHighB_uid59_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_3sumAHighB_uid59_vecTranslateTest_a) + SIGNED(xip1E_3sumAHighB_uid59_vecTranslateTest_b));
        ELSE
            xip1E_3sumAHighB_uid59_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_3sumAHighB_uid59_vecTranslateTest_a) - SIGNED(xip1E_3sumAHighB_uid59_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_3sumAHighB_uid59_vecTranslateTest_q <= xip1E_3sumAHighB_uid59_vecTranslateTest_o(21 downto 0);

    -- xip1_3_uid67_vecTranslateTest(BITSELECT,66)@3
    xip1_3_uid67_vecTranslateTest_in <= xip1E_3sumAHighB_uid59_vecTranslateTest_q(19 downto 0);
    xip1_3_uid67_vecTranslateTest_b <= xip1_3_uid67_vecTranslateTest_in(19 downto 0);

    -- redist40_xip1_3_uid67_vecTranslateTest_b_1(DELAY,387)
    redist40_xip1_3_uid67_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 20, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_3_uid67_vecTranslateTest_b, xout => redist40_xip1_3_uid67_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_4CostZeroPaddingA_uid76_vecTranslateTest(CONSTANT,75)
    xip1E_4CostZeroPaddingA_uid76_vecTranslateTest_q <= "000";

    -- yip1E_4NA_uid80_vecTranslateTest(BITJOIN,79)@4
    yip1E_4NA_uid80_vecTranslateTest_q <= redist39_yip1_3_uid68_vecTranslateTest_b_1_q & xip1E_4CostZeroPaddingA_uid76_vecTranslateTest_q;

    -- yip1E_4sumAHighB_uid81_vecTranslateTest(ADDSUB,80)@4
    yip1E_4sumAHighB_uid81_vecTranslateTest_s <= xMSB_uid70_vecTranslateTest_b;
    yip1E_4sumAHighB_uid81_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => yip1E_4NA_uid80_vecTranslateTest_q(21)) & yip1E_4NA_uid80_vecTranslateTest_q));
    yip1E_4sumAHighB_uid81_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & redist40_xip1_3_uid67_vecTranslateTest_b_1_q));
    yip1E_4sumAHighB_uid81_vecTranslateTest_combproc: PROCESS (yip1E_4sumAHighB_uid81_vecTranslateTest_a, yip1E_4sumAHighB_uid81_vecTranslateTest_b, yip1E_4sumAHighB_uid81_vecTranslateTest_s)
    BEGIN
        IF (yip1E_4sumAHighB_uid81_vecTranslateTest_s = "1") THEN
            yip1E_4sumAHighB_uid81_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_4sumAHighB_uid81_vecTranslateTest_a) + SIGNED(yip1E_4sumAHighB_uid81_vecTranslateTest_b));
        ELSE
            yip1E_4sumAHighB_uid81_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_4sumAHighB_uid81_vecTranslateTest_a) - SIGNED(yip1E_4sumAHighB_uid81_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_4sumAHighB_uid81_vecTranslateTest_q <= yip1E_4sumAHighB_uid81_vecTranslateTest_o(22 downto 0);

    -- yip1_4_uid87_vecTranslateTest(BITSELECT,86)@4
    yip1_4_uid87_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_4sumAHighB_uid81_vecTranslateTest_q(20 downto 0));
    yip1_4_uid87_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_4_uid87_vecTranslateTest_in(20 downto 0));

    -- redist36_yip1_4_uid87_vecTranslateTest_b_1(DELAY,383)
    redist36_yip1_4_uid87_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 21, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_4_uid87_vecTranslateTest_b, xout => redist36_yip1_4_uid87_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid89_vecTranslateTest(BITSELECT,88)@5
    xMSB_uid89_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist36_yip1_4_uid87_vecTranslateTest_b_1_q(20 downto 20));

    -- invSignOfSelectionSignal_uid75_vecTranslateTest(LOGICAL,74)@4
    invSignOfSelectionSignal_uid75_vecTranslateTest_q <= not (xMSB_uid70_vecTranslateTest_b);

    -- xip1E_4NA_uid77_vecTranslateTest(BITJOIN,76)@4
    xip1E_4NA_uid77_vecTranslateTest_q <= redist40_xip1_3_uid67_vecTranslateTest_b_1_q & xip1E_4CostZeroPaddingA_uid76_vecTranslateTest_q;

    -- xip1E_4sumAHighB_uid78_vecTranslateTest(ADDSUB,77)@4
    xip1E_4sumAHighB_uid78_vecTranslateTest_s <= invSignOfSelectionSignal_uid75_vecTranslateTest_q;
    xip1E_4sumAHighB_uid78_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_4NA_uid77_vecTranslateTest_q));
    xip1E_4sumAHighB_uid78_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 19 => redist39_yip1_3_uid68_vecTranslateTest_b_1_q(18)) & redist39_yip1_3_uid68_vecTranslateTest_b_1_q));
    xip1E_4sumAHighB_uid78_vecTranslateTest_combproc: PROCESS (xip1E_4sumAHighB_uid78_vecTranslateTest_a, xip1E_4sumAHighB_uid78_vecTranslateTest_b, xip1E_4sumAHighB_uid78_vecTranslateTest_s)
    BEGIN
        IF (xip1E_4sumAHighB_uid78_vecTranslateTest_s = "1") THEN
            xip1E_4sumAHighB_uid78_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_4sumAHighB_uid78_vecTranslateTest_a) + SIGNED(xip1E_4sumAHighB_uid78_vecTranslateTest_b));
        ELSE
            xip1E_4sumAHighB_uid78_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_4sumAHighB_uid78_vecTranslateTest_a) - SIGNED(xip1E_4sumAHighB_uid78_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_4sumAHighB_uid78_vecTranslateTest_q <= xip1E_4sumAHighB_uid78_vecTranslateTest_o(24 downto 0);

    -- xip1_4_uid86_vecTranslateTest(BITSELECT,85)@4
    xip1_4_uid86_vecTranslateTest_in <= xip1E_4sumAHighB_uid78_vecTranslateTest_q(22 downto 0);
    xip1_4_uid86_vecTranslateTest_b <= xip1_4_uid86_vecTranslateTest_in(22 downto 0);

    -- redist37_xip1_4_uid86_vecTranslateTest_b_1(DELAY,384)
    redist37_xip1_4_uid86_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_4_uid86_vecTranslateTest_b, xout => redist37_xip1_4_uid86_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_5CostZeroPaddingA_uid95_vecTranslateTest(CONSTANT,94)
    xip1E_5CostZeroPaddingA_uid95_vecTranslateTest_q <= "0000";

    -- yip1E_5NA_uid99_vecTranslateTest(BITJOIN,98)@5
    yip1E_5NA_uid99_vecTranslateTest_q <= redist36_yip1_4_uid87_vecTranslateTest_b_1_q & xip1E_5CostZeroPaddingA_uid95_vecTranslateTest_q;

    -- yip1E_5sumAHighB_uid100_vecTranslateTest(ADDSUB,99)@5
    yip1E_5sumAHighB_uid100_vecTranslateTest_s <= xMSB_uid89_vecTranslateTest_b;
    yip1E_5sumAHighB_uid100_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 25 => yip1E_5NA_uid99_vecTranslateTest_q(24)) & yip1E_5NA_uid99_vecTranslateTest_q));
    yip1E_5sumAHighB_uid100_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & redist37_xip1_4_uid86_vecTranslateTest_b_1_q));
    yip1E_5sumAHighB_uid100_vecTranslateTest_combproc: PROCESS (yip1E_5sumAHighB_uid100_vecTranslateTest_a, yip1E_5sumAHighB_uid100_vecTranslateTest_b, yip1E_5sumAHighB_uid100_vecTranslateTest_s)
    BEGIN
        IF (yip1E_5sumAHighB_uid100_vecTranslateTest_s = "1") THEN
            yip1E_5sumAHighB_uid100_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_5sumAHighB_uid100_vecTranslateTest_a) + SIGNED(yip1E_5sumAHighB_uid100_vecTranslateTest_b));
        ELSE
            yip1E_5sumAHighB_uid100_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_5sumAHighB_uid100_vecTranslateTest_a) - SIGNED(yip1E_5sumAHighB_uid100_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_5sumAHighB_uid100_vecTranslateTest_q <= yip1E_5sumAHighB_uid100_vecTranslateTest_o(25 downto 0);

    -- yip1_5_uid106_vecTranslateTest(BITSELECT,105)@5
    yip1_5_uid106_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_5sumAHighB_uid100_vecTranslateTest_q(23 downto 0));
    yip1_5_uid106_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_5_uid106_vecTranslateTest_in(23 downto 0));

    -- redist33_yip1_5_uid106_vecTranslateTest_b_1(DELAY,380)
    redist33_yip1_5_uid106_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_5_uid106_vecTranslateTest_b, xout => redist33_yip1_5_uid106_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid108_vecTranslateTest(BITSELECT,107)@6
    xMSB_uid108_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist33_yip1_5_uid106_vecTranslateTest_b_1_q(23 downto 23));

    -- invSignOfSelectionSignal_uid94_vecTranslateTest(LOGICAL,93)@5
    invSignOfSelectionSignal_uid94_vecTranslateTest_q <= not (xMSB_uid89_vecTranslateTest_b);

    -- xip1E_5NA_uid96_vecTranslateTest(BITJOIN,95)@5
    xip1E_5NA_uid96_vecTranslateTest_q <= redist37_xip1_4_uid86_vecTranslateTest_b_1_q & xip1E_5CostZeroPaddingA_uid95_vecTranslateTest_q;

    -- xip1E_5sumAHighB_uid97_vecTranslateTest(ADDSUB,96)@5
    xip1E_5sumAHighB_uid97_vecTranslateTest_s <= invSignOfSelectionSignal_uid94_vecTranslateTest_q;
    xip1E_5sumAHighB_uid97_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_5NA_uid96_vecTranslateTest_q));
    xip1E_5sumAHighB_uid97_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 21 => redist36_yip1_4_uid87_vecTranslateTest_b_1_q(20)) & redist36_yip1_4_uid87_vecTranslateTest_b_1_q));
    xip1E_5sumAHighB_uid97_vecTranslateTest_combproc: PROCESS (xip1E_5sumAHighB_uid97_vecTranslateTest_a, xip1E_5sumAHighB_uid97_vecTranslateTest_b, xip1E_5sumAHighB_uid97_vecTranslateTest_s)
    BEGIN
        IF (xip1E_5sumAHighB_uid97_vecTranslateTest_s = "1") THEN
            xip1E_5sumAHighB_uid97_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_5sumAHighB_uid97_vecTranslateTest_a) + SIGNED(xip1E_5sumAHighB_uid97_vecTranslateTest_b));
        ELSE
            xip1E_5sumAHighB_uid97_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_5sumAHighB_uid97_vecTranslateTest_a) - SIGNED(xip1E_5sumAHighB_uid97_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_5sumAHighB_uid97_vecTranslateTest_q <= xip1E_5sumAHighB_uid97_vecTranslateTest_o(28 downto 0);

    -- xip1_5_uid105_vecTranslateTest(BITSELECT,104)@5
    xip1_5_uid105_vecTranslateTest_in <= xip1E_5sumAHighB_uid97_vecTranslateTest_q(26 downto 0);
    xip1_5_uid105_vecTranslateTest_b <= xip1_5_uid105_vecTranslateTest_in(26 downto 0);

    -- redist34_xip1_5_uid105_vecTranslateTest_b_1(DELAY,381)
    redist34_xip1_5_uid105_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_5_uid105_vecTranslateTest_b, xout => redist34_xip1_5_uid105_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_6CostZeroPaddingA_uid114_vecTranslateTest(CONSTANT,113)
    xip1E_6CostZeroPaddingA_uid114_vecTranslateTest_q <= "00000";

    -- yip1E_6NA_uid118_vecTranslateTest(BITJOIN,117)@6
    yip1E_6NA_uid118_vecTranslateTest_q <= redist33_yip1_5_uid106_vecTranslateTest_b_1_q & xip1E_6CostZeroPaddingA_uid114_vecTranslateTest_q;

    -- yip1E_6sumAHighB_uid119_vecTranslateTest(ADDSUB,118)@6
    yip1E_6sumAHighB_uid119_vecTranslateTest_s <= xMSB_uid108_vecTranslateTest_b;
    yip1E_6sumAHighB_uid119_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => yip1E_6NA_uid118_vecTranslateTest_q(28)) & yip1E_6NA_uid118_vecTranslateTest_q));
    yip1E_6sumAHighB_uid119_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & redist34_xip1_5_uid105_vecTranslateTest_b_1_q));
    yip1E_6sumAHighB_uid119_vecTranslateTest_combproc: PROCESS (yip1E_6sumAHighB_uid119_vecTranslateTest_a, yip1E_6sumAHighB_uid119_vecTranslateTest_b, yip1E_6sumAHighB_uid119_vecTranslateTest_s)
    BEGIN
        IF (yip1E_6sumAHighB_uid119_vecTranslateTest_s = "1") THEN
            yip1E_6sumAHighB_uid119_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_6sumAHighB_uid119_vecTranslateTest_a) + SIGNED(yip1E_6sumAHighB_uid119_vecTranslateTest_b));
        ELSE
            yip1E_6sumAHighB_uid119_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_6sumAHighB_uid119_vecTranslateTest_a) - SIGNED(yip1E_6sumAHighB_uid119_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_6sumAHighB_uid119_vecTranslateTest_q <= yip1E_6sumAHighB_uid119_vecTranslateTest_o(29 downto 0);

    -- yip1_6_uid125_vecTranslateTest(BITSELECT,124)@6
    yip1_6_uid125_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_6sumAHighB_uid119_vecTranslateTest_q(27 downto 0));
    yip1_6_uid125_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_6_uid125_vecTranslateTest_in(27 downto 0));

    -- redist30_yip1_6_uid125_vecTranslateTest_b_1(DELAY,377)
    redist30_yip1_6_uid125_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_6_uid125_vecTranslateTest_b, xout => redist30_yip1_6_uid125_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid127_vecTranslateTest(BITSELECT,126)@7
    xMSB_uid127_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist30_yip1_6_uid125_vecTranslateTest_b_1_q(27 downto 27));

    -- invSignOfSelectionSignal_uid113_vecTranslateTest(LOGICAL,112)@6
    invSignOfSelectionSignal_uid113_vecTranslateTest_q <= not (xMSB_uid108_vecTranslateTest_b);

    -- xip1E_6NA_uid115_vecTranslateTest(BITJOIN,114)@6
    xip1E_6NA_uid115_vecTranslateTest_q <= redist34_xip1_5_uid105_vecTranslateTest_b_1_q & xip1E_6CostZeroPaddingA_uid114_vecTranslateTest_q;

    -- xip1E_6sumAHighB_uid116_vecTranslateTest(ADDSUB,115)@6
    xip1E_6sumAHighB_uid116_vecTranslateTest_s <= invSignOfSelectionSignal_uid113_vecTranslateTest_q;
    xip1E_6sumAHighB_uid116_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_6NA_uid115_vecTranslateTest_q));
    xip1E_6sumAHighB_uid116_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 24 => redist33_yip1_5_uid106_vecTranslateTest_b_1_q(23)) & redist33_yip1_5_uid106_vecTranslateTest_b_1_q));
    xip1E_6sumAHighB_uid116_vecTranslateTest_combproc: PROCESS (xip1E_6sumAHighB_uid116_vecTranslateTest_a, xip1E_6sumAHighB_uid116_vecTranslateTest_b, xip1E_6sumAHighB_uid116_vecTranslateTest_s)
    BEGIN
        IF (xip1E_6sumAHighB_uid116_vecTranslateTest_s = "1") THEN
            xip1E_6sumAHighB_uid116_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_6sumAHighB_uid116_vecTranslateTest_a) + SIGNED(xip1E_6sumAHighB_uid116_vecTranslateTest_b));
        ELSE
            xip1E_6sumAHighB_uid116_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_6sumAHighB_uid116_vecTranslateTest_a) - SIGNED(xip1E_6sumAHighB_uid116_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_6sumAHighB_uid116_vecTranslateTest_q <= xip1E_6sumAHighB_uid116_vecTranslateTest_o(33 downto 0);

    -- xip1_6_uid124_vecTranslateTest(BITSELECT,123)@6
    xip1_6_uid124_vecTranslateTest_in <= xip1E_6sumAHighB_uid116_vecTranslateTest_q(31 downto 0);
    xip1_6_uid124_vecTranslateTest_b <= xip1_6_uid124_vecTranslateTest_in(31 downto 0);

    -- redist31_xip1_6_uid124_vecTranslateTest_b_1(DELAY,378)
    redist31_xip1_6_uid124_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_6_uid124_vecTranslateTest_b, xout => redist31_xip1_6_uid124_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- twoToMiSiXip_uid131_vecTranslateTest(BITSELECT,130)@7
    twoToMiSiXip_uid131_vecTranslateTest_b <= redist31_xip1_6_uid124_vecTranslateTest_b_1_q(31 downto 5);

    -- yip1E_7NA_uid139_vecTranslateTest(BITJOIN,138)@7
    yip1E_7NA_uid139_vecTranslateTest_q <= redist30_yip1_6_uid125_vecTranslateTest_b_1_q & GND_q;

    -- yip1E_7sumAHighB_uid140_vecTranslateTest(ADDSUB,139)@7
    yip1E_7sumAHighB_uid140_vecTranslateTest_s <= xMSB_uid127_vecTranslateTest_b;
    yip1E_7sumAHighB_uid140_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => yip1E_7NA_uid139_vecTranslateTest_q(28)) & yip1E_7NA_uid139_vecTranslateTest_q));
    yip1E_7sumAHighB_uid140_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid131_vecTranslateTest_b));
    yip1E_7sumAHighB_uid140_vecTranslateTest_combproc: PROCESS (yip1E_7sumAHighB_uid140_vecTranslateTest_a, yip1E_7sumAHighB_uid140_vecTranslateTest_b, yip1E_7sumAHighB_uid140_vecTranslateTest_s)
    BEGIN
        IF (yip1E_7sumAHighB_uid140_vecTranslateTest_s = "1") THEN
            yip1E_7sumAHighB_uid140_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_7sumAHighB_uid140_vecTranslateTest_a) + SIGNED(yip1E_7sumAHighB_uid140_vecTranslateTest_b));
        ELSE
            yip1E_7sumAHighB_uid140_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_7sumAHighB_uid140_vecTranslateTest_a) - SIGNED(yip1E_7sumAHighB_uid140_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_7sumAHighB_uid140_vecTranslateTest_q <= yip1E_7sumAHighB_uid140_vecTranslateTest_o(29 downto 0);

    -- yip1_7_uid146_vecTranslateTest(BITSELECT,145)@7
    yip1_7_uid146_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_7sumAHighB_uid140_vecTranslateTest_q(27 downto 0));
    yip1_7_uid146_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_7_uid146_vecTranslateTest_in(27 downto 0));

    -- redist27_yip1_7_uid146_vecTranslateTest_b_1(DELAY,374)
    redist27_yip1_7_uid146_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_7_uid146_vecTranslateTest_b, xout => redist27_yip1_7_uid146_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid148_vecTranslateTest(BITSELECT,147)@8
    xMSB_uid148_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist27_yip1_7_uid146_vecTranslateTest_b_1_q(27 downto 27));

    -- invSignOfSelectionSignal_uid155_vecTranslateTest(LOGICAL,154)@8
    invSignOfSelectionSignal_uid155_vecTranslateTest_q <= not (xMSB_uid148_vecTranslateTest_b);

    -- twoToMiSiYip_uid153_vecTranslateTest(BITSELECT,152)@8
    twoToMiSiYip_uid153_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist27_yip1_7_uid146_vecTranslateTest_b_1_q(27 downto 7));

    -- invSignOfSelectionSignal_uid134_vecTranslateTest(LOGICAL,133)@7
    invSignOfSelectionSignal_uid134_vecTranslateTest_q <= not (xMSB_uid127_vecTranslateTest_b);

    -- twoToMiSiYip_uid132_vecTranslateTest(BITSELECT,131)@7
    twoToMiSiYip_uid132_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist30_yip1_6_uid125_vecTranslateTest_b_1_q(27 downto 5));

    -- xip1E_7NA_uid136_vecTranslateTest(BITJOIN,135)@7
    xip1E_7NA_uid136_vecTranslateTest_q <= redist31_xip1_6_uid124_vecTranslateTest_b_1_q & GND_q;

    -- xip1E_7sumAHighB_uid137_vecTranslateTest(ADDSUB,136)@7
    xip1E_7sumAHighB_uid137_vecTranslateTest_s <= invSignOfSelectionSignal_uid134_vecTranslateTest_q;
    xip1E_7sumAHighB_uid137_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & xip1E_7NA_uid136_vecTranslateTest_q));
    xip1E_7sumAHighB_uid137_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 23 => twoToMiSiYip_uid132_vecTranslateTest_b(22)) & twoToMiSiYip_uid132_vecTranslateTest_b));
    xip1E_7sumAHighB_uid137_vecTranslateTest_combproc: PROCESS (xip1E_7sumAHighB_uid137_vecTranslateTest_a, xip1E_7sumAHighB_uid137_vecTranslateTest_b, xip1E_7sumAHighB_uid137_vecTranslateTest_s)
    BEGIN
        IF (xip1E_7sumAHighB_uid137_vecTranslateTest_s = "1") THEN
            xip1E_7sumAHighB_uid137_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_7sumAHighB_uid137_vecTranslateTest_a) + SIGNED(xip1E_7sumAHighB_uid137_vecTranslateTest_b));
        ELSE
            xip1E_7sumAHighB_uid137_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_7sumAHighB_uid137_vecTranslateTest_a) - SIGNED(xip1E_7sumAHighB_uid137_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_7sumAHighB_uid137_vecTranslateTest_q <= xip1E_7sumAHighB_uid137_vecTranslateTest_o(34 downto 0);

    -- xip1_7_uid145_vecTranslateTest(BITSELECT,144)@7
    xip1_7_uid145_vecTranslateTest_in <= xip1E_7sumAHighB_uid137_vecTranslateTest_q(32 downto 0);
    xip1_7_uid145_vecTranslateTest_b <= xip1_7_uid145_vecTranslateTest_in(32 downto 0);

    -- redist28_xip1_7_uid145_vecTranslateTest_b_1(DELAY,375)
    redist28_xip1_7_uid145_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_7_uid145_vecTranslateTest_b, xout => redist28_xip1_7_uid145_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_8_uid156_vecTranslateTest(ADDSUB,155)@8
    xip1E_8_uid156_vecTranslateTest_s <= invSignOfSelectionSignal_uid155_vecTranslateTest_q;
    xip1E_8_uid156_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist28_xip1_7_uid145_vecTranslateTest_b_1_q));
    xip1E_8_uid156_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 21 => twoToMiSiYip_uid153_vecTranslateTest_b(20)) & twoToMiSiYip_uid153_vecTranslateTest_b));
    xip1E_8_uid156_vecTranslateTest_combproc: PROCESS (xip1E_8_uid156_vecTranslateTest_a, xip1E_8_uid156_vecTranslateTest_b, xip1E_8_uid156_vecTranslateTest_s)
    BEGIN
        IF (xip1E_8_uid156_vecTranslateTest_s = "1") THEN
            xip1E_8_uid156_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_8_uid156_vecTranslateTest_a) + SIGNED(xip1E_8_uid156_vecTranslateTest_b));
        ELSE
            xip1E_8_uid156_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_8_uid156_vecTranslateTest_a) - SIGNED(xip1E_8_uid156_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_8_uid156_vecTranslateTest_q <= xip1E_8_uid156_vecTranslateTest_o(34 downto 0);

    -- xip1_8_uid162_vecTranslateTest(BITSELECT,161)@8
    xip1_8_uid162_vecTranslateTest_in <= xip1E_8_uid156_vecTranslateTest_q(32 downto 0);
    xip1_8_uid162_vecTranslateTest_b <= xip1_8_uid162_vecTranslateTest_in(32 downto 0);

    -- redist25_xip1_8_uid162_vecTranslateTest_b_1(DELAY,372)
    redist25_xip1_8_uid162_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_8_uid162_vecTranslateTest_b, xout => redist25_xip1_8_uid162_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- twoToMiSiXip_uid169_vecTranslateTest(BITSELECT,168)@9
    twoToMiSiXip_uid169_vecTranslateTest_b <= redist25_xip1_8_uid162_vecTranslateTest_b_1_q(32 downto 8);

    -- twoToMiSiXip_uid152_vecTranslateTest(BITSELECT,151)@8
    twoToMiSiXip_uid152_vecTranslateTest_b <= redist28_xip1_7_uid145_vecTranslateTest_b_1_q(32 downto 7);

    -- yip1E_8_uid157_vecTranslateTest(ADDSUB,156)@8
    yip1E_8_uid157_vecTranslateTest_s <= xMSB_uid148_vecTranslateTest_b;
    yip1E_8_uid157_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => redist27_yip1_7_uid146_vecTranslateTest_b_1_q(27)) & redist27_yip1_7_uid146_vecTranslateTest_b_1_q));
    yip1E_8_uid157_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid152_vecTranslateTest_b));
    yip1E_8_uid157_vecTranslateTest_combproc: PROCESS (yip1E_8_uid157_vecTranslateTest_a, yip1E_8_uid157_vecTranslateTest_b, yip1E_8_uid157_vecTranslateTest_s)
    BEGIN
        IF (yip1E_8_uid157_vecTranslateTest_s = "1") THEN
            yip1E_8_uid157_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_8_uid157_vecTranslateTest_a) + SIGNED(yip1E_8_uid157_vecTranslateTest_b));
        ELSE
            yip1E_8_uid157_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_8_uid157_vecTranslateTest_a) - SIGNED(yip1E_8_uid157_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_8_uid157_vecTranslateTest_q <= yip1E_8_uid157_vecTranslateTest_o(28 downto 0);

    -- yip1_8_uid163_vecTranslateTest(BITSELECT,162)@8
    yip1_8_uid163_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_8_uid157_vecTranslateTest_q(26 downto 0));
    yip1_8_uid163_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_8_uid163_vecTranslateTest_in(26 downto 0));

    -- redist24_yip1_8_uid163_vecTranslateTest_b_1(DELAY,371)
    redist24_yip1_8_uid163_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_8_uid163_vecTranslateTest_b, xout => redist24_yip1_8_uid163_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- yip1E_9_uid174_vecTranslateTest(ADDSUB,173)@9
    yip1E_9_uid174_vecTranslateTest_s <= xMSB_uid165_vecTranslateTest_b;
    yip1E_9_uid174_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 27 => redist24_yip1_8_uid163_vecTranslateTest_b_1_q(26)) & redist24_yip1_8_uid163_vecTranslateTest_b_1_q));
    yip1E_9_uid174_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid169_vecTranslateTest_b));
    yip1E_9_uid174_vecTranslateTest_combproc: PROCESS (yip1E_9_uid174_vecTranslateTest_a, yip1E_9_uid174_vecTranslateTest_b, yip1E_9_uid174_vecTranslateTest_s)
    BEGIN
        IF (yip1E_9_uid174_vecTranslateTest_s = "1") THEN
            yip1E_9_uid174_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_9_uid174_vecTranslateTest_a) + SIGNED(yip1E_9_uid174_vecTranslateTest_b));
        ELSE
            yip1E_9_uid174_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_9_uid174_vecTranslateTest_a) - SIGNED(yip1E_9_uid174_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_9_uid174_vecTranslateTest_q <= yip1E_9_uid174_vecTranslateTest_o(27 downto 0);

    -- yip1_9_uid180_vecTranslateTest(BITSELECT,179)@9
    yip1_9_uid180_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_9_uid174_vecTranslateTest_q(25 downto 0));
    yip1_9_uid180_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_9_uid180_vecTranslateTest_in(25 downto 0));

    -- redist21_yip1_9_uid180_vecTranslateTest_b_1(DELAY,368)
    redist21_yip1_9_uid180_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 26, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_9_uid180_vecTranslateTest_b, xout => redist21_yip1_9_uid180_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid182_vecTranslateTest(BITSELECT,181)@10
    xMSB_uid182_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist21_yip1_9_uid180_vecTranslateTest_b_1_q(25 downto 25));

    -- invSignOfSelectionSignal_uid189_vecTranslateTest(LOGICAL,188)@10
    invSignOfSelectionSignal_uid189_vecTranslateTest_q <= not (xMSB_uid182_vecTranslateTest_b);

    -- twoToMiSiYip_uid187_vecTranslateTest(BITSELECT,186)@10
    twoToMiSiYip_uid187_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist21_yip1_9_uid180_vecTranslateTest_b_1_q(25 downto 9));

    -- invSignOfSelectionSignal_uid172_vecTranslateTest(LOGICAL,171)@9
    invSignOfSelectionSignal_uid172_vecTranslateTest_q <= not (xMSB_uid165_vecTranslateTest_b);

    -- twoToMiSiYip_uid170_vecTranslateTest(BITSELECT,169)@9
    twoToMiSiYip_uid170_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist24_yip1_8_uid163_vecTranslateTest_b_1_q(26 downto 8));

    -- xip1E_9_uid173_vecTranslateTest(ADDSUB,172)@9
    xip1E_9_uid173_vecTranslateTest_s <= invSignOfSelectionSignal_uid172_vecTranslateTest_q;
    xip1E_9_uid173_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist25_xip1_8_uid162_vecTranslateTest_b_1_q));
    xip1E_9_uid173_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 19 => twoToMiSiYip_uid170_vecTranslateTest_b(18)) & twoToMiSiYip_uid170_vecTranslateTest_b));
    xip1E_9_uid173_vecTranslateTest_combproc: PROCESS (xip1E_9_uid173_vecTranslateTest_a, xip1E_9_uid173_vecTranslateTest_b, xip1E_9_uid173_vecTranslateTest_s)
    BEGIN
        IF (xip1E_9_uid173_vecTranslateTest_s = "1") THEN
            xip1E_9_uid173_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_9_uid173_vecTranslateTest_a) + SIGNED(xip1E_9_uid173_vecTranslateTest_b));
        ELSE
            xip1E_9_uid173_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_9_uid173_vecTranslateTest_a) - SIGNED(xip1E_9_uid173_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_9_uid173_vecTranslateTest_q <= xip1E_9_uid173_vecTranslateTest_o(34 downto 0);

    -- xip1_9_uid179_vecTranslateTest(BITSELECT,178)@9
    xip1_9_uid179_vecTranslateTest_in <= xip1E_9_uid173_vecTranslateTest_q(32 downto 0);
    xip1_9_uid179_vecTranslateTest_b <= xip1_9_uid179_vecTranslateTest_in(32 downto 0);

    -- redist22_xip1_9_uid179_vecTranslateTest_b_1(DELAY,369)
    redist22_xip1_9_uid179_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_9_uid179_vecTranslateTest_b, xout => redist22_xip1_9_uid179_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_10_uid190_vecTranslateTest(ADDSUB,189)@10
    xip1E_10_uid190_vecTranslateTest_s <= invSignOfSelectionSignal_uid189_vecTranslateTest_q;
    xip1E_10_uid190_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist22_xip1_9_uid179_vecTranslateTest_b_1_q));
    xip1E_10_uid190_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 17 => twoToMiSiYip_uid187_vecTranslateTest_b(16)) & twoToMiSiYip_uid187_vecTranslateTest_b));
    xip1E_10_uid190_vecTranslateTest_combproc: PROCESS (xip1E_10_uid190_vecTranslateTest_a, xip1E_10_uid190_vecTranslateTest_b, xip1E_10_uid190_vecTranslateTest_s)
    BEGIN
        IF (xip1E_10_uid190_vecTranslateTest_s = "1") THEN
            xip1E_10_uid190_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_10_uid190_vecTranslateTest_a) + SIGNED(xip1E_10_uid190_vecTranslateTest_b));
        ELSE
            xip1E_10_uid190_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_10_uid190_vecTranslateTest_a) - SIGNED(xip1E_10_uid190_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_10_uid190_vecTranslateTest_q <= xip1E_10_uid190_vecTranslateTest_o(34 downto 0);

    -- xip1_10_uid196_vecTranslateTest(BITSELECT,195)@10
    xip1_10_uid196_vecTranslateTest_in <= xip1E_10_uid190_vecTranslateTest_q(32 downto 0);
    xip1_10_uid196_vecTranslateTest_b <= xip1_10_uid196_vecTranslateTest_in(32 downto 0);

    -- redist19_xip1_10_uid196_vecTranslateTest_b_1(DELAY,366)
    redist19_xip1_10_uid196_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_10_uid196_vecTranslateTest_b, xout => redist19_xip1_10_uid196_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- twoToMiSiXip_uid203_vecTranslateTest(BITSELECT,202)@11
    twoToMiSiXip_uid203_vecTranslateTest_b <= redist19_xip1_10_uid196_vecTranslateTest_b_1_q(32 downto 10);

    -- twoToMiSiXip_uid186_vecTranslateTest(BITSELECT,185)@10
    twoToMiSiXip_uid186_vecTranslateTest_b <= redist22_xip1_9_uid179_vecTranslateTest_b_1_q(32 downto 9);

    -- yip1E_10_uid191_vecTranslateTest(ADDSUB,190)@10
    yip1E_10_uid191_vecTranslateTest_s <= xMSB_uid182_vecTranslateTest_b;
    yip1E_10_uid191_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 26 => redist21_yip1_9_uid180_vecTranslateTest_b_1_q(25)) & redist21_yip1_9_uid180_vecTranslateTest_b_1_q));
    yip1E_10_uid191_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid186_vecTranslateTest_b));
    yip1E_10_uid191_vecTranslateTest_combproc: PROCESS (yip1E_10_uid191_vecTranslateTest_a, yip1E_10_uid191_vecTranslateTest_b, yip1E_10_uid191_vecTranslateTest_s)
    BEGIN
        IF (yip1E_10_uid191_vecTranslateTest_s = "1") THEN
            yip1E_10_uid191_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_10_uid191_vecTranslateTest_a) + SIGNED(yip1E_10_uid191_vecTranslateTest_b));
        ELSE
            yip1E_10_uid191_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_10_uid191_vecTranslateTest_a) - SIGNED(yip1E_10_uid191_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_10_uid191_vecTranslateTest_q <= yip1E_10_uid191_vecTranslateTest_o(26 downto 0);

    -- yip1_10_uid197_vecTranslateTest(BITSELECT,196)@10
    yip1_10_uid197_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_10_uid191_vecTranslateTest_q(24 downto 0));
    yip1_10_uid197_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_10_uid197_vecTranslateTest_in(24 downto 0));

    -- redist18_yip1_10_uid197_vecTranslateTest_b_1(DELAY,365)
    redist18_yip1_10_uid197_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 25, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_10_uid197_vecTranslateTest_b, xout => redist18_yip1_10_uid197_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- yip1E_11_uid208_vecTranslateTest(ADDSUB,207)@11
    yip1E_11_uid208_vecTranslateTest_s <= xMSB_uid199_vecTranslateTest_b;
    yip1E_11_uid208_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 25 => redist18_yip1_10_uid197_vecTranslateTest_b_1_q(24)) & redist18_yip1_10_uid197_vecTranslateTest_b_1_q));
    yip1E_11_uid208_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid203_vecTranslateTest_b));
    yip1E_11_uid208_vecTranslateTest_combproc: PROCESS (yip1E_11_uid208_vecTranslateTest_a, yip1E_11_uid208_vecTranslateTest_b, yip1E_11_uid208_vecTranslateTest_s)
    BEGIN
        IF (yip1E_11_uid208_vecTranslateTest_s = "1") THEN
            yip1E_11_uid208_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_11_uid208_vecTranslateTest_a) + SIGNED(yip1E_11_uid208_vecTranslateTest_b));
        ELSE
            yip1E_11_uid208_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_11_uid208_vecTranslateTest_a) - SIGNED(yip1E_11_uid208_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_11_uid208_vecTranslateTest_q <= yip1E_11_uid208_vecTranslateTest_o(25 downto 0);

    -- yip1_11_uid214_vecTranslateTest(BITSELECT,213)@11
    yip1_11_uid214_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_11_uid208_vecTranslateTest_q(23 downto 0));
    yip1_11_uid214_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_11_uid214_vecTranslateTest_in(23 downto 0));

    -- redist15_yip1_11_uid214_vecTranslateTest_b_1(DELAY,362)
    redist15_yip1_11_uid214_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_11_uid214_vecTranslateTest_b, xout => redist15_yip1_11_uid214_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid216_vecTranslateTest(BITSELECT,215)@12
    xMSB_uid216_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist15_yip1_11_uid214_vecTranslateTest_b_1_q(23 downto 23));

    -- invSignOfSelectionSignal_uid223_vecTranslateTest(LOGICAL,222)@12
    invSignOfSelectionSignal_uid223_vecTranslateTest_q <= not (xMSB_uid216_vecTranslateTest_b);

    -- twoToMiSiYip_uid221_vecTranslateTest(BITSELECT,220)@12
    twoToMiSiYip_uid221_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist15_yip1_11_uid214_vecTranslateTest_b_1_q(23 downto 11));

    -- invSignOfSelectionSignal_uid206_vecTranslateTest(LOGICAL,205)@11
    invSignOfSelectionSignal_uid206_vecTranslateTest_q <= not (xMSB_uid199_vecTranslateTest_b);

    -- twoToMiSiYip_uid204_vecTranslateTest(BITSELECT,203)@11
    twoToMiSiYip_uid204_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist18_yip1_10_uid197_vecTranslateTest_b_1_q(24 downto 10));

    -- xip1E_11_uid207_vecTranslateTest(ADDSUB,206)@11
    xip1E_11_uid207_vecTranslateTest_s <= invSignOfSelectionSignal_uid206_vecTranslateTest_q;
    xip1E_11_uid207_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist19_xip1_10_uid196_vecTranslateTest_b_1_q));
    xip1E_11_uid207_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 15 => twoToMiSiYip_uid204_vecTranslateTest_b(14)) & twoToMiSiYip_uid204_vecTranslateTest_b));
    xip1E_11_uid207_vecTranslateTest_combproc: PROCESS (xip1E_11_uid207_vecTranslateTest_a, xip1E_11_uid207_vecTranslateTest_b, xip1E_11_uid207_vecTranslateTest_s)
    BEGIN
        IF (xip1E_11_uid207_vecTranslateTest_s = "1") THEN
            xip1E_11_uid207_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_11_uid207_vecTranslateTest_a) + SIGNED(xip1E_11_uid207_vecTranslateTest_b));
        ELSE
            xip1E_11_uid207_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_11_uid207_vecTranslateTest_a) - SIGNED(xip1E_11_uid207_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_11_uid207_vecTranslateTest_q <= xip1E_11_uid207_vecTranslateTest_o(34 downto 0);

    -- xip1_11_uid213_vecTranslateTest(BITSELECT,212)@11
    xip1_11_uid213_vecTranslateTest_in <= xip1E_11_uid207_vecTranslateTest_q(32 downto 0);
    xip1_11_uid213_vecTranslateTest_b <= xip1_11_uid213_vecTranslateTest_in(32 downto 0);

    -- redist16_xip1_11_uid213_vecTranslateTest_b_1(DELAY,363)
    redist16_xip1_11_uid213_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_11_uid213_vecTranslateTest_b, xout => redist16_xip1_11_uid213_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_12_uid224_vecTranslateTest(ADDSUB,223)@12
    xip1E_12_uid224_vecTranslateTest_s <= invSignOfSelectionSignal_uid223_vecTranslateTest_q;
    xip1E_12_uid224_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist16_xip1_11_uid213_vecTranslateTest_b_1_q));
    xip1E_12_uid224_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 13 => twoToMiSiYip_uid221_vecTranslateTest_b(12)) & twoToMiSiYip_uid221_vecTranslateTest_b));
    xip1E_12_uid224_vecTranslateTest_combproc: PROCESS (xip1E_12_uid224_vecTranslateTest_a, xip1E_12_uid224_vecTranslateTest_b, xip1E_12_uid224_vecTranslateTest_s)
    BEGIN
        IF (xip1E_12_uid224_vecTranslateTest_s = "1") THEN
            xip1E_12_uid224_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_12_uid224_vecTranslateTest_a) + SIGNED(xip1E_12_uid224_vecTranslateTest_b));
        ELSE
            xip1E_12_uid224_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_12_uid224_vecTranslateTest_a) - SIGNED(xip1E_12_uid224_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_12_uid224_vecTranslateTest_q <= xip1E_12_uid224_vecTranslateTest_o(34 downto 0);

    -- xip1_12_uid230_vecTranslateTest(BITSELECT,229)@12
    xip1_12_uid230_vecTranslateTest_in <= xip1E_12_uid224_vecTranslateTest_q(32 downto 0);
    xip1_12_uid230_vecTranslateTest_b <= xip1_12_uid230_vecTranslateTest_in(32 downto 0);

    -- redist13_xip1_12_uid230_vecTranslateTest_b_1(DELAY,360)
    redist13_xip1_12_uid230_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_12_uid230_vecTranslateTest_b, xout => redist13_xip1_12_uid230_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- twoToMiSiXip_uid237_vecTranslateTest(BITSELECT,236)@13
    twoToMiSiXip_uid237_vecTranslateTest_b <= redist13_xip1_12_uid230_vecTranslateTest_b_1_q(32 downto 12);

    -- twoToMiSiXip_uid220_vecTranslateTest(BITSELECT,219)@12
    twoToMiSiXip_uid220_vecTranslateTest_b <= redist16_xip1_11_uid213_vecTranslateTest_b_1_q(32 downto 11);

    -- yip1E_12_uid225_vecTranslateTest(ADDSUB,224)@12
    yip1E_12_uid225_vecTranslateTest_s <= xMSB_uid216_vecTranslateTest_b;
    yip1E_12_uid225_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 24 => redist15_yip1_11_uid214_vecTranslateTest_b_1_q(23)) & redist15_yip1_11_uid214_vecTranslateTest_b_1_q));
    yip1E_12_uid225_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid220_vecTranslateTest_b));
    yip1E_12_uid225_vecTranslateTest_combproc: PROCESS (yip1E_12_uid225_vecTranslateTest_a, yip1E_12_uid225_vecTranslateTest_b, yip1E_12_uid225_vecTranslateTest_s)
    BEGIN
        IF (yip1E_12_uid225_vecTranslateTest_s = "1") THEN
            yip1E_12_uid225_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_12_uid225_vecTranslateTest_a) + SIGNED(yip1E_12_uid225_vecTranslateTest_b));
        ELSE
            yip1E_12_uid225_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_12_uid225_vecTranslateTest_a) - SIGNED(yip1E_12_uid225_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_12_uid225_vecTranslateTest_q <= yip1E_12_uid225_vecTranslateTest_o(24 downto 0);

    -- yip1_12_uid231_vecTranslateTest(BITSELECT,230)@12
    yip1_12_uid231_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_12_uid225_vecTranslateTest_q(22 downto 0));
    yip1_12_uid231_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_12_uid231_vecTranslateTest_in(22 downto 0));

    -- redist12_yip1_12_uid231_vecTranslateTest_b_1(DELAY,359)
    redist12_yip1_12_uid231_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_12_uid231_vecTranslateTest_b, xout => redist12_yip1_12_uid231_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- yip1E_13_uid242_vecTranslateTest(ADDSUB,241)@13
    yip1E_13_uid242_vecTranslateTest_s <= xMSB_uid233_vecTranslateTest_b;
    yip1E_13_uid242_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((24 downto 23 => redist12_yip1_12_uid231_vecTranslateTest_b_1_q(22)) & redist12_yip1_12_uid231_vecTranslateTest_b_1_q));
    yip1E_13_uid242_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid237_vecTranslateTest_b));
    yip1E_13_uid242_vecTranslateTest_combproc: PROCESS (yip1E_13_uid242_vecTranslateTest_a, yip1E_13_uid242_vecTranslateTest_b, yip1E_13_uid242_vecTranslateTest_s)
    BEGIN
        IF (yip1E_13_uid242_vecTranslateTest_s = "1") THEN
            yip1E_13_uid242_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_13_uid242_vecTranslateTest_a) + SIGNED(yip1E_13_uid242_vecTranslateTest_b));
        ELSE
            yip1E_13_uid242_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_13_uid242_vecTranslateTest_a) - SIGNED(yip1E_13_uid242_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_13_uid242_vecTranslateTest_q <= yip1E_13_uid242_vecTranslateTest_o(23 downto 0);

    -- yip1_13_uid248_vecTranslateTest(BITSELECT,247)@13
    yip1_13_uid248_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_13_uid242_vecTranslateTest_q(21 downto 0));
    yip1_13_uid248_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_13_uid248_vecTranslateTest_in(21 downto 0));

    -- redist9_yip1_13_uid248_vecTranslateTest_b_1(DELAY,356)
    redist9_yip1_13_uid248_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 22, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_13_uid248_vecTranslateTest_b, xout => redist9_yip1_13_uid248_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xMSB_uid250_vecTranslateTest(BITSELECT,249)@14
    xMSB_uid250_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist9_yip1_13_uid248_vecTranslateTest_b_1_q(21 downto 21));

    -- invSignOfSelectionSignal_uid257_vecTranslateTest(LOGICAL,256)@14
    invSignOfSelectionSignal_uid257_vecTranslateTest_q <= not (xMSB_uid250_vecTranslateTest_b);

    -- twoToMiSiYip_uid255_vecTranslateTest(BITSELECT,254)@14
    twoToMiSiYip_uid255_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist9_yip1_13_uid248_vecTranslateTest_b_1_q(21 downto 13));

    -- invSignOfSelectionSignal_uid240_vecTranslateTest(LOGICAL,239)@13
    invSignOfSelectionSignal_uid240_vecTranslateTest_q <= not (xMSB_uid233_vecTranslateTest_b);

    -- twoToMiSiYip_uid238_vecTranslateTest(BITSELECT,237)@13
    twoToMiSiYip_uid238_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist12_yip1_12_uid231_vecTranslateTest_b_1_q(22 downto 12));

    -- xip1E_13_uid241_vecTranslateTest(ADDSUB,240)@13
    xip1E_13_uid241_vecTranslateTest_s <= invSignOfSelectionSignal_uid240_vecTranslateTest_q;
    xip1E_13_uid241_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist13_xip1_12_uid230_vecTranslateTest_b_1_q));
    xip1E_13_uid241_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 11 => twoToMiSiYip_uid238_vecTranslateTest_b(10)) & twoToMiSiYip_uid238_vecTranslateTest_b));
    xip1E_13_uid241_vecTranslateTest_combproc: PROCESS (xip1E_13_uid241_vecTranslateTest_a, xip1E_13_uid241_vecTranslateTest_b, xip1E_13_uid241_vecTranslateTest_s)
    BEGIN
        IF (xip1E_13_uid241_vecTranslateTest_s = "1") THEN
            xip1E_13_uid241_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_13_uid241_vecTranslateTest_a) + SIGNED(xip1E_13_uid241_vecTranslateTest_b));
        ELSE
            xip1E_13_uid241_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_13_uid241_vecTranslateTest_a) - SIGNED(xip1E_13_uid241_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_13_uid241_vecTranslateTest_q <= xip1E_13_uid241_vecTranslateTest_o(34 downto 0);

    -- xip1_13_uid247_vecTranslateTest(BITSELECT,246)@13
    xip1_13_uid247_vecTranslateTest_in <= xip1E_13_uid241_vecTranslateTest_q(32 downto 0);
    xip1_13_uid247_vecTranslateTest_b <= xip1_13_uid247_vecTranslateTest_in(32 downto 0);

    -- redist10_xip1_13_uid247_vecTranslateTest_b_1(DELAY,357)
    redist10_xip1_13_uid247_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_13_uid247_vecTranslateTest_b, xout => redist10_xip1_13_uid247_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_14_uid258_vecTranslateTest(ADDSUB,257)@14
    xip1E_14_uid258_vecTranslateTest_s <= invSignOfSelectionSignal_uid257_vecTranslateTest_q;
    xip1E_14_uid258_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist10_xip1_13_uid247_vecTranslateTest_b_1_q));
    xip1E_14_uid258_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 9 => twoToMiSiYip_uid255_vecTranslateTest_b(8)) & twoToMiSiYip_uid255_vecTranslateTest_b));
    xip1E_14_uid258_vecTranslateTest_combproc: PROCESS (xip1E_14_uid258_vecTranslateTest_a, xip1E_14_uid258_vecTranslateTest_b, xip1E_14_uid258_vecTranslateTest_s)
    BEGIN
        IF (xip1E_14_uid258_vecTranslateTest_s = "1") THEN
            xip1E_14_uid258_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_14_uid258_vecTranslateTest_a) + SIGNED(xip1E_14_uid258_vecTranslateTest_b));
        ELSE
            xip1E_14_uid258_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_14_uid258_vecTranslateTest_a) - SIGNED(xip1E_14_uid258_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_14_uid258_vecTranslateTest_q <= xip1E_14_uid258_vecTranslateTest_o(34 downto 0);

    -- xip1_14_uid264_vecTranslateTest(BITSELECT,263)@14
    xip1_14_uid264_vecTranslateTest_in <= xip1E_14_uid258_vecTranslateTest_q(32 downto 0);
    xip1_14_uid264_vecTranslateTest_b <= xip1_14_uid264_vecTranslateTest_in(32 downto 0);

    -- redist7_xip1_14_uid264_vecTranslateTest_b_1(DELAY,354)
    redist7_xip1_14_uid264_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_14_uid264_vecTranslateTest_b, xout => redist7_xip1_14_uid264_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- twoToMiSiXip_uid271_vecTranslateTest(BITSELECT,270)@15
    twoToMiSiXip_uid271_vecTranslateTest_b <= redist7_xip1_14_uid264_vecTranslateTest_b_1_q(32 downto 14);

    -- twoToMiSiXip_uid254_vecTranslateTest(BITSELECT,253)@14
    twoToMiSiXip_uid254_vecTranslateTest_b <= redist10_xip1_13_uid247_vecTranslateTest_b_1_q(32 downto 13);

    -- yip1E_14_uid259_vecTranslateTest(ADDSUB,258)@14
    yip1E_14_uid259_vecTranslateTest_s <= xMSB_uid250_vecTranslateTest_b;
    yip1E_14_uid259_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => redist9_yip1_13_uid248_vecTranslateTest_b_1_q(21)) & redist9_yip1_13_uid248_vecTranslateTest_b_1_q));
    yip1E_14_uid259_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid254_vecTranslateTest_b));
    yip1E_14_uid259_vecTranslateTest_combproc: PROCESS (yip1E_14_uid259_vecTranslateTest_a, yip1E_14_uid259_vecTranslateTest_b, yip1E_14_uid259_vecTranslateTest_s)
    BEGIN
        IF (yip1E_14_uid259_vecTranslateTest_s = "1") THEN
            yip1E_14_uid259_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_14_uid259_vecTranslateTest_a) + SIGNED(yip1E_14_uid259_vecTranslateTest_b));
        ELSE
            yip1E_14_uid259_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_14_uid259_vecTranslateTest_a) - SIGNED(yip1E_14_uid259_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_14_uid259_vecTranslateTest_q <= yip1E_14_uid259_vecTranslateTest_o(22 downto 0);

    -- yip1_14_uid265_vecTranslateTest(BITSELECT,264)@14
    yip1_14_uid265_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_14_uid259_vecTranslateTest_q(20 downto 0));
    yip1_14_uid265_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_14_uid265_vecTranslateTest_in(20 downto 0));

    -- redist6_yip1_14_uid265_vecTranslateTest_b_1(DELAY,353)
    redist6_yip1_14_uid265_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 21, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_14_uid265_vecTranslateTest_b, xout => redist6_yip1_14_uid265_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- yip1E_15_uid276_vecTranslateTest(ADDSUB,275)@15
    yip1E_15_uid276_vecTranslateTest_s <= xMSB_uid267_vecTranslateTest_b;
    yip1E_15_uid276_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 21 => redist6_yip1_14_uid265_vecTranslateTest_b_1_q(20)) & redist6_yip1_14_uid265_vecTranslateTest_b_1_q));
    yip1E_15_uid276_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & twoToMiSiXip_uid271_vecTranslateTest_b));
    yip1E_15_uid276_vecTranslateTest_combproc: PROCESS (yip1E_15_uid276_vecTranslateTest_a, yip1E_15_uid276_vecTranslateTest_b, yip1E_15_uid276_vecTranslateTest_s)
    BEGIN
        IF (yip1E_15_uid276_vecTranslateTest_s = "1") THEN
            yip1E_15_uid276_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_15_uid276_vecTranslateTest_a) + SIGNED(yip1E_15_uid276_vecTranslateTest_b));
        ELSE
            yip1E_15_uid276_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_15_uid276_vecTranslateTest_a) - SIGNED(yip1E_15_uid276_vecTranslateTest_b));
        END IF;
    END PROCESS;
    yip1E_15_uid276_vecTranslateTest_q <= yip1E_15_uid276_vecTranslateTest_o(21 downto 0);

    -- yip1_15_uid282_vecTranslateTest(BITSELECT,281)@15
    yip1_15_uid282_vecTranslateTest_in <= STD_LOGIC_VECTOR(yip1E_15_uid276_vecTranslateTest_q(19 downto 0));
    yip1_15_uid282_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_15_uid282_vecTranslateTest_in(19 downto 0));

    -- xMSB_uid284_vecTranslateTest(BITSELECT,283)@15
    xMSB_uid284_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_15_uid282_vecTranslateTest_b(19 downto 19));

    -- redist3_xMSB_uid284_vecTranslateTest_b_1(DELAY,350)
    redist3_xMSB_uid284_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid284_vecTranslateTest_b, xout => redist3_xMSB_uid284_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- invSignOfSelectionSignal_uid291_vecTranslateTest(LOGICAL,290)@16
    invSignOfSelectionSignal_uid291_vecTranslateTest_q <= not (redist3_xMSB_uid284_vecTranslateTest_b_1_q);

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- twoToMiSiYip_uid289_vecTranslateTest(BITSELECT,288)@15
    twoToMiSiYip_uid289_vecTranslateTest_b <= STD_LOGIC_VECTOR(yip1_15_uid282_vecTranslateTest_b(19 downto 15));

    -- redist2_twoToMiSiYip_uid289_vecTranslateTest_b_1(DELAY,349)
    redist2_twoToMiSiYip_uid289_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 5, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => twoToMiSiYip_uid289_vecTranslateTest_b, xout => redist2_twoToMiSiYip_uid289_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- invSignOfSelectionSignal_uid274_vecTranslateTest(LOGICAL,273)@15
    invSignOfSelectionSignal_uid274_vecTranslateTest_q <= not (xMSB_uid267_vecTranslateTest_b);

    -- twoToMiSiYip_uid272_vecTranslateTest(BITSELECT,271)@15
    twoToMiSiYip_uid272_vecTranslateTest_b <= STD_LOGIC_VECTOR(redist6_yip1_14_uid265_vecTranslateTest_b_1_q(20 downto 14));

    -- xip1E_15_uid275_vecTranslateTest(ADDSUB,274)@15
    xip1E_15_uid275_vecTranslateTest_s <= invSignOfSelectionSignal_uid274_vecTranslateTest_q;
    xip1E_15_uid275_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist7_xip1_14_uid264_vecTranslateTest_b_1_q));
    xip1E_15_uid275_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 7 => twoToMiSiYip_uid272_vecTranslateTest_b(6)) & twoToMiSiYip_uid272_vecTranslateTest_b));
    xip1E_15_uid275_vecTranslateTest_combproc: PROCESS (xip1E_15_uid275_vecTranslateTest_a, xip1E_15_uid275_vecTranslateTest_b, xip1E_15_uid275_vecTranslateTest_s)
    BEGIN
        IF (xip1E_15_uid275_vecTranslateTest_s = "1") THEN
            xip1E_15_uid275_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_15_uid275_vecTranslateTest_a) + SIGNED(xip1E_15_uid275_vecTranslateTest_b));
        ELSE
            xip1E_15_uid275_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_15_uid275_vecTranslateTest_a) - SIGNED(xip1E_15_uid275_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_15_uid275_vecTranslateTest_q <= xip1E_15_uid275_vecTranslateTest_o(34 downto 0);

    -- xip1_15_uid281_vecTranslateTest(BITSELECT,280)@15
    xip1_15_uid281_vecTranslateTest_in <= xip1E_15_uid275_vecTranslateTest_q(32 downto 0);
    xip1_15_uid281_vecTranslateTest_b <= xip1_15_uid281_vecTranslateTest_in(32 downto 0);

    -- redist4_xip1_15_uid281_vecTranslateTest_b_1(DELAY,351)
    redist4_xip1_15_uid281_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_15_uid281_vecTranslateTest_b, xout => redist4_xip1_15_uid281_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- xip1E_16_uid292_vecTranslateTest(ADDSUB,291)@16
    xip1E_16_uid292_vecTranslateTest_s <= invSignOfSelectionSignal_uid291_vecTranslateTest_q;
    xip1E_16_uid292_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist4_xip1_15_uid281_vecTranslateTest_b_1_q));
    xip1E_16_uid292_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 5 => redist2_twoToMiSiYip_uid289_vecTranslateTest_b_1_q(4)) & redist2_twoToMiSiYip_uid289_vecTranslateTest_b_1_q));
    xip1E_16_uid292_vecTranslateTest_combproc: PROCESS (xip1E_16_uid292_vecTranslateTest_a, xip1E_16_uid292_vecTranslateTest_b, xip1E_16_uid292_vecTranslateTest_s)
    BEGIN
        IF (xip1E_16_uid292_vecTranslateTest_s = "1") THEN
            xip1E_16_uid292_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_16_uid292_vecTranslateTest_a) + SIGNED(xip1E_16_uid292_vecTranslateTest_b));
        ELSE
            xip1E_16_uid292_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_16_uid292_vecTranslateTest_a) - SIGNED(xip1E_16_uid292_vecTranslateTest_b));
        END IF;
    END PROCESS;
    xip1E_16_uid292_vecTranslateTest_q <= xip1E_16_uid292_vecTranslateTest_o(34 downto 0);

    -- xip1_16_uid298_vecTranslateTest(BITSELECT,297)@16
    xip1_16_uid298_vecTranslateTest_in <= xip1E_16_uid292_vecTranslateTest_q(32 downto 0);
    xip1_16_uid298_vecTranslateTest_b <= xip1_16_uid298_vecTranslateTest_in(32 downto 0);

    -- outMagPreRnd_uid341_vecTranslateTest(BITSELECT,340)@16
    outMagPreRnd_uid341_vecTranslateTest_b <= xip1_16_uid298_vecTranslateTest_b(32 downto 16);

    -- redist1_outMagPreRnd_uid341_vecTranslateTest_b_1(DELAY,348)
    redist1_outMagPreRnd_uid341_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 17, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => outMagPreRnd_uid341_vecTranslateTest_b, xout => redist1_outMagPreRnd_uid341_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- outMagPostRnd_uid344_vecTranslateTest(ADD,343)@17
    outMagPostRnd_uid344_vecTranslateTest_a <= STD_LOGIC_VECTOR("0" & redist1_outMagPreRnd_uid341_vecTranslateTest_b_1_q);
    outMagPostRnd_uid344_vecTranslateTest_b <= STD_LOGIC_VECTOR("00000000000000000" & VCC_q);
    outMagPostRnd_uid344_vecTranslateTest_o <= STD_LOGIC_VECTOR(UNSIGNED(outMagPostRnd_uid344_vecTranslateTest_a) + UNSIGNED(outMagPostRnd_uid344_vecTranslateTest_b));
    outMagPostRnd_uid344_vecTranslateTest_q <= outMagPostRnd_uid344_vecTranslateTest_o(17 downto 0);

    -- outMag_uid345_vecTranslateTest(BITSELECT,344)@17
    outMag_uid345_vecTranslateTest_in <= outMagPostRnd_uid344_vecTranslateTest_q(16 downto 0);
    outMag_uid345_vecTranslateTest_b <= outMag_uid345_vecTranslateTest_in(16 downto 1);

    -- redist0_outMag_uid345_vecTranslateTest_b_1(DELAY,347)
    redist0_outMag_uid345_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => outMag_uid345_vecTranslateTest_b, xout => redist0_outMag_uid345_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- constPi_uid332_vecTranslateTest(CONSTANT,331)
    constPi_uid332_vecTranslateTest_q <= "11001001000100000";

    -- constPiP2uE_uid323_vecTranslateTest(CONSTANT,322)
    constPiP2uE_uid323_vecTranslateTest_q <= "1100100100010010";

    -- constPio2P2u_mergedSignalTM_uid326_vecTranslateTest(BITJOIN,325)@17
    constPio2P2u_mergedSignalTM_uid326_vecTranslateTest_q <= GND_q & constPiP2uE_uid323_vecTranslateTest_q;

    -- cstZeroOutFormat_uid322_vecTranslateTest(CONSTANT,321)
    cstZeroOutFormat_uid322_vecTranslateTest_q <= "00000000000000010";

    -- redist44_xMSB_uid32_vecTranslateTest_b_14(DELAY,391)
    redist44_xMSB_uid32_vecTranslateTest_b_14 : dspba_delay
    GENERIC MAP ( width => 1, depth => 14, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid32_vecTranslateTest_b, xout => redist44_xMSB_uid32_vecTranslateTest_b_14_q, ena => en(0), clk => clk, aclr => areset );

    -- redist41_xMSB_uid51_vecTranslateTest_b_13(DELAY,388)
    redist41_xMSB_uid51_vecTranslateTest_b_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 13, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid51_vecTranslateTest_b, xout => redist41_xMSB_uid51_vecTranslateTest_b_13_q, ena => en(0), clk => clk, aclr => areset );

    -- redist38_xMSB_uid70_vecTranslateTest_b_12(DELAY,385)
    redist38_xMSB_uid70_vecTranslateTest_b_12 : dspba_delay
    GENERIC MAP ( width => 1, depth => 12, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid70_vecTranslateTest_b, xout => redist38_xMSB_uid70_vecTranslateTest_b_12_q, ena => en(0), clk => clk, aclr => areset );

    -- redist35_xMSB_uid89_vecTranslateTest_b_11(DELAY,382)
    redist35_xMSB_uid89_vecTranslateTest_b_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 11, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid89_vecTranslateTest_b, xout => redist35_xMSB_uid89_vecTranslateTest_b_11_q, ena => en(0), clk => clk, aclr => areset );

    -- redist32_xMSB_uid108_vecTranslateTest_b_10(DELAY,379)
    redist32_xMSB_uid108_vecTranslateTest_b_10 : dspba_delay
    GENERIC MAP ( width => 1, depth => 10, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid108_vecTranslateTest_b, xout => redist32_xMSB_uid108_vecTranslateTest_b_10_q, ena => en(0), clk => clk, aclr => areset );

    -- redist29_xMSB_uid127_vecTranslateTest_b_9(DELAY,376)
    redist29_xMSB_uid127_vecTranslateTest_b_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 9, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid127_vecTranslateTest_b, xout => redist29_xMSB_uid127_vecTranslateTest_b_9_q, ena => en(0), clk => clk, aclr => areset );

    -- redist26_xMSB_uid148_vecTranslateTest_b_8(DELAY,373)
    redist26_xMSB_uid148_vecTranslateTest_b_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid148_vecTranslateTest_b, xout => redist26_xMSB_uid148_vecTranslateTest_b_8_q, ena => en(0), clk => clk, aclr => areset );

    -- redist23_xMSB_uid165_vecTranslateTest_b_7(DELAY,370)
    redist23_xMSB_uid165_vecTranslateTest_b_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid165_vecTranslateTest_b, xout => redist23_xMSB_uid165_vecTranslateTest_b_7_q, ena => en(0), clk => clk, aclr => areset );

    -- redist20_xMSB_uid182_vecTranslateTest_b_6(DELAY,367)
    redist20_xMSB_uid182_vecTranslateTest_b_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid182_vecTranslateTest_b, xout => redist20_xMSB_uid182_vecTranslateTest_b_6_q, ena => en(0), clk => clk, aclr => areset );

    -- redist17_xMSB_uid199_vecTranslateTest_b_5(DELAY,364)
    redist17_xMSB_uid199_vecTranslateTest_b_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid199_vecTranslateTest_b, xout => redist17_xMSB_uid199_vecTranslateTest_b_5_q, ena => en(0), clk => clk, aclr => areset );

    -- redist14_xMSB_uid216_vecTranslateTest_b_4(DELAY,361)
    redist14_xMSB_uid216_vecTranslateTest_b_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid216_vecTranslateTest_b, xout => redist14_xMSB_uid216_vecTranslateTest_b_4_q, ena => en(0), clk => clk, aclr => areset );

    -- redist11_xMSB_uid233_vecTranslateTest_b_3(DELAY,358)
    redist11_xMSB_uid233_vecTranslateTest_b_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid233_vecTranslateTest_b, xout => redist11_xMSB_uid233_vecTranslateTest_b_3_q, ena => en(0), clk => clk, aclr => areset );

    -- redist8_xMSB_uid250_vecTranslateTest_b_2(DELAY,355)
    redist8_xMSB_uid250_vecTranslateTest_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid250_vecTranslateTest_b, xout => redist8_xMSB_uid250_vecTranslateTest_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- redist5_xMSB_uid267_vecTranslateTest_b_1(DELAY,352)
    redist5_xMSB_uid267_vecTranslateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid267_vecTranslateTest_b, xout => redist5_xMSB_uid267_vecTranslateTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- concSignVector_uid301_vecTranslateTest(BITJOIN,300)@16
    concSignVector_uid301_vecTranslateTest_q <= GND_q & redist44_xMSB_uid32_vecTranslateTest_b_14_q & redist41_xMSB_uid51_vecTranslateTest_b_13_q & redist38_xMSB_uid70_vecTranslateTest_b_12_q & redist35_xMSB_uid89_vecTranslateTest_b_11_q & redist32_xMSB_uid108_vecTranslateTest_b_10_q & redist29_xMSB_uid127_vecTranslateTest_b_9_q & redist26_xMSB_uid148_vecTranslateTest_b_8_q & redist23_xMSB_uid165_vecTranslateTest_b_7_q & redist20_xMSB_uid182_vecTranslateTest_b_6_q & redist17_xMSB_uid199_vecTranslateTest_b_5_q & redist14_xMSB_uid216_vecTranslateTest_b_4_q & redist11_xMSB_uid233_vecTranslateTest_b_3_q & redist8_xMSB_uid250_vecTranslateTest_b_2_q & redist5_xMSB_uid267_vecTranslateTest_b_1_q & redist3_xMSB_uid284_vecTranslateTest_b_1_q;

    -- is0_uid302_vecTranslateTest_merged_bit_select(BITSELECT,346)@16
    is0_uid302_vecTranslateTest_merged_bit_select_b <= concSignVector_uid301_vecTranslateTest_q(15 downto 12);
    is0_uid302_vecTranslateTest_merged_bit_select_c <= concSignVector_uid301_vecTranslateTest_q(11 downto 8);
    is0_uid302_vecTranslateTest_merged_bit_select_d <= concSignVector_uid301_vecTranslateTest_q(7 downto 4);
    is0_uid302_vecTranslateTest_merged_bit_select_e <= concSignVector_uid301_vecTranslateTest_q(3 downto 0);

    -- table_l15_uid315_vecTranslateTest(LOOKUP,314)@16
    table_l15_uid315_vecTranslateTest_combproc: PROCESS (is0_uid302_vecTranslateTest_merged_bit_select_e)
    BEGIN
        -- Begin reserved scope level
        CASE (is0_uid302_vecTranslateTest_merged_bit_select_e) IS
            WHEN "0000" => table_l15_uid315_vecTranslateTest_q <= "011110000";
            WHEN "0001" => table_l15_uid315_vecTranslateTest_q <= "011010000";
            WHEN "0010" => table_l15_uid315_vecTranslateTest_q <= "010110000";
            WHEN "0011" => table_l15_uid315_vecTranslateTest_q <= "010010000";
            WHEN "0100" => table_l15_uid315_vecTranslateTest_q <= "001110000";
            WHEN "0101" => table_l15_uid315_vecTranslateTest_q <= "001010000";
            WHEN "0110" => table_l15_uid315_vecTranslateTest_q <= "000110000";
            WHEN "0111" => table_l15_uid315_vecTranslateTest_q <= "000010000";
            WHEN "1000" => table_l15_uid315_vecTranslateTest_q <= "111110000";
            WHEN "1001" => table_l15_uid315_vecTranslateTest_q <= "111010000";
            WHEN "1010" => table_l15_uid315_vecTranslateTest_q <= "110110000";
            WHEN "1011" => table_l15_uid315_vecTranslateTest_q <= "110010000";
            WHEN "1100" => table_l15_uid315_vecTranslateTest_q <= "101110000";
            WHEN "1101" => table_l15_uid315_vecTranslateTest_q <= "101010000";
            WHEN "1110" => table_l15_uid315_vecTranslateTest_q <= "100110000";
            WHEN "1111" => table_l15_uid315_vecTranslateTest_q <= "100010000";
            WHEN OTHERS => -- unreachable
                           table_l15_uid315_vecTranslateTest_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- table_l11_uid311_vecTranslateTest(LOOKUP,310)@16
    table_l11_uid311_vecTranslateTest_combproc: PROCESS (is0_uid302_vecTranslateTest_merged_bit_select_d)
    BEGIN
        -- Begin reserved scope level
        CASE (is0_uid302_vecTranslateTest_merged_bit_select_d) IS
            WHEN "0000" => table_l11_uid311_vecTranslateTest_q <= "0111100000000";
            WHEN "0001" => table_l11_uid311_vecTranslateTest_q <= "0110100000000";
            WHEN "0010" => table_l11_uid311_vecTranslateTest_q <= "0101100000000";
            WHEN "0011" => table_l11_uid311_vecTranslateTest_q <= "0100100000000";
            WHEN "0100" => table_l11_uid311_vecTranslateTest_q <= "0011100000000";
            WHEN "0101" => table_l11_uid311_vecTranslateTest_q <= "0010100000000";
            WHEN "0110" => table_l11_uid311_vecTranslateTest_q <= "0001100000000";
            WHEN "0111" => table_l11_uid311_vecTranslateTest_q <= "0000100000000";
            WHEN "1000" => table_l11_uid311_vecTranslateTest_q <= "1111100000000";
            WHEN "1001" => table_l11_uid311_vecTranslateTest_q <= "1110100000000";
            WHEN "1010" => table_l11_uid311_vecTranslateTest_q <= "1101100000000";
            WHEN "1011" => table_l11_uid311_vecTranslateTest_q <= "1100100000000";
            WHEN "1100" => table_l11_uid311_vecTranslateTest_q <= "1011100000000";
            WHEN "1101" => table_l11_uid311_vecTranslateTest_q <= "1010100000000";
            WHEN "1110" => table_l11_uid311_vecTranslateTest_q <= "1001100000000";
            WHEN "1111" => table_l11_uid311_vecTranslateTest_q <= "1000100000000";
            WHEN OTHERS => -- unreachable
                           table_l11_uid311_vecTranslateTest_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- lev1_a1_uid319_vecTranslateTest(ADD,318)@16 + 1
    lev1_a1_uid319_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 13 => table_l11_uid311_vecTranslateTest_q(12)) & table_l11_uid311_vecTranslateTest_q));
    lev1_a1_uid319_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 9 => table_l15_uid315_vecTranslateTest_q(8)) & table_l15_uid315_vecTranslateTest_q));
    lev1_a1_uid319_vecTranslateTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            lev1_a1_uid319_vecTranslateTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                lev1_a1_uid319_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(lev1_a1_uid319_vecTranslateTest_a) + SIGNED(lev1_a1_uid319_vecTranslateTest_b));
            END IF;
        END IF;
    END PROCESS;
    lev1_a1_uid319_vecTranslateTest_q <= lev1_a1_uid319_vecTranslateTest_o(13 downto 0);

    -- table_l7_uid307_vecTranslateTest(LOOKUP,306)@16
    table_l7_uid307_vecTranslateTest_combproc: PROCESS (is0_uid302_vecTranslateTest_merged_bit_select_c)
    BEGIN
        -- Begin reserved scope level
        CASE (is0_uid302_vecTranslateTest_merged_bit_select_c) IS
            WHEN "0000" => table_l7_uid307_vecTranslateTest_q <= "01110111111001111";
            WHEN "0001" => table_l7_uid307_vecTranslateTest_q <= "01100111111010000";
            WHEN "0010" => table_l7_uid307_vecTranslateTest_q <= "01010111111010001";
            WHEN "0011" => table_l7_uid307_vecTranslateTest_q <= "01000111111010001";
            WHEN "0100" => table_l7_uid307_vecTranslateTest_q <= "00110111111011010";
            WHEN "0101" => table_l7_uid307_vecTranslateTest_q <= "00100111111011010";
            WHEN "0110" => table_l7_uid307_vecTranslateTest_q <= "00010111111011011";
            WHEN "0111" => table_l7_uid307_vecTranslateTest_q <= "00000111111011100";
            WHEN "1000" => table_l7_uid307_vecTranslateTest_q <= "11111000000100100";
            WHEN "1001" => table_l7_uid307_vecTranslateTest_q <= "11101000000100101";
            WHEN "1010" => table_l7_uid307_vecTranslateTest_q <= "11011000000100110";
            WHEN "1011" => table_l7_uid307_vecTranslateTest_q <= "11001000000100110";
            WHEN "1100" => table_l7_uid307_vecTranslateTest_q <= "10111000000101111";
            WHEN "1101" => table_l7_uid307_vecTranslateTest_q <= "10101000000101111";
            WHEN "1110" => table_l7_uid307_vecTranslateTest_q <= "10011000000110000";
            WHEN "1111" => table_l7_uid307_vecTranslateTest_q <= "10001000000110001";
            WHEN OTHERS => -- unreachable
                           table_l7_uid307_vecTranslateTest_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- table_l3_uid303_vecTranslateTest(LOOKUP,302)@16
    table_l3_uid303_vecTranslateTest_combproc: PROCESS (is0_uid302_vecTranslateTest_merged_bit_select_b)
    BEGIN
        -- Begin reserved scope level
        CASE (is0_uid302_vecTranslateTest_merged_bit_select_b) IS
            WHEN "0000" => table_l3_uid303_vecTranslateTest_q <= "011001111001010010001";
            WHEN "0001" => table_l3_uid303_vecTranslateTest_q <= "010101111010100110101";
            WHEN "0010" => table_l3_uid303_vecTranslateTest_q <= "010010000011100100010";
            WHEN "0011" => table_l3_uid303_vecTranslateTest_q <= "001110000100111000111";
            WHEN "0100" => table_l3_uid303_vecTranslateTest_q <= "001011000011101110111";
            WHEN "0101" => table_l3_uid303_vecTranslateTest_q <= "000111000101000011011";
            WHEN "0110" => table_l3_uid303_vecTranslateTest_q <= "000011001110000001000";
            WHEN "0111" => table_l3_uid303_vecTranslateTest_q <= "111111001111010101101";
            WHEN "1000" => table_l3_uid303_vecTranslateTest_q <= "000000110000110010011";
            WHEN "1001" => table_l3_uid303_vecTranslateTest_q <= "111100110010000111000";
            WHEN "1010" => table_l3_uid303_vecTranslateTest_q <= "111000111011000100101";
            WHEN "1011" => table_l3_uid303_vecTranslateTest_q <= "110100111100011001001";
            WHEN "1100" => table_l3_uid303_vecTranslateTest_q <= "110001111011001111001";
            WHEN "1101" => table_l3_uid303_vecTranslateTest_q <= "101101111100100011110";
            WHEN "1110" => table_l3_uid303_vecTranslateTest_q <= "101010000101100001011";
            WHEN "1111" => table_l3_uid303_vecTranslateTest_q <= "100110000110110101111";
            WHEN OTHERS => -- unreachable
                           table_l3_uid303_vecTranslateTest_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- lev1_a0_uid318_vecTranslateTest(ADD,317)@16 + 1
    lev1_a0_uid318_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => table_l3_uid303_vecTranslateTest_q(20)) & table_l3_uid303_vecTranslateTest_q));
    lev1_a0_uid318_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 17 => table_l7_uid307_vecTranslateTest_q(16)) & table_l7_uid307_vecTranslateTest_q));
    lev1_a0_uid318_vecTranslateTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            lev1_a0_uid318_vecTranslateTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                lev1_a0_uid318_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(lev1_a0_uid318_vecTranslateTest_a) + SIGNED(lev1_a0_uid318_vecTranslateTest_b));
            END IF;
        END IF;
    END PROCESS;
    lev1_a0_uid318_vecTranslateTest_q <= lev1_a0_uid318_vecTranslateTest_o(21 downto 0);

    -- lev2_a0_uid320_vecTranslateTest(ADD,319)@17
    lev2_a0_uid320_vecTranslateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 22 => lev1_a0_uid318_vecTranslateTest_q(21)) & lev1_a0_uid318_vecTranslateTest_q));
    lev2_a0_uid320_vecTranslateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 14 => lev1_a1_uid319_vecTranslateTest_q(13)) & lev1_a1_uid319_vecTranslateTest_q));
    lev2_a0_uid320_vecTranslateTest_o <= STD_LOGIC_VECTOR(SIGNED(lev2_a0_uid320_vecTranslateTest_a) + SIGNED(lev2_a0_uid320_vecTranslateTest_b));
    lev2_a0_uid320_vecTranslateTest_q <= lev2_a0_uid320_vecTranslateTest_o(22 downto 0);

    -- atanRes_uid321_vecTranslateTest(BITSELECT,320)@17
    atanRes_uid321_vecTranslateTest_in <= lev2_a0_uid320_vecTranslateTest_q(20 downto 0);
    atanRes_uid321_vecTranslateTest_b <= atanRes_uid321_vecTranslateTest_in(20 downto 4);

    -- xNotZero_uid17_vecTranslateTest(LOGICAL,16)@0 + 1
    xNotZero_uid17_vecTranslateTest_qi <= "1" WHEN x /= "0000000000000000" ELSE "0";
    xNotZero_uid17_vecTranslateTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xNotZero_uid17_vecTranslateTest_qi, xout => xNotZero_uid17_vecTranslateTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist45_xNotZero_uid17_vecTranslateTest_q_17(DELAY,392)
    redist45_xNotZero_uid17_vecTranslateTest_q_17 : dspba_delay
    GENERIC MAP ( width => 1, depth => 16, reset_kind => "ASYNC" )
    PORT MAP ( xin => xNotZero_uid17_vecTranslateTest_q, xout => redist45_xNotZero_uid17_vecTranslateTest_q_17_q, ena => en(0), clk => clk, aclr => areset );

    -- xZero_uid18_vecTranslateTest(LOGICAL,17)@17
    xZero_uid18_vecTranslateTest_q <= not (redist45_xNotZero_uid17_vecTranslateTest_q_17_q);

    -- yNotZero_uid15_vecTranslateTest(LOGICAL,14)@0 + 1
    yNotZero_uid15_vecTranslateTest_qi <= "1" WHEN y /= "0000000000000000" ELSE "0";
    yNotZero_uid15_vecTranslateTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yNotZero_uid15_vecTranslateTest_qi, xout => yNotZero_uid15_vecTranslateTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist46_yNotZero_uid15_vecTranslateTest_q_17(DELAY,393)
    redist46_yNotZero_uid15_vecTranslateTest_q_17 : dspba_delay
    GENERIC MAP ( width => 1, depth => 16, reset_kind => "ASYNC" )
    PORT MAP ( xin => yNotZero_uid15_vecTranslateTest_q, xout => redist46_yNotZero_uid15_vecTranslateTest_q_17_q, ena => en(0), clk => clk, aclr => areset );

    -- yZero_uid16_vecTranslateTest(LOGICAL,15)@17
    yZero_uid16_vecTranslateTest_q <= not (redist46_yNotZero_uid15_vecTranslateTest_q_17_q);

    -- concXZeroYZero_uid328_vecTranslateTest(BITJOIN,327)@17
    concXZeroYZero_uid328_vecTranslateTest_q <= xZero_uid18_vecTranslateTest_q & yZero_uid16_vecTranslateTest_q;

    -- atanResPostExc_uid329_vecTranslateTest(MUX,328)@17 + 1
    atanResPostExc_uid329_vecTranslateTest_s <= concXZeroYZero_uid328_vecTranslateTest_q;
    atanResPostExc_uid329_vecTranslateTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            atanResPostExc_uid329_vecTranslateTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (atanResPostExc_uid329_vecTranslateTest_s) IS
                    WHEN "00" => atanResPostExc_uid329_vecTranslateTest_q <= atanRes_uid321_vecTranslateTest_b;
                    WHEN "01" => atanResPostExc_uid329_vecTranslateTest_q <= cstZeroOutFormat_uid322_vecTranslateTest_q;
                    WHEN "10" => atanResPostExc_uid329_vecTranslateTest_q <= constPio2P2u_mergedSignalTM_uid326_vecTranslateTest_q;
                    WHEN "11" => atanResPostExc_uid329_vecTranslateTest_q <= cstZeroOutFormat_uid322_vecTranslateTest_q;
                    WHEN OTHERS => atanResPostExc_uid329_vecTranslateTest_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- constantZeroOutFormat_uid333_vecTranslateTest(CONSTANT,332)
    constantZeroOutFormat_uid333_vecTranslateTest_q <= "00000000000000000";

    -- redist50_signX_uid7_vecTranslateTest_b_18(DELAY,397)
    redist50_signX_uid7_vecTranslateTest_b_18 : dspba_delay
    GENERIC MAP ( width => 1, depth => 18, reset_kind => "ASYNC" )
    PORT MAP ( xin => signX_uid7_vecTranslateTest_b, xout => redist50_signX_uid7_vecTranslateTest_b_18_q, ena => en(0), clk => clk, aclr => areset );

    -- redist49_signY_uid8_vecTranslateTest_b_18(DELAY,396)
    redist49_signY_uid8_vecTranslateTest_b_18 : dspba_delay
    GENERIC MAP ( width => 1, depth => 18, reset_kind => "ASYNC" )
    PORT MAP ( xin => signY_uid8_vecTranslateTest_b, xout => redist49_signY_uid8_vecTranslateTest_b_18_q, ena => en(0), clk => clk, aclr => areset );

    -- concSigns_uid330_vecTranslateTest(BITJOIN,329)@18
    concSigns_uid330_vecTranslateTest_q <= redist50_signX_uid7_vecTranslateTest_b_18_q & redist49_signY_uid8_vecTranslateTest_b_18_q;

    -- secondOperand_uid337_vecTranslateTest(MUX,336)@18
    secondOperand_uid337_vecTranslateTest_s <= concSigns_uid330_vecTranslateTest_q;
    secondOperand_uid337_vecTranslateTest_combproc: PROCESS (secondOperand_uid337_vecTranslateTest_s, en, constantZeroOutFormat_uid333_vecTranslateTest_q, atanResPostExc_uid329_vecTranslateTest_q, constPi_uid332_vecTranslateTest_q)
    BEGIN
        CASE (secondOperand_uid337_vecTranslateTest_s) IS
            WHEN "00" => secondOperand_uid337_vecTranslateTest_q <= constantZeroOutFormat_uid333_vecTranslateTest_q;
            WHEN "01" => secondOperand_uid337_vecTranslateTest_q <= atanResPostExc_uid329_vecTranslateTest_q;
            WHEN "10" => secondOperand_uid337_vecTranslateTest_q <= atanResPostExc_uid329_vecTranslateTest_q;
            WHEN "11" => secondOperand_uid337_vecTranslateTest_q <= constPi_uid332_vecTranslateTest_q;
            WHEN OTHERS => secondOperand_uid337_vecTranslateTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- constPiP2u_uid331_vecTranslateTest(CONSTANT,330)
    constPiP2u_uid331_vecTranslateTest_q <= "11001001000100011";

    -- constantZeroOutFormatP2u_uid334_vecTranslateTest(CONSTANT,333)
    constantZeroOutFormatP2u_uid334_vecTranslateTest_q <= "00000000000000100";

    -- firstOperand_uid336_vecTranslateTest(MUX,335)@18
    firstOperand_uid336_vecTranslateTest_s <= concSigns_uid330_vecTranslateTest_q;
    firstOperand_uid336_vecTranslateTest_combproc: PROCESS (firstOperand_uid336_vecTranslateTest_s, en, atanResPostExc_uid329_vecTranslateTest_q, constantZeroOutFormatP2u_uid334_vecTranslateTest_q, constPiP2u_uid331_vecTranslateTest_q)
    BEGIN
        CASE (firstOperand_uid336_vecTranslateTest_s) IS
            WHEN "00" => firstOperand_uid336_vecTranslateTest_q <= atanResPostExc_uid329_vecTranslateTest_q;
            WHEN "01" => firstOperand_uid336_vecTranslateTest_q <= constantZeroOutFormatP2u_uid334_vecTranslateTest_q;
            WHEN "10" => firstOperand_uid336_vecTranslateTest_q <= constPiP2u_uid331_vecTranslateTest_q;
            WHEN "11" => firstOperand_uid336_vecTranslateTest_q <= atanResPostExc_uid329_vecTranslateTest_q;
            WHEN OTHERS => firstOperand_uid336_vecTranslateTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- outResExtended_uid338_vecTranslateTest(SUB,337)@18
    outResExtended_uid338_vecTranslateTest_a <= STD_LOGIC_VECTOR("0" & firstOperand_uid336_vecTranslateTest_q);
    outResExtended_uid338_vecTranslateTest_b <= STD_LOGIC_VECTOR("0" & secondOperand_uid337_vecTranslateTest_q);
    outResExtended_uid338_vecTranslateTest_o <= STD_LOGIC_VECTOR(UNSIGNED(outResExtended_uid338_vecTranslateTest_a) - UNSIGNED(outResExtended_uid338_vecTranslateTest_b));
    outResExtended_uid338_vecTranslateTest_q <= outResExtended_uid338_vecTranslateTest_o(17 downto 0);

    -- atanResPostRR_uid339_vecTranslateTest(BITSELECT,338)@18
    atanResPostRR_uid339_vecTranslateTest_b <= STD_LOGIC_VECTOR(outResExtended_uid338_vecTranslateTest_q(17 downto 2));

    -- xOut(GPOUT,4)@18
    q <= atanResPostRR_uid339_vecTranslateTest_b;
    r <= redist0_outMag_uid345_vecTranslateTest_b_1_q;

END normal;
