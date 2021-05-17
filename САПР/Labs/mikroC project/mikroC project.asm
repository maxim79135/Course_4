
_DelayMs:
;mikroC project.c,32 :: 		void DelayMs(unsigned int m){  // ???????? ?????? ??????
;mikroC project.c,34 :: 		for(ms=0;ms!=m;ms++) {
	MOV _ms+0, #0
	MOV _ms+1, #0
L_DelayMs0:
	MOV A, _ms+0
	XRL A, FARG_DelayMs_m+0
	JNZ L__DelayMs54
	MOV A, _ms+1
	XRL A, FARG_DelayMs_m+1
L__DelayMs54:
	JZ L_DelayMs1
;mikroC project.c,35 :: 		Delay_us(250); Delay_us(250);
	MOV R7, 103
	DJNZ R7, 
	NOP
	MOV R7, 103
	DJNZ R7, 
	NOP
;mikroC project.c,36 :: 		Delay_us(250); Delay_us(250); // ?????? ???? 1??
	MOV R7, 103
	DJNZ R7, 
	NOP
	MOV R7, 103
	DJNZ R7, 
	NOP
;mikroC project.c,34 :: 		for(ms=0;ms!=m;ms++) {
	MOV A, #1
	ADD A, _ms+0
	MOV _ms+0, A
	MOV A, #0
	ADDC A, _ms+1
	MOV _ms+1, A
;mikroC project.c,38 :: 		}
	SJMP L_DelayMs0
L_DelayMs1:
;mikroC project.c,39 :: 		}
	RET
; end of _DelayMs

_show_string:
;mikroC project.c,41 :: 		void show_string()
;mikroC project.c,44 :: 		for (i = 0; i < 32; i++)
	MOV show_string_i_L0+0, #0
	MOV show_string_i_L0+1, #0
L_show_string3:
	CLR C
	MOV A, show_string_i_L0+0
	SUBB A, #32
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, show_string_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_show_string4
;mikroC project.c,45 :: 		outd(buf[i]);
	MOV A, #_buf+0
	ADD A, show_string_i_L0+0
	MOV R0, A
	MOV FARG_outd_c+0, @R0
	LCALL _outd+0
;mikroC project.c,44 :: 		for (i = 0; i < 32; i++)
	MOV A, #1
	ADD A, show_string_i_L0+0
	MOV show_string_i_L0+0, A
	MOV A, #0
	ADDC A, show_string_i_L0+1
	MOV show_string_i_L0+1, A
;mikroC project.c,45 :: 		outd(buf[i]);
	SJMP L_show_string3
L_show_string4:
;mikroC project.c,46 :: 		}
	RET
; end of _show_string

_move_left_string:
;mikroC project.c,49 :: 		void move_left_string()
;mikroC project.c,52 :: 		char tmp = buf[0];
	MOV move_left_string_tmp_L0+0, _buf+0
;mikroC project.c,53 :: 		for (i = 0; i < 31; i++)
	MOV move_left_string_i_L0+0, #0
	MOV move_left_string_i_L0+1, #0
L_move_left_string6:
	CLR C
	MOV A, move_left_string_i_L0+0
	SUBB A, #31
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, move_left_string_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_move_left_string7
;mikroC project.c,54 :: 		buf[i] = buf[i + 1];
	MOV A, #_buf+0
	ADD A, move_left_string_i_L0+0
	MOV R0, A
	MOV A, #1
	ADD A, move_left_string_i_L0+0
	MOV R1, A
	MOV A, #0
	ADDC A, move_left_string_i_L0+1
	MOV R2, A
	MOV A, #_buf+0
	ADD A, R1
	MOV R1, A
	MOV A, @R1
	MOV @R0, A
;mikroC project.c,53 :: 		for (i = 0; i < 31; i++)
	MOV A, #1
	ADD A, move_left_string_i_L0+0
	MOV move_left_string_i_L0+0, A
	MOV A, #0
	ADDC A, move_left_string_i_L0+1
	MOV move_left_string_i_L0+1, A
;mikroC project.c,54 :: 		buf[i] = buf[i + 1];
	SJMP L_move_left_string6
L_move_left_string7:
;mikroC project.c,55 :: 		buf[31] = tmp;
	MOV _buf+31, move_left_string_tmp_L0+0
;mikroC project.c,56 :: 		}
	RET
; end of _move_left_string

_move_right_string:
;mikroC project.c,59 :: 		void move_right_string()
;mikroC project.c,62 :: 		char tmp = buf[31];
	MOV move_right_string_tmp_L0+0, _buf+31
;mikroC project.c,63 :: 		for (i = 31; i > 0; i--)
	MOV move_right_string_i_L0+0, #31
	MOV move_right_string_i_L0+1, #0
L_move_right_string9:
	SETB C
	MOV A, move_right_string_i_L0+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, move_right_string_i_L0+1
	XRL A, #128
	SUBB A, R0
	JC L_move_right_string10
;mikroC project.c,64 :: 		buf[i] = buf[i - 1];
	MOV A, #_buf+0
	ADD A, move_right_string_i_L0+0
	MOV R0, A
	CLR C
	MOV A, move_right_string_i_L0+0
	SUBB A, #1
	MOV R1, A
	MOV A, move_right_string_i_L0+1
	SUBB A, #0
	MOV R2, A
	MOV A, #_buf+0
	ADD A, R1
	MOV R1, A
	MOV A, @R1
	MOV @R0, A
;mikroC project.c,63 :: 		for (i = 31; i > 0; i--)
	CLR C
	MOV A, move_right_string_i_L0+0
	SUBB A, #1
	MOV move_right_string_i_L0+0, A
	MOV A, move_right_string_i_L0+1
	SUBB A, #0
	MOV move_right_string_i_L0+1, A
;mikroC project.c,64 :: 		buf[i] = buf[i - 1];
	SJMP L_move_right_string9
L_move_right_string10:
;mikroC project.c,65 :: 		buf[0] = tmp;
	MOV _buf+0, move_right_string_tmp_L0+0
;mikroC project.c,66 :: 		}
	RET
; end of _move_right_string

_reset_string:
;mikroC project.c,69 :: 		void reset_string()
;mikroC project.c,71 :: 		while (head_pos > 0) {
L_reset_string12:
	SETB C
	MOV A, _head_pos+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, _head_pos+1
	XRL A, #128
	SUBB A, R0
	JC L_reset_string13
;mikroC project.c,72 :: 		move_left_string();
	LCALL _move_left_string+0
;mikroC project.c,73 :: 		head_pos--;
	CLR C
	MOV A, _head_pos+0
	SUBB A, #1
	MOV _head_pos+0, A
	MOV A, _head_pos+1
	SUBB A, #0
	MOV _head_pos+1, A
;mikroC project.c,74 :: 		}
	SJMP L_reset_string12
L_reset_string13:
;mikroC project.c,75 :: 		}
	RET
; end of _reset_string

_len:
;mikroC project.c,76 :: 		int len()
;mikroC project.c,79 :: 		int ret = 0;
	MOV len_ret_L0+0, #0
	MOV len_ret_L0+1, #0
;mikroC project.c,80 :: 		for (i = 0; i < 32; i++)
	MOV len_i_L0+0, #0
	MOV len_i_L0+1, #0
L_len14:
	CLR C
	MOV A, len_i_L0+0
	SUBB A, #32
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, len_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_len15
;mikroC project.c,82 :: 		char tmp = buf[i];
	MOV A, #_buf+0
	ADD A, len_i_L0+0
	MOV R0, A
	MOV 1, @R0
;mikroC project.c,83 :: 		if (tmp == 0x20)
	MOV A, R1
	XRL A, #32
	JNZ L_len17
;mikroC project.c,85 :: 		return ret;
	MOV R0, len_ret_L0+0
	MOV R1, len_ret_L0+1
	RET
;mikroC project.c,86 :: 		}
L_len17:
;mikroC project.c,87 :: 		ret++;
	MOV A, #1
	ADD A, len_ret_L0+0
	MOV len_ret_L0+0, A
	MOV A, #0
	ADDC A, len_ret_L0+1
	MOV len_ret_L0+1, A
;mikroC project.c,80 :: 		for (i = 0; i < 32; i++)
	MOV A, #1
	ADD A, len_i_L0+0
	MOV len_i_L0+0, A
	MOV A, #0
	ADDC A, len_i_L0+1
	MOV len_i_L0+1, A
;mikroC project.c,88 :: 		}
	SJMP L_len14
L_len15:
;mikroC project.c,89 :: 		}
	RET
; end of _len

_clear_string:
;mikroC project.c,91 :: 		void clear_string()
;mikroC project.c,94 :: 		for (i = 0; i < 32; i++)
	MOV clear_string_i_L0+0, #0
	MOV clear_string_i_L0+1, #0
L_clear_string18:
	CLR C
	MOV A, clear_string_i_L0+0
	SUBB A, #32
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, clear_string_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_clear_string19
;mikroC project.c,95 :: 		buf[i] = ' ';
	MOV A, #_buf+0
	ADD A, clear_string_i_L0+0
	MOV R0, A
	MOV @R0, #32
;mikroC project.c,94 :: 		for (i = 0; i < 32; i++)
	MOV A, #1
	ADD A, clear_string_i_L0+0
	MOV clear_string_i_L0+0, A
	MOV A, #0
	ADDC A, clear_string_i_L0+1
	MOV clear_string_i_L0+1, A
;mikroC project.c,95 :: 		buf[i] = ' ';
	SJMP L_clear_string18
L_clear_string19:
;mikroC project.c,96 :: 		}
	RET
; end of _clear_string

_write_string:
;mikroC project.c,98 :: 		void write_string()
;mikroC project.c,101 :: 		for (i = 0; i < 32; i++)
	MOV write_string_i_L0+0, #0
	MOV write_string_i_L0+1, #0
L_write_string21:
	CLR C
	MOV A, write_string_i_L0+0
	SUBB A, #32
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, write_string_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_write_string22
;mikroC project.c,102 :: 		wr_EEPROM(i, buf[i]);
	MOV FARG_wr_EEPROM_addr+0, write_string_i_L0+0
	MOV FARG_wr_EEPROM_addr+1, write_string_i_L0+1
	MOV A, #_buf+0
	ADD A, write_string_i_L0+0
	MOV R0, A
	MOV FARG_wr_EEPROM_eedata+0, @R0
	LCALL _wr_EEPROM+0
;mikroC project.c,101 :: 		for (i = 0; i < 32; i++)
	MOV A, #1
	ADD A, write_string_i_L0+0
	MOV write_string_i_L0+0, A
	MOV A, #0
	ADDC A, write_string_i_L0+1
	MOV write_string_i_L0+1, A
;mikroC project.c,102 :: 		wr_EEPROM(i, buf[i]);
	SJMP L_write_string21
L_write_string22:
;mikroC project.c,103 :: 		}
	RET
; end of _write_string

_read_string:
;mikroC project.c,105 :: 		void read_string()
;mikroC project.c,108 :: 		for (i = 0; i < 32; i++)
	MOV read_string_i_L0+0, #0
	MOV read_string_i_L0+1, #0
L_read_string24:
	CLR C
	MOV A, read_string_i_L0+0
	SUBB A, #32
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, read_string_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_read_string25
;mikroC project.c,109 :: 		buf[i] = rd_EEPROM(i);
	MOV A, #_buf+0
	ADD A, read_string_i_L0+0
	MOV R0, A
	MOV FLOC__read_string+1, 0
	MOV FARG_rd_EEPROM_addr+0, read_string_i_L0+0
	MOV FARG_rd_EEPROM_addr+1, read_string_i_L0+1
	LCALL _rd_EEPROM+0
	MOV FLOC__read_string+0, 0
	MOV R0, FLOC__read_string+1
	MOV @R0, FLOC__read_string+0
;mikroC project.c,108 :: 		for (i = 0; i < 32; i++)
	MOV A, #1
	ADD A, read_string_i_L0+0
	MOV read_string_i_L0+0, A
	MOV A, #0
	ADDC A, read_string_i_L0+1
	MOV read_string_i_L0+1, A
;mikroC project.c,109 :: 		buf[i] = rd_EEPROM(i);
	SJMP L_read_string24
L_read_string25:
;mikroC project.c,110 :: 		}
	RET
; end of _read_string

_Timer1InterruptHandler:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;mikroC project.c,112 :: 		void Timer1InterruptHandler() org IVT_ADDR_ET1
;mikroC project.c,115 :: 		EA_bit = 0;  // Clear global interrupt enable flag
	CLR EA_bit+0
;mikroC project.c,116 :: 		TF1_bit = 0; // Ensure that Timer1 interrupt flag is cleared
	CLR TF1_bit+0
;mikroC project.c,118 :: 		TR1_bit = 0; // Stop Timer1
	CLR TR1_bit+0
;mikroC project.c,119 :: 		TH1 = 0xFC;  // Reset Timer1 high byte  65536-1000
	MOV TH1+0, #252
;mikroC project.c,120 :: 		TL1 = 0x18;  // Reset Timer1 low byte
	MOV TL1+0, #24
;mikroC project.c,123 :: 		ms++;
	MOV A, #1
	ADD A, _ms+0
	MOV _ms+0, A
	MOV A, #0
	ADDC A, _ms+1
	MOV _ms+1, A
;mikroC project.c,125 :: 		EA_bit = 1;  // Set global interrupt enable flag
	SETB EA_bit+0
;mikroC project.c,126 :: 		TR1_bit = 1; // Run Timer1
	SETB TR1_bit+0
;mikroC project.c,127 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer1InterruptHandler

_INT0_Interrupt:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;mikroC project.c,129 :: 		void INT0_Interrupt() org IVT_ADDR_EX0
;mikroC project.c,131 :: 		EA_bit = 0;
	CLR EA_bit+0
;mikroC project.c,132 :: 		lcd_led = ~lcd_led;
	MOV C, P0_4_bit+0
	CPL C
	MOV P0_4_bit+0, C
;mikroC project.c,133 :: 		if (state == S_MOVING)
	MOV A, _state+0
	XRL A, #2
	JNZ L_INT0_Interrupt27
;mikroC project.c,134 :: 		state = S_INIT;
	MOV _state+0, #0
L_INT0_Interrupt27:
;mikroC project.c,135 :: 		EA_bit = 1;
	SETB EA_bit+0
;mikroC project.c,136 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _INT0_Interrupt

_INT1_Interrupt:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;mikroC project.c,138 :: 		void INT1_Interrupt() org IVT_ADDR_EX1
;mikroC project.c,140 :: 		EA_bit = 0;
	CLR EA_bit+0
;mikroC project.c,141 :: 		lcd_led = ~lcd_led;
	MOV C, P0_4_bit+0
	CPL C
	MOV P0_4_bit+0, C
;mikroC project.c,142 :: 		if (state == S_INIT)
	MOV A, _state+0
	JNZ L_INT1_Interrupt28
;mikroC project.c,143 :: 		state = S_CHANGE_SPEED;
	MOV _state+0, #1
L_INT1_Interrupt28:
;mikroC project.c,144 :: 		EA_bit = 1;
	SETB EA_bit+0
;mikroC project.c,145 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _INT1_Interrupt

_main:
	MOV SP+0, #128
;mikroC project.c,147 :: 		void main()
;mikroC project.c,149 :: 		init();
	LCALL _init+0
;mikroC project.c,150 :: 		clear_lcd();
	LCALL _clear_lcd+0
;mikroC project.c,151 :: 		read_string();
	LCALL _read_string+0
;mikroC project.c,152 :: 		speed = rd_EEPROM(32);
	MOV FARG_rd_EEPROM_addr+0, #32
	MOV FARG_rd_EEPROM_addr+1, #0
	LCALL _rd_EEPROM+0
	MOV _speed+0, 0
	CLR A
	MOV _speed+1, A
;mikroC project.c,153 :: 		if (!speed)
	MOV A, _speed+0
	ORL A, _speed+1
	JNZ L_main29
;mikroC project.c,154 :: 		speed = 10;
	MOV _speed+0, #10
	MOV _speed+1, #0
	SJMP L_main30
L_main29:
;mikroC project.c,155 :: 		else if (speed > 100) speed = 100;
	SETB C
	MOV A, _speed+0
	SUBB A, #100
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, _speed+1
	XRL A, #128
	SUBB A, R0
	JC L_main31
	MOV _speed+0, #100
	MOV _speed+1, #0
L_main31:
L_main30:
;mikroC project.c,157 :: 		while (1)
L_main32:
;mikroC project.c,159 :: 		key = ScanKbd();
	LCALL _ScanKbd+0
	MOV _key+0, 0
;mikroC project.c,160 :: 		switch (state)
	LJMP L_main34
;mikroC project.c,162 :: 		case S_INIT:
L_main36:
;mikroC project.c,163 :: 		reset_string();
	LCALL _reset_string+0
;mikroC project.c,164 :: 		clear_lcd();
	LCALL _clear_lcd+0
;mikroC project.c,165 :: 		outcw(0x80);
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
;mikroC project.c,166 :: 		show_string();
	LCALL _show_string+0
;mikroC project.c,167 :: 		if (key == KEY_UP)
	MOV A, _key+0
	XRL A, #101
	JNZ L_main37
;mikroC project.c,169 :: 		write_string();
	LCALL _write_string+0
;mikroC project.c,170 :: 		state = S_MOVING;
	MOV _state+0, #2
;mikroC project.c,171 :: 		}
L_main37:
;mikroC project.c,172 :: 		if (key >= '0' && key <= '9')
	CLR C
	MOV A, _key+0
	SUBB A, #48
	JC L_main40
	SETB C
	MOV A, _key+0
	SUBB A, #57
	JNC L_main40
L__main53:
;mikroC project.c,174 :: 		buf[len()] = key;
	LCALL _len+0
	MOV FLOC__main+0, 0
	MOV FLOC__main+1, 1
	MOV A, #_buf+0
	ADD A, FLOC__main+0
	MOV R0, A
	MOV @R0, _key+0
;mikroC project.c,175 :: 		}
L_main40:
;mikroC project.c,176 :: 		if (key == KEY_DOWN)
	MOV A, _key+0
	XRL A, #35
	JNZ L_main41
;mikroC project.c,177 :: 		clear_string();
	LCALL _clear_string+0
L_main41:
;mikroC project.c,178 :: 		break;
	LJMP L_main35
;mikroC project.c,180 :: 		case S_MOVING:
L_main42:
;mikroC project.c,181 :: 		clear_lcd();
	LCALL _clear_lcd+0
;mikroC project.c,182 :: 		move_right_string();
	LCALL _move_right_string+0
;mikroC project.c,183 :: 		head_pos++;
	MOV A, #1
	ADD A, _head_pos+0
	MOV _head_pos+0, A
	MOV A, #0
	ADDC A, _head_pos+1
	MOV _head_pos+1, A
;mikroC project.c,184 :: 		if (head_pos == 32) head_pos = 0;
	MOV A, #32
	XRL A, _head_pos+0
	JNZ L__main55
	MOV A, #0
	XRL A, _head_pos+1
L__main55:
	JNZ L_main43
	MOV _head_pos+0, #0
	MOV _head_pos+1, #0
L_main43:
;mikroC project.c,185 :: 		outcw(0x80);
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
;mikroC project.c,186 :: 		show_string();
	LCALL _show_string+0
;mikroC project.c,187 :: 		break;
	SJMP L_main35
;mikroC project.c,188 :: 		case S_CHANGE_SPEED:
L_main44:
;mikroC project.c,189 :: 		clear_lcd();
	LCALL _clear_lcd+0
;mikroC project.c,190 :: 		outcw(0x80);
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
;mikroC project.c,191 :: 		if ((key == KEY_UP) && (speed > 10))
	MOV A, _key+0
	XRL A, #101
	JNZ L_main47
	SETB C
	MOV A, _speed+0
	SUBB A, #10
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, _speed+1
	XRL A, #128
	SUBB A, R0
	JC L_main47
L__main52:
;mikroC project.c,193 :: 		speed -= 10;
	CLR C
	MOV A, _speed+0
	SUBB A, #10
	MOV _speed+0, A
	MOV A, _speed+1
	SUBB A, #0
	MOV _speed+1, A
;mikroC project.c,194 :: 		}
L_main47:
;mikroC project.c,195 :: 		if ((key == KEY_DOWN) && (speed < 100))
	MOV A, _key+0
	XRL A, #35
	JNZ L_main50
	CLR C
	MOV A, _speed+0
	SUBB A, #100
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, _speed+1
	XRL A, #128
	SUBB A, R0
	JNC L_main50
L__main51:
;mikroC project.c,197 :: 		speed += 10;
	MOV A, #10
	ADD A, _speed+0
	MOV _speed+0, A
	MOV A, #0
	ADDC A, _speed+1
	MOV _speed+1, A
;mikroC project.c,198 :: 		}
L_main50:
;mikroC project.c,199 :: 		break;
	SJMP L_main35
;mikroC project.c,200 :: 		}
L_main34:
	MOV A, _state+0
	JNZ #3
	LJMP L_main36
	MOV A, _state+0
	XRL A, #2
	JNZ #3
	LJMP L_main42
	MOV A, _state+0
	XRL A, #1
	JZ L_main44
L_main35:
;mikroC project.c,201 :: 		DelayMs(speed * 5);
	MOV R0, _speed+0
	MOV R1, _speed+1
	MOV R4, #5
	MOV R5, #0
	LCALL _Mul_16x16+0
	MOV FARG_DelayMs_m+0, 0
	MOV FARG_DelayMs_m+1, 1
	LCALL _DelayMs+0
;mikroC project.c,202 :: 		}
	LJMP L_main32
;mikroC project.c,203 :: 		}
	SJMP #254
; end of _main
