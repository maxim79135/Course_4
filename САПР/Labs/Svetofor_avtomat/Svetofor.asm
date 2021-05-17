
_main:
	MOV SP+0, #128
;Svetofor.c,26 :: 		void main (void) {
;Svetofor.c,29 :: 		init();
	LCALL _init+0
;Svetofor.c,30 :: 		RED = 0;      // Красный цвет
	CLR P0_0_bit+0
;Svetofor.c,31 :: 		YEL = 1;      // Желтый цвет
	SETB P0_1_bit+0
;Svetofor.c,32 :: 		GRN = 1;      // Зеленый цвет
	SETB P0_2_bit+0
;Svetofor.c,33 :: 		lcd_led = 0;  // Подсветка индикатора
	CLR P0_4_bit+0
;Svetofor.c,34 :: 		tr=rd_EEPROM(0); if((tr>30)||(tr<5)) tr=5;
	MOV FARG_rd_EEPROM_addr+0, #0
	MOV FARG_rd_EEPROM_addr+1, #0
	LCALL _rd_EEPROM+0
	MOV _tr+0, 0
	SETB C
	MOV A, R0
	SUBB A, #30
	JNC L__main49
	CLR C
	MOV A, _tr+0
	SUBB A, #5
	JC L__main49
	SJMP L_main2
L__main49:
	MOV _tr+0, #5
L_main2:
;Svetofor.c,35 :: 		tg=rd_EEPROM(1); if((tg>30)||(tg<5)) tg=5;
	MOV FARG_rd_EEPROM_addr+0, #1
	MOV FARG_rd_EEPROM_addr+1, #0
	LCALL _rd_EEPROM+0
	MOV _tg+0, 0
	SETB C
	MOV A, R0
	SUBB A, #30
	JNC L__main48
	CLR C
	MOV A, _tg+0
	SUBB A, #5
	JC L__main48
	SJMP L_main5
L__main48:
	MOV _tg+0, #5
L_main5:
;Svetofor.c,36 :: 		t = 10*tr;
	MOV B+0, _tr+0
	MOV A, #10
	MUL AB
	MOV R0, A
	MOV _t+0, 0
;Svetofor.c,51 :: 		while (1) {
L_main6:
;Svetofor.c,52 :: 		key=ScanKbd();
	LCALL _ScanKbd+0
	MOV _key+0, 0
;Svetofor.c,53 :: 		switch (state) {
	LJMP L_main8
;Svetofor.c,54 :: 		case R: // Красный
L_main10:
;Svetofor.c,56 :: 		clear_lcd(); outcw(0x80); outd('К'); //outd('р'); outd('а');
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	MOV FARG_outd_c+0, #202
	LCALL _outd+0
;Svetofor.c,58 :: 		if (T_FLAG) { state=RY;  T_FLAG = 0;  t=20;  YEL=0; }
	MOV A, _T_FLAG+0
	JZ L_main11
	MOV _state+0, #2
	MOV _T_FLAG+0, #0
	MOV _t+0, #20
	CLR P0_1_bit+0
	SJMP L_main12
L_main11:
;Svetofor.c,59 :: 		else if (key == '8') { state=SR;  RED=1; }
	MOV A, _key+0
	XRL A, #56
	JNZ L_main13
	MOV _state+0, #6
	SETB P0_0_bit+0
L_main13:
L_main12:
;Svetofor.c,60 :: 		break;
	LJMP L_main9
;Svetofor.c,61 :: 		case RY: // Красный-желтый
L_main14:
;Svetofor.c,63 :: 		clear_lcd(); outcw(0x80); outd('К'); outd('р'); outd('.'); outd('-');
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	MOV FARG_outd_c+0, #202
	LCALL _outd+0
	MOV FARG_outd_c+0, #240
	LCALL _outd+0
	MOV FARG_outd_c+0, #46
	LCALL _outd+0
	MOV FARG_outd_c+0, #45
	LCALL _outd+0
;Svetofor.c,64 :: 		outd('ж'); outd('.'); //outd('е'); outd('л'); outd('т'); outd('ы'); outd('й');
	MOV FARG_outd_c+0, #230
	LCALL _outd+0
	MOV FARG_outd_c+0, #46
	LCALL _outd+0
;Svetofor.c,65 :: 		if (T_FLAG) { state=G;  T_FLAG = 0;  t=10*tg;  RED=1; YEL=1; GRN=0; }
	MOV A, _T_FLAG+0
	JZ L_main15
	MOV _state+0, #3
	MOV _T_FLAG+0, #0
	MOV B+0, _tg+0
	MOV A, #10
	MUL AB
	MOV R0, A
	MOV _t+0, 0
	SETB P0_0_bit+0
	SETB P0_1_bit+0
	CLR P0_2_bit+0
	SJMP L_main16
L_main15:
;Svetofor.c,66 :: 		else if (key == '8') { state=SR;  RED=1; YEL=1; }
	MOV A, _key+0
	XRL A, #56
	JNZ L_main17
	MOV _state+0, #6
	SETB P0_0_bit+0
	SETB P0_1_bit+0
L_main17:
L_main16:
;Svetofor.c,67 :: 		break;
	LJMP L_main9
;Svetofor.c,68 :: 		case G: // Зеленый
L_main18:
;Svetofor.c,70 :: 		clear_lcd(); outcw(0x80); outd('З'); //outd('е'); outd('л');
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	MOV FARG_outd_c+0, #199
	LCALL _outd+0
;Svetofor.c,72 :: 		if (T_FLAG) { state=GG;  T_FLAG = 0;  t=3; }
	MOV A, _T_FLAG+0
	JZ L_main19
	MOV _state+0, #4
	MOV _T_FLAG+0, #0
	MOV _t+0, #3
	SJMP L_main20
L_main19:
;Svetofor.c,73 :: 		else if (key == '8') { state=SR;  GRN=1; }
	MOV A, _key+0
	XRL A, #56
	JNZ L_main21
	MOV _state+0, #6
	SETB P0_2_bit+0
L_main21:
L_main20:
;Svetofor.c,74 :: 		break;
	LJMP L_main9
;Svetofor.c,75 :: 		case GG: // Мигающий зеленый
L_main22:
;Svetofor.c,76 :: 		GRN=0; DelayMs(500);
	CLR P0_2_bit+0
	MOV FARG_DelayMs_m+0, #244
	MOV FARG_DelayMs_m+1, #1
	LCALL _DelayMs+0
;Svetofor.c,77 :: 		GRN=1; DelayMs(400);
	SETB P0_2_bit+0
	MOV FARG_DelayMs_m+0, #144
	MOV FARG_DelayMs_m+1, #1
	LCALL _DelayMs+0
;Svetofor.c,78 :: 		if (T_FLAG) { state=Y;  T_FLAG = 0;  t=20;  YEL=0; }
	MOV A, _T_FLAG+0
	JZ L_main23
	MOV _state+0, #5
	MOV _T_FLAG+0, #0
	MOV _t+0, #20
	CLR P0_1_bit+0
L_main23:
;Svetofor.c,79 :: 		break;
	LJMP L_main9
;Svetofor.c,80 :: 		case Y: // Желтый
L_main24:
;Svetofor.c,82 :: 		clear_lcd(); outcw(0x80); outd('Ж'); //outd('е'); outd('л');
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	MOV FARG_outd_c+0, #198
	LCALL _outd+0
;Svetofor.c,84 :: 		if (T_FLAG) { state=R;  T_FLAG = 0;  t=10*tr; YEL=1; RED=0; }
	MOV A, _T_FLAG+0
	JZ L_main25
	MOV _state+0, #1
	MOV _T_FLAG+0, #0
	MOV B+0, _tr+0
	MOV A, #10
	MUL AB
	MOV R0, A
	MOV _t+0, 0
	SETB P0_1_bit+0
	CLR P0_0_bit+0
	SJMP L_main26
L_main25:
;Svetofor.c,85 :: 		else if (key == '8') { state=SR;  YEL=1; }
	MOV A, _key+0
	XRL A, #56
	JNZ L_main27
	MOV _state+0, #6
	SETB P0_1_bit+0
L_main27:
L_main26:
;Svetofor.c,86 :: 		break;
	LJMP L_main9
;Svetofor.c,87 :: 		case SR: // Настройка времени красного сигнала
L_main28:
;Svetofor.c,89 :: 		clear_lcd(); outcw(0x80); outd('t'); outd('к'); outd('=');
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	MOV FARG_outd_c+0, #116
	LCALL _outd+0
	MOV FARG_outd_c+0, #234
	LCALL _outd+0
	MOV FARG_outd_c+0, #61
	LCALL _outd+0
;Svetofor.c,90 :: 		outd(tr/10+48); outd(tr%10+48); outd('c');
	MOV B+0, #10
	MOV A, _tr+0
	DIV AB
	MOV R0, A
	ADD A, #48
	MOV FARG_outd_c+0, A
	LCALL _outd+0
	MOV B+0, #10
	MOV A, _tr+0
	DIV AB
	MOV A, B+0
	MOV R0, A
	ADD A, #48
	MOV FARG_outd_c+0, A
	LCALL _outd+0
	MOV FARG_outd_c+0, #99
	LCALL _outd+0
;Svetofor.c,91 :: 		switch(key) {
	SJMP L_main29
;Svetofor.c,92 :: 		case '7': if (tr>5) tr--; break;
L_main31:
	SETB C
	MOV A, _tr+0
	SUBB A, #5
	JC L_main32
	DEC _tr+0
L_main32:
	SJMP L_main30
;Svetofor.c,93 :: 		case '9': if (tr<30) tr++; break;
L_main33:
	CLR C
	MOV A, _tr+0
	SUBB A, #30
	JNC L_main34
	INC _tr+0
L_main34:
	SJMP L_main30
;Svetofor.c,94 :: 		case '8': wr_EEPROM(0,tr); state=SG; break;
L_main35:
	MOV FARG_wr_EEPROM_addr+0, #0
	MOV FARG_wr_EEPROM_addr+1, #0
	MOV FARG_wr_EEPROM_eedata+0, _tr+0
	LCALL _wr_EEPROM+0
	MOV _state+0, #7
	SJMP L_main30
;Svetofor.c,95 :: 		}
L_main29:
	MOV A, _key+0
	XRL A, #55
	JZ L_main31
	MOV A, _key+0
	XRL A, #57
	JZ L_main33
	MOV A, _key+0
	XRL A, #56
	JZ L_main35
L_main30:
;Svetofor.c,96 :: 		break;
	LJMP L_main9
;Svetofor.c,97 :: 		case SG: // Настройка времени зеленого сигнала
L_main36:
;Svetofor.c,99 :: 		clear_lcd(); outcw(0x80); outd('t'); outd('з'); outd('=');
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	MOV FARG_outd_c+0, #116
	LCALL _outd+0
	MOV FARG_outd_c+0, #231
	LCALL _outd+0
	MOV FARG_outd_c+0, #61
	LCALL _outd+0
;Svetofor.c,100 :: 		outd(tg/10+48); outd(tg%10+48); outd('c');
	MOV B+0, #10
	MOV A, _tg+0
	DIV AB
	MOV R0, A
	ADD A, #48
	MOV FARG_outd_c+0, A
	LCALL _outd+0
	MOV B+0, #10
	MOV A, _tg+0
	DIV AB
	MOV A, B+0
	MOV R0, A
	ADD A, #48
	MOV FARG_outd_c+0, A
	LCALL _outd+0
	MOV FARG_outd_c+0, #99
	LCALL _outd+0
;Svetofor.c,101 :: 		switch(key) {
	SJMP L_main37
;Svetofor.c,102 :: 		case '7': if (tg>5) tg--; break;
L_main39:
	SETB C
	MOV A, _tg+0
	SUBB A, #5
	JC L_main40
	DEC _tg+0
L_main40:
	SJMP L_main38
;Svetofor.c,103 :: 		case '9': if (tg<30) tg++; break;
L_main41:
	CLR C
	MOV A, _tg+0
	SUBB A, #30
	JNC L_main42
	INC _tg+0
L_main42:
	SJMP L_main38
;Svetofor.c,104 :: 		case '8': wr_EEPROM(1,tg); state=R; T_FLAG = 0; t=10*tr; RED=0; break;
L_main43:
	MOV FARG_wr_EEPROM_addr+0, #1
	MOV FARG_wr_EEPROM_addr+1, #0
	MOV FARG_wr_EEPROM_eedata+0, _tg+0
	LCALL _wr_EEPROM+0
	MOV _state+0, #1
	MOV _T_FLAG+0, #0
	MOV B+0, _tr+0
	MOV A, #10
	MUL AB
	MOV R0, A
	MOV _t+0, 0
	CLR P0_0_bit+0
	SJMP L_main38
;Svetofor.c,105 :: 		}
L_main37:
	MOV A, _key+0
	XRL A, #55
	JZ L_main39
	MOV A, _key+0
	XRL A, #57
	JZ L_main41
	MOV A, _key+0
	XRL A, #56
	JZ L_main43
L_main38:
;Svetofor.c,106 :: 		break;
	SJMP L_main9
;Svetofor.c,107 :: 		}
L_main8:
	MOV A, _state+0
	XRL A, #1
	JNZ #3
	LJMP L_main10
	MOV A, _state+0
	XRL A, #2
	JNZ #3
	LJMP L_main14
	MOV A, _state+0
	XRL A, #3
	JNZ #3
	LJMP L_main18
	MOV A, _state+0
	XRL A, #4
	JNZ #3
	LJMP L_main22
	MOV A, _state+0
	XRL A, #5
	JNZ #3
	LJMP L_main24
	MOV A, _state+0
	XRL A, #6
	JNZ #3
	LJMP L_main28
	MOV A, _state+0
	XRL A, #7
	JNZ #3
	LJMP L_main36
L_main9:
;Svetofor.c,108 :: 		DelayMs(100);            // такт работы автомата
	MOV FARG_DelayMs_m+0, #100
	MOV FARG_DelayMs_m+1, #0
	LCALL _DelayMs+0
;Svetofor.c,109 :: 		if(t==0) T_FLAG=1; else t--;  // счетчик
	MOV A, _t+0
	JNZ L_main44
	MOV _T_FLAG+0, #1
	SJMP L_main45
L_main44:
	DEC _t+0
L_main45:
;Svetofor.c,110 :: 		}
	LJMP L_main6
;Svetofor.c,111 :: 		}
	SJMP #254
; end of _main

_DelayMs:
;Svetofor.c,125 :: 		void DelayMs(unsigned int m){  // задержка по таймеру
;Svetofor.c,128 :: 		ms=0;
	MOV _ms+0, #0
	MOV _ms+1, #0
;Svetofor.c,129 :: 		WMCON.WDTRST=1; // сброс сторожевого таймера
	SETB C
	MOV A, WMCON+0
	MOV #224, C
	MOV WMCON+0, A
;Svetofor.c,130 :: 		while(ms!=m) continue;
L_DelayMs46:
	MOV A, _ms+0
	XRL A, FARG_DelayMs_m+0
	JNZ L__DelayMs50
	MOV A, _ms+1
	XRL A, FARG_DelayMs_m+1
L__DelayMs50:
	JZ L_DelayMs47
	SJMP L_DelayMs46
L_DelayMs47:
;Svetofor.c,131 :: 		}
	RET
; end of _DelayMs

_Timer1InterruptHandler:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;Svetofor.c,133 :: 		void Timer1InterruptHandler() org IVT_ADDR_ET1{
;Svetofor.c,135 :: 		EA_bit = 0;        // Clear global interrupt enable flag
	CLR EA_bit+0
;Svetofor.c,136 :: 		TF1_bit = 0;       // Ensure that Timer1 interrupt flag is cleared
	CLR TF1_bit+0
;Svetofor.c,138 :: 		TR1_bit = 0;       // Stop Timer1
	CLR TR1_bit+0
;Svetofor.c,139 :: 		TH1 = 0xFC;        // Reset Timer1 high byte  65536-1000
	MOV TH1+0, #252
;Svetofor.c,140 :: 		TL1 = 0x18;        // Reset Timer1 low byte
	MOV TL1+0, #24
;Svetofor.c,143 :: 		ms++;
	MOV A, #1
	ADD A, _ms+0
	MOV _ms+0, A
	MOV A, #0
	ADDC A, _ms+1
	MOV _ms+1, A
;Svetofor.c,145 :: 		EA_bit = 1;        // Set global interrupt enable flag
	SETB EA_bit+0
;Svetofor.c,146 :: 		TR1_bit = 1;       // Run Timer1
	SETB TR1_bit+0
;Svetofor.c,147 :: 		}
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
;Svetofor.c,149 :: 		void INT0_Interrupt() org IVT_ADDR_EX0 {
;Svetofor.c,150 :: 		EA_bit = 0;
	CLR EA_bit+0
;Svetofor.c,151 :: 		lcd_led=~lcd_led;
	MOV C, P0_4_bit+0
	CPL C
	MOV P0_4_bit+0, C
;Svetofor.c,152 :: 		EA_bit = 1;
	SETB EA_bit+0
;Svetofor.c,153 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _INT0_Interrupt
