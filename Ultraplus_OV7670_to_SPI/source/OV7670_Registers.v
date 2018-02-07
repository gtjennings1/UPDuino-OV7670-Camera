//////////////////////////////////////////////////////////////////////////////////
// OV7670_Registers.v
//
// Author:			Thanh Tien Truong
//
// Description:
// ------------
//  LUT containing all the registers address and values 
//                            
//////////////////////////////////////////////////////////////////////////////////

module OV7670_Registers (
    input clk, 
    input resend, 
    input advance, 
    output [15:0] command, 
    output finished
);

    // Internal signals
    reg [15:0] sreg;
    reg finished_temp;
    reg [7:0] address = {8{1'b0}};
    
    // Assign values to outputs
    assign command = sreg; 
    assign finished = finished_temp;
    
    // When register and value is FFFF
    // a flag is asserted indicating the configuration is finished
    always @ (sreg) begin
        if(sreg == 16'hFFFF) begin
            finished_temp <= 1;
        end
        else begin
            finished_temp <= 0;
        end
    end
    
    // Get value out of the LUT
    always @ (posedge clk) begin
        if(resend == 1) begin           // reset the configuration
            address <= {8{1'b0}};
        end
        else if(advance == 1) begin     // Get the next value
            address <= address+1;
        end
           
        case (address) 
            0 : sreg <= 16'h12_80;          // COM7     RESET
            1 : sreg <= 16'h12_80;          // COM7     RESET
            2 : sreg <= 16'h12_00;          // COM7     Size & YUV output
            3 : sreg <= 16'h11_00;          // CLKRC    Use internal clock
            4 : sreg <= 16'h0C_00;          // COM3     Default
            5 : sreg <= 16'h3E_00;          // COM14    SDCW and scaling PCLK, manual scaling enable, PCLK divider          
            6 : sreg <= 16'h8C_00;          // RGB444   Disable RGB 444 format
            7 : sreg <= 16'h04_00;          // COM1     Disable CCIR 656
            8 : sreg <= 16'h40_00;          // COM15    Disable RGB 565 (effective only after disable RGB 444 format)
            9 : sreg <= 16'h3A_04;          // TSLB     Disable auto-reset window
            10 : sreg <= 16'h14_6A;         // COM9     Set auto gain ceiling to x16 
            11 : sreg <= 16'h4F_40;         // MTX1     matrix coefficient 1(default)
            12 : sreg <= 16'h50_34;         // MTX2     matrix coefficient 2(default)
            13 : sreg <= 16'h51_0C;         // MTX3     matrix coefficient 3(default)
            14 : sreg <= 16'h52_17;         // MTX4     matrix coefficient 4(default)
            15 : sreg <= 16'h53_29;         // MTX5     matrix coefficient 5(default)
            16 : sreg <= 16'h54_40;         // MTX6     matrix coefficient 6(default)
            17 : sreg <= 16'h58_1E;         // MTXS     default
            18 : sreg <= 16'h3D_C0;         // COM13    Turn on GAMMA and auto UV adjust
            19 : sreg <= 16'h11_00;         // CLKRC    Use internal clock 
            20 : sreg <= 16'h17_16;         // HSTART   Horizontal Frame start (high 8 bits)
            21 : sreg <= 16'h18_04;         // HSTOP    Horizontal Frame stop (high 8 bits)
            22 : sreg <= 16'h32_A4;         // HREF     set Horizontal Frame control
            23 : sreg <= 16'h19_02;         // VSTART   Vertical Frame start (high 8 bits)
            24 : sreg <= 16'h1A_7A;         // VSTOP    Vertical Frame stop (high 8 bits)
            25 : sreg <= 16'h03_0A;         // VREF     set Vertical Frame control
            26 : sreg <= 16'h0E_61;         // COM5     reserve
            27 : sreg <= 16'h0F_4B;         // COM6     Enable HREF at optical black
            28 : sreg <= 16'h16_02;         // RSVD     reserve
            29 : sreg <= 16'h1E_17;         // MVFP     detect mirror image and enable flip image
            30 : sreg <= 16'h21_02;         // ADCCTR1  reserve
            31 : sreg <= 16'h22_91;         // ADCCTR2  reserve
            32 : sreg <= 16'h29_07;         // RSVD     reserve
            33 : sreg <= 16'h33_0B;         // CHLF     reserve
            34 : sreg <= 16'h35_0B;         // RSVD     reserve
            35 : sreg <= 16'h37_1D;         // ADC      reserve
            36 : sreg <= 16'h38_71;         // ACOM     reserve
            37 : sreg <= 16'h39_2A;         // OFON     reserve
            38 : sreg <= 16'h3C_78;         // COM12    Set to no HREF when VSYNC is low
            39 : sreg <= 16'h4D_40;         // RSVD     reserve
            40 : sreg <= 16'h4E_20;         // RSVD     reserve
            41 : sreg <= 16'h69_00;         // GFIX     Fix gain control (default)
            42 : sreg <= 16'h6B_4A;         // DBLV     set PLL control to 4x and bypass internal regulator
            43 : sreg <= 16'h70_3A;          // SCALING_XSC
            44 : sreg <= 16'h71_35;          // SCALING_YSC
            45 : sreg <= 16'h72_11;          // SCALING_DCWCTR
            46 : sreg <= 16'h73_F0;          // SCALING_PCLK_DIV
            47 : sreg <= 16'h74_10;         // REG74    default
            48 : sreg <= 16'h8D_4F;         // RSVD     reserve
            49 : sreg <= 16'h8E_00;         // RSVD     reserve
            50 : sreg <= 16'h8F_00;         // RSVD     reserve
            51 : sreg <= 16'h90_00;         // RSVD     reserve
            52 : sreg <= 16'h91_00;         // RSVD     reserve
            53 : sreg <= 16'h96_00;         // RSVD     reserve
            54 : sreg <= 16'h9A_00;         // RSVD     reserve
            55 : sreg <= 16'hA2_02;          // SCALING_PCLK_DELAY
            56 : sreg <= 16'hB0_84;         // RSVD     reserve
            57 : sreg <= 16'hB1_0C;         // ABLC1    disable ABLC function
            58 : sreg <= 16'hB2_0E;         // RSVD     reserve
            59 : sreg <= 16'hB3_82;         // RSVD     reserve
            60 : sreg <= 16'hB8_0A;         // RSVD     reserve
            default : sreg <= 16'hFF_FF;    // End configuration
        endcase  
            
    end
endmodule