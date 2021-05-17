
_init:
;Drv.c,5 :: 		void init(void){
;Drv.c,9 :: 		WMCON = 0b11111001;  // Enable WatchDog Timer, set prescaller bits to 111
	MOV WMCON+0, #249
;Drv.c,12 :: 		WMCON|=0x08;  // internal EEPROM enable
	ORL WMCON+0, #8
;Drv.c,13 :: 		WMCON&=0xfb;  // DPTR = DP0
	ANL WMCON+0, #251
;Drv.c,16 :: 		PCON |= 0x80;        // SMOD=1
	ORL PCON+0, #128
;Drv.c,17 :: 		SCON = 0x72;        // mode 1, receiver enable
	MOV SCON+0, #114
;Drv.c,18 :: 		TMOD = 0x22;        //Timers 0&1 are 8-bit timers with auto-reload
	MOV TMOD+0, #34
;Drv.c,19 :: 		TH1   = 0xF5;        // 9600 baud at 20 MHz
	MOV TH1+0, #245
;Drv.c,20 :: 		ES_bit = 0;
	CLR ES_bit+0
;Drv.c,23 :: 		TF1_bit = 0;       // Ensure that Timer1 interrupt flag is cleared
	CLR TF1_bit+0
;Drv.c,24 :: 		ET1_bit = 1;       // Enable Timer1 interrupt
	SETB ET1_bit+0
;Drv.c,25 :: 		EA_bit  = 1;       // Set global interrupt enable
	SETB EA_bit+0
;Drv.c,27 :: 		GATE1_bit = 0;     // Clear this flag to enable Timer1 whenever TR1 bit is set.
	CLR C
	MOV A, GATE1_bit+0
	MOV #224, C
	MOV GATE1_bit+0, A
;Drv.c,28 :: 		C_T1_bit  = 0;     // Set Timer operation: Timer1 counts the divided-down systam clock.
	CLR C
	MOV A, C_T1_bit+0
	MOV #224, C
	MOV C_T1_bit+0, A
;Drv.c,29 :: 		M11_bit   = 0;     // M11_M01 = 01    =>   Mode 1(16-bit Timer/Counter)
	CLR C
	MOV A, M11_bit+0
	MOV #224, C
	MOV M11_bit+0, A
;Drv.c,30 :: 		M01_bit   = 1;
	SETB C
	MOV A, M01_bit+0
	MOV #224, C
	MOV M01_bit+0, A
;Drv.c,32 :: 		TR1_bit = 0;       // Turn off Timer1
	CLR TR1_bit+0
;Drv.c,33 :: 		TH1 = 0xFC;        // Reset Timer1 high byte  65536-1000
	MOV TH1+0, #252
;Drv.c,34 :: 		TL1 = 0x18;        // Reset Timer1 low byte
	MOV TL1+0, #24
;Drv.c,35 :: 		TR1_bit = 1;       // Run Timer1
	SETB TR1_bit+0
;Drv.c,39 :: 		P3=0xff;
	MOV P3+0, #255
;Drv.c,40 :: 		EX0_bit = 1;
	SETB EX0_bit+0
;Drv.c,44 :: 		delay_ms(30);
	MOV R6, 49
	MOV R7, 162
	DJNZ R7, 
	DJNZ R6, 
;Drv.c,45 :: 		RW = 0;
	CLR C
	MOV A, P3_5_bit+0
	MOV #224, C
	MOV P3_5_bit+0, A
;Drv.c,46 :: 		outcw(0x3C);
	MOV FARG_outcw_c+0, #60
	LCALL _outcw+0
;Drv.c,47 :: 		outcw(0x0C);
	MOV FARG_outcw_c+0, #12
	LCALL _outcw+0
;Drv.c,48 :: 		outcw(0x01);
	MOV FARG_outcw_c+0, #1
	LCALL _outcw+0
;Drv.c,49 :: 		outcw(0x06);
	MOV FARG_outcw_c+0, #6
	LCALL _outcw+0
;Drv.c,50 :: 		outcw(0x40);
	MOV FARG_outcw_c+0, #64
	LCALL _outcw+0
;Drv.c,51 :: 		for(i=0;i<8;i++) outd(0);
	MOV init_i_L0+0, #0
L_init0:
	CLR C
	MOV A, init_i_L0+0
	SUBB A, #8
	JNC L_init1
	MOV FARG_outd_c+0, #0
	LCALL _outd+0
	INC init_i_L0+0
	SJMP L_init0
L_init1:
;Drv.c,52 :: 		for(i=0;i<8;i++) outd(0x10);
	MOV init_i_L0+0, #0
L_init3:
	CLR C
	MOV A, init_i_L0+0
	SUBB A, #8
	JNC L_init4
	MOV FARG_outd_c+0, #16
	LCALL _outd+0
	INC init_i_L0+0
	SJMP L_init3
L_init4:
;Drv.c,53 :: 		for(i=0;i<8;i++) outd(0x18);
	MOV init_i_L0+0, #0
L_init6:
	CLR C
	MOV A, init_i_L0+0
	SUBB A, #8
	JNC L_init7
	MOV FARG_outd_c+0, #24
	LCALL _outd+0
	INC init_i_L0+0
	SJMP L_init6
L_init7:
;Drv.c,54 :: 		for(i=0;i<8;i++) outd(0x1C);
	MOV init_i_L0+0, #0
L_init9:
	CLR C
	MOV A, init_i_L0+0
	SUBB A, #8
	JNC L_init10
	MOV FARG_outd_c+0, #28
	LCALL _outd+0
	INC init_i_L0+0
	SJMP L_init9
L_init10:
;Drv.c,55 :: 		for(i=0;i<8;i++) outd(0x1E);
	MOV init_i_L0+0, #0
L_init12:
	CLR C
	MOV A, init_i_L0+0
	SUBB A, #8
	JNC L_init13
	MOV FARG_outd_c+0, #30
	LCALL _outd+0
	INC init_i_L0+0
	SJMP L_init12
L_init13:
;Drv.c,56 :: 		for(i=0;i<8;i++) outd(0x1F);
	MOV init_i_L0+0, #0
L_init15:
	CLR C
	MOV A, init_i_L0+0
	SUBB A, #8
	JNC L_init16
	MOV FARG_outd_c+0, #31
	LCALL _outd+0
	INC init_i_L0+0
	SJMP L_init15
L_init16:
;Drv.c,57 :: 		}
	RET
; end of _init

_ScanKbd:
;Drv.c,59 :: 		unsigned char ScanKbd(void) {
;Drv.c,61 :: 		unsigned char kp = 0;
	MOV ScanKbd_kp_L0+0, #0
;Drv.c,62 :: 		P0 = P0&0x1F|0xC0;
	MOV A, P0+0
	ANL A, #31
	MOV R0, A
	ORL A, #192
	MOV P0+0, A
;Drv.c,63 :: 		for(i=0;i<10;i++);
	MOV ScanKbd_i_L0+0, #0
L_ScanKbd18:
	CLR C
	MOV A, ScanKbd_i_L0+0
	SUBB A, #10
	JNC L_ScanKbd19
	INC ScanKbd_i_L0+0
	SJMP L_ScanKbd18
L_ScanKbd19:
;Drv.c,64 :: 		if (!P1_0_bit) kp = '7';
	JB P1_0_bit+0, L_ScanKbd21
	NOP
	MOV ScanKbd_kp_L0+0, #55
	SJMP L_ScanKbd22
L_ScanKbd21:
;Drv.c,65 :: 		else if (!P1_1_bit) kp = '4';
	JB P1_1_bit+0, L_ScanKbd23
	NOP
	MOV ScanKbd_kp_L0+0, #52
	SJMP L_ScanKbd24
L_ScanKbd23:
;Drv.c,66 :: 		else if (!P1_2_bit) kp = '1';
	JB P1_2_bit+0, L_ScanKbd25
	NOP
	MOV ScanKbd_kp_L0+0, #49
	SJMP L_ScanKbd26
L_ScanKbd25:
;Drv.c,67 :: 		else if (!P1_3_bit) kp = '#';
	JB P1_3_bit+0, L_ScanKbd27
	NOP
	MOV ScanKbd_kp_L0+0, #35
L_ScanKbd27:
L_ScanKbd26:
L_ScanKbd24:
L_ScanKbd22:
;Drv.c,68 :: 		P0 = P0&0x1F|0xA0;
	MOV A, P0+0
	ANL A, #31
	MOV R0, A
	ORL A, #160
	MOV P0+0, A
;Drv.c,69 :: 		for(i=0;i<10;i++);
	MOV ScanKbd_i_L0+0, #0
L_ScanKbd28:
	CLR C
	MOV A, ScanKbd_i_L0+0
	SUBB A, #10
	JNC L_ScanKbd29
	INC ScanKbd_i_L0+0
	SJMP L_ScanKbd28
L_ScanKbd29:
;Drv.c,70 :: 		if (!P1_0_bit) kp = '8';
	JB P1_0_bit+0, L_ScanKbd31
	NOP
	MOV ScanKbd_kp_L0+0, #56
	SJMP L_ScanKbd32
L_ScanKbd31:
;Drv.c,71 :: 		else if (!P1_1_bit) kp = '5';
	JB P1_1_bit+0, L_ScanKbd33
	NOP
	MOV ScanKbd_kp_L0+0, #53
	SJMP L_ScanKbd34
L_ScanKbd33:
;Drv.c,72 :: 		else if (!P1_2_bit) kp = '2';
	JB P1_2_bit+0, L_ScanKbd35
	NOP
	MOV ScanKbd_kp_L0+0, #50
	SJMP L_ScanKbd36
L_ScanKbd35:
;Drv.c,73 :: 		else if (!P1_3_bit) kp = '0';
	JB P1_3_bit+0, L_ScanKbd37
	NOP
	MOV ScanKbd_kp_L0+0, #48
L_ScanKbd37:
L_ScanKbd36:
L_ScanKbd34:
L_ScanKbd32:
;Drv.c,74 :: 		P0 = P0&0x1F|0x60;
	MOV A, P0+0
	ANL A, #31
	MOV R0, A
	ORL A, #96
	MOV P0+0, A
;Drv.c,75 :: 		for(i=0;i<10;i++);
	MOV ScanKbd_i_L0+0, #0
L_ScanKbd38:
	CLR C
	MOV A, ScanKbd_i_L0+0
	SUBB A, #10
	JNC L_ScanKbd39
	INC ScanKbd_i_L0+0
	SJMP L_ScanKbd38
L_ScanKbd39:
;Drv.c,76 :: 		if (!P1_0_bit) kp = '9';
	JB P1_0_bit+0, L_ScanKbd41
	NOP
	MOV ScanKbd_kp_L0+0, #57
	SJMP L_ScanKbd42
L_ScanKbd41:
;Drv.c,77 :: 		else if (!P1_1_bit) kp = '6';
	JB P1_1_bit+0, L_ScanKbd43
	NOP
	MOV ScanKbd_kp_L0+0, #54
	SJMP L_ScanKbd44
L_ScanKbd43:
;Drv.c,78 :: 		else if (!P1_2_bit) kp = '3';
	JB P1_2_bit+0, L_ScanKbd45
	NOP
	MOV ScanKbd_kp_L0+0, #51
	SJMP L_ScanKbd46
L_ScanKbd45:
;Drv.c,79 :: 		else if (!P1_3_bit) kp = 'e';
	JB P1_3_bit+0, L_ScanKbd47
	NOP
	MOV ScanKbd_kp_L0+0, #101
L_ScanKbd47:
L_ScanKbd46:
L_ScanKbd44:
L_ScanKbd42:
;Drv.c,80 :: 		return kp;
	MOV R0, ScanKbd_kp_L0+0
;Drv.c,81 :: 		}
	RET
; end of _ScanKbd

_translate:
;Drv.c,84 :: 		unsigned char translate(unsigned char c){
;Drv.c,85 :: 		switch (c){
	SJMP L_translate48
;Drv.c,93 :: 		case '?': return 0xA3;
L_translate50:
	MOV R0, #163
	RET
;Drv.c,94 :: 		case '?': return 0xA4;
L_translate51:
	MOV R0, #164
	RET
;Drv.c,97 :: 		case '?': return 'K';
L_translate52:
	MOV R0, #75
	RET
;Drv.c,126 :: 		case '?': return 0xB6;
L_translate53:
	MOV R0, #182
	RET
;Drv.c,127 :: 		case '?': return 0xB7;
L_translate54:
	MOV R0, #183
	RET
;Drv.c,136 :: 		case '?': return 'p';
L_translate55:
	MOV R0, #112
	RET
;Drv.c,137 :: 		case '?': return 'c';
L_translate56:
	MOV R0, #99
	RET
;Drv.c,152 :: 		default: return c;
L_translate57:
	MOV R0, FARG_translate_c+0
	RET
;Drv.c,153 :: 		}
L_translate48:
	MOV A, FARG_translate_c+0
	XRL A, #63
	JZ L_translate50
	MOV A, FARG_translate_c+0
	XRL A, #63
	JZ L_translate51
	MOV A, FARG_translate_c+0
	XRL A, #63
	JZ L_translate52
	MOV A, FARG_translate_c+0
	XRL A, #63
	JZ L_translate53
	MOV A, FARG_translate_c+0
	XRL A, #63
	JZ L_translate54
	MOV A, FARG_translate_c+0
	XRL A, #63
	JZ L_translate55
	MOV A, FARG_translate_c+0
	XRL A, #63
	JZ L_translate56
	SJMP L_translate57
;Drv.c,154 :: 		}
	RET
; end of _translate

_wr_EEPROM:
;Drv.c,156 :: 		void wr_EEPROM(unsigned int addr,unsigned char eedata)
;Drv.c,159 :: 		DP0L=addr;  //addr1.byte_.l_byte;
	MOV DP0L+0, FARG_wr_EEPROM_addr+0
;Drv.c,160 :: 		DP0H=addr>>8;
	MOV R0, FARG_wr_EEPROM_addr+1
	MOV R1, #0
	MOV DP0H+0, 0
;Drv.c,161 :: 		WMCON|=0x10;
	ORL WMCON+0, #16
;Drv.c,162 :: 		ACC = eedata;
	MOV 224, FARG_wr_EEPROM_eedata+0
;Drv.c,163 :: 		asm  movx @DPTR,A;
	MOVX @DPTR, A
;Drv.c,164 :: 		WMCON&=0xef;
	ANL WMCON+0, #239
;Drv.c,165 :: 		}
	RET
; end of _wr_EEPROM

_rd_EEPROM:
;Drv.c,167 :: 		unsigned char rd_EEPROM(unsigned int addr)
;Drv.c,169 :: 		while(!(WMCON&2));
L_rd_EEPROM58:
	MOV A, WMCON+0
	ANL A, #2
	JNZ L_rd_EEPROM59
	SJMP L_rd_EEPROM58
L_rd_EEPROM59:
;Drv.c,170 :: 		DP0L=addr;
	MOV DP0L+0, FARG_rd_EEPROM_addr+0
;Drv.c,171 :: 		DP0H=addr>>8;
	MOV R0, FARG_rd_EEPROM_addr+1
	MOV R1, #0
	MOV DP0H+0, 0
;Drv.c,172 :: 		asm movx A,@DPTR;
	MOVX A, @DPTR
;Drv.c,173 :: 		return ACC;
	MOV R0, 224
;Drv.c,174 :: 		}
	RET
; end of _rd_EEPROM

_clear_lcd:
;Drv.c,176 :: 		void clear_lcd(void){
;Drv.c,178 :: 		outcw(0x80);
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
;Drv.c,179 :: 		for(i=0;i<16;i++)
	MOV clear_lcd_i_L0+0, #0
L_clear_lcd60:
	CLR C
	MOV A, clear_lcd_i_L0+0
	SUBB A, #16
	JNC L_clear_lcd61
;Drv.c,180 :: 		outd(' ');
	MOV FARG_outd_c+0, #32
	LCALL _outd+0
;Drv.c,179 :: 		for(i=0;i<16;i++)
	INC clear_lcd_i_L0+0
;Drv.c,180 :: 		outd(' ');
	SJMP L_clear_lcd60
L_clear_lcd61:
;Drv.c,181 :: 		}
	RET
; end of _clear_lcd

_outcw:
;Drv.c,183 :: 		void outcw(unsigned char c){
;Drv.c,186 :: 		RS = 0;
	CLR C
	MOV A, P3_6_bit+0
	MOV #224, C
	MOV P3_6_bit+0, A
;Drv.c,187 :: 		DB = c;
	MOV P2+0, FARG_outcw_c+0
;Drv.c,188 :: 		E = 1;
	SETB C
	MOV A, P3_7_bit+0
	MOV #224, C
	MOV P3_7_bit+0, A
;Drv.c,189 :: 		E = 2;
	CLR C
	MOV A, P3_7_bit+0
	MOV #224, C
	MOV P3_7_bit+0, A
;Drv.c,190 :: 		for (i=0; i<20; i++);
	MOV outcw_i_L0+0, #0
L_outcw63:
	CLR C
	MOV A, outcw_i_L0+0
	SUBB A, #20
	JNC L_outcw64
	INC outcw_i_L0+0
	SJMP L_outcw63
L_outcw64:
;Drv.c,191 :: 		if (c==1||c==2||c==3)
	MOV A, FARG_outcw_c+0
	XRL A, #1
	JZ L__outcw75
	MOV A, FARG_outcw_c+0
	XRL A, #2
	JZ L__outcw75
	MOV A, FARG_outcw_c+0
	XRL A, #3
	JZ L__outcw75
	SJMP L_outcw68
L__outcw75:
;Drv.c,192 :: 		for (j=0; j<500; j++);
	MOV outcw_j_L0+0, #0
	MOV outcw_j_L0+1, #0
L_outcw69:
	CLR C
	MOV A, outcw_j_L0+0
	SUBB A, #244
	MOV A, outcw_j_L0+1
	SUBB A, #1
	JNC L_outcw70
	MOV A, #1
	ADD A, outcw_j_L0+0
	MOV outcw_j_L0+0, A
	MOV A, #0
	ADDC A, outcw_j_L0+1
	MOV outcw_j_L0+1, A
	SJMP L_outcw69
L_outcw70:
L_outcw68:
;Drv.c,193 :: 		}
	RET
; end of _outcw

_outd:
;Drv.c,195 :: 		void outd(unsigned char c){
;Drv.c,197 :: 		c=translate(c);
	MOV FARG_translate_c+0, FARG_outd_c+0
	LCALL _translate+0
	MOV FARG_outd_c+0, 0
;Drv.c,198 :: 		RS = 1;
	SETB C
	MOV A, P3_6_bit+0
	MOV #224, C
	MOV P3_6_bit+0, A
;Drv.c,199 :: 		DB = c;
	MOV P2+0, 0
;Drv.c,200 :: 		E = 1;
	SETB C
	MOV A, P3_7_bit+0
	MOV #224, C
	MOV P3_7_bit+0, A
;Drv.c,201 :: 		E = 2;
	CLR C
	MOV A, P3_7_bit+0
	MOV #224, C
	MOV P3_7_bit+0, A
;Drv.c,202 :: 		for (i=0; i<21; i++);
	MOV outd_i_L0+0, #0
L_outd72:
	CLR C
	MOV A, outd_i_L0+0
	SUBB A, #21
	JNC L_outd73
	INC outd_i_L0+0
	SJMP L_outd72
L_outd73:
;Drv.c,203 :: 		}
	RET
; end of _outd
