
_wire1_ready:
;Temperature.c,5 :: 		unsigned char wire1_ready(void)
;Temperature.c,9 :: 		WIRE1_PIN = 0;
	CLR P1_4_bit+0
;Temperature.c,10 :: 		Delay_us(250); Delay_us(250);
	MOV R7, 103
	DJNZ R7, 
	NOP
	MOV R7, 103
	DJNZ R7, 
	NOP
;Temperature.c,11 :: 		WIRE1_PIN = 1;
	SETB P1_4_bit+0
;Temperature.c,12 :: 		while (WIRE1_PIN !=1) {               //ждем установки шины в 1 после сброса
L_wire1_ready0:
	JB P1_4_bit+0, L_wire1_ready1
	NOP
;Temperature.c,13 :: 		if (count > 9) {return 0;}        //если ждем слишком долго (>100мкс) - значит
	SETB C
	MOV A, wire1_ready_count_L0+0
	SUBB A, #9
	JC L_wire1_ready2
	MOV R0, #0
	RET
L_wire1_ready2:
;Temperature.c,14 :: 		count++;                        //кто-то подгружает линию - ошибка
	INC wire1_ready_count_L0+0
;Temperature.c,15 :: 		Delay_us(8);
	MOV R7, 3
	DJNZ R7, 
;Temperature.c,16 :: 		}
	SJMP L_wire1_ready0
L_wire1_ready1:
;Temperature.c,17 :: 		Delay_us(16);
	MOV R7, 6
	DJNZ R7, 
;Temperature.c,18 :: 		count = 0;
	MOV wire1_ready_count_L0+0, #0
;Temperature.c,19 :: 		while (WIRE1_PIN !=0) {                //ждем установки шины в 1 после сброса
L_wire1_ready3:
	JNB P1_4_bit+0, L_wire1_ready4
	NOP
;Temperature.c,20 :: 		if (count > 29) {return 0;}        //если ждем 0 слишком долго (>300 мкс) - значит
	SETB C
	MOV A, wire1_ready_count_L0+0
	SUBB A, #29
	JC L_wire1_ready5
	MOV R0, #0
	RET
L_wire1_ready5:
;Temperature.c,21 :: 		count++;                           //никто не отвечает - ошибка
	INC wire1_ready_count_L0+0
;Temperature.c,22 :: 		Delay_us(8);
	MOV R7, 3
	DJNZ R7, 
;Temperature.c,23 :: 		}
	SJMP L_wire1_ready3
L_wire1_ready4:
;Temperature.c,24 :: 		Delay_us(205); Delay_us(205);
	MOV R7, 85
	DJNZ R7, 
	MOV R7, 85
	DJNZ R7, 
;Temperature.c,25 :: 		WIRE1_PIN = 1;
	SETB P1_4_bit+0
;Temperature.c,26 :: 		return 1;                                                        //если все впорядке возвращаем 1
	MOV R0, #1
;Temperature.c,27 :: 		}
	RET
; end of _wire1_ready

_wire1_write_byte:
;Temperature.c,32 :: 		void wire1_write_byte(unsigned char c)
;Temperature.c,37 :: 		WIRE1_PIN = 1;
	SETB P1_4_bit+0
;Temperature.c,38 :: 		EA_bit = 0; //отключить прерывания
	CLR EA_bit+0
;Temperature.c,39 :: 		for (cnt = 0; cnt<8; cnt++) {
	MOV wire1_write_byte_cnt_L0+0, #0
L_wire1_write_byte6:
	CLR C
	MOV A, wire1_write_byte_cnt_L0+0
	SUBB A, #8
	JNC L_wire1_write_byte7
;Temperature.c,40 :: 		tmp_c = c & 0b00000001;
	MOV A, FARG_wire1_write_byte_c+0
	ANL A, #1
	MOV R1, A
;Temperature.c,41 :: 		if(tmp_c == 1) {   //бит запихнуть в шину на 60 мкс
	MOV A, R1
	XRL A, #1
	JNZ L_wire1_write_byte9
;Temperature.c,42 :: 		WIRE1_PIN = 0;  //импульс синхронизации (0 на 6 мкс)
	CLR P1_4_bit+0
;Temperature.c,43 :: 		Delay_us(2);    //2 вместо 6 из-за завала фронта
	NOP
	NOP
;Temperature.c,44 :: 		WIRE1_PIN = 1;
	SETB P1_4_bit+0
;Temperature.c,45 :: 		Delay_us(6);
	MOV R7, 2
	DJNZ R7, 
;Temperature.c,46 :: 		}
	SJMP L_wire1_write_byte10
L_wire1_write_byte9:
;Temperature.c,48 :: 		WIRE1_PIN = 0; // (0 на 60 мкс)
	CLR P1_4_bit+0
;Temperature.c,49 :: 		Delay_us(60);
	MOV R7, 24
	DJNZ R7, 
	NOP
;Temperature.c,50 :: 		WIRE1_PIN = 1; // (1 на 10 мкс)
	SETB P1_4_bit+0
;Temperature.c,51 :: 		Delay_us(10);
	MOV R7, 3
	DJNZ R7, 
	NOP
;Temperature.c,52 :: 		}
L_wire1_write_byte10:
;Temperature.c,53 :: 		c = c>>1;
	MOV R0, #1
	MOV A, FARG_wire1_write_byte_c+0
	INC R0
	SJMP L__wire1_write_byte22
L__wire1_write_byte23:
	CLR C
	RRC A
L__wire1_write_byte22:
	DJNZ R0, L__wire1_write_byte23
	MOV FARG_wire1_write_byte_c+0, A
;Temperature.c,39 :: 		for (cnt = 0; cnt<8; cnt++) {
	INC wire1_write_byte_cnt_L0+0
;Temperature.c,54 :: 		}
	SJMP L_wire1_write_byte6
L_wire1_write_byte7:
;Temperature.c,55 :: 		EA_bit = 1; //включить прерывания
	SETB EA_bit+0
;Temperature.c,56 :: 		}
	RET
; end of _wire1_write_byte

_wire1_read_byte:
;Temperature.c,58 :: 		unsigned char wire1_read_byte(void)
;Temperature.c,60 :: 		unsigned char c=0,d=0,cnt=0;
	MOV wire1_read_byte_c_L0+0, #0
	MOV wire1_read_byte_cnt_L0+0, #0
;Temperature.c,61 :: 		WIRE1_PIN = 1;
	SETB P1_4_bit+0
;Temperature.c,62 :: 		for (cnt = 0; cnt<8; cnt++) {
	MOV wire1_read_byte_cnt_L0+0, #0
L_wire1_read_byte11:
	CLR C
	MOV A, wire1_read_byte_cnt_L0+0
	SUBB A, #8
	JNC L_wire1_read_byte12
;Temperature.c,63 :: 		WIRE1_PIN = 0;            //импульс синхронизации (0 на 6 мкс)
	CLR P1_4_bit+0
;Temperature.c,64 :: 		Delay_us(2);  // 2 вместо 6 из-за завала фронта
	NOP
	NOP
;Temperature.c,65 :: 		WIRE1_PIN = 1;
	SETB P1_4_bit+0
;Temperature.c,66 :: 		Delay_us(9);  // задержка на 9 мкс
	MOV R7, 3
	DJNZ R7, 
	NOP
;Temperature.c,67 :: 		c = c>>1;
	MOV R0, #1
	MOV A, wire1_read_byte_c_L0+0
	INC R0
	SJMP L__wire1_read_byte24
L__wire1_read_byte25:
	CLR C
	RRC A
L__wire1_read_byte24:
	DJNZ R0, L__wire1_read_byte25
	MOV wire1_read_byte_c_L0+0, A
;Temperature.c,68 :: 		if (WIRE1_PIN == 1) {c = c | 0b10000000;}  //бит запихнуть из шины в байт с
	JNB P1_4_bit+0, L_wire1_read_byte14
	NOP
	ORL wire1_read_byte_c_L0+0, #128
L_wire1_read_byte14:
;Temperature.c,69 :: 		Delay_us (55);  // //ждем пока прибор освободит линию
	MOV R7, 22
	DJNZ R7, 
	NOP
;Temperature.c,62 :: 		for (cnt = 0; cnt<8; cnt++) {
	INC wire1_read_byte_cnt_L0+0
;Temperature.c,70 :: 		}
	SJMP L_wire1_read_byte11
L_wire1_read_byte12:
;Temperature.c,71 :: 		return c;
	MOV R0, wire1_read_byte_c_L0+0
;Temperature.c,72 :: 		}
	RET
; end of _wire1_read_byte

_IzmTemp:
;Temperature.c,74 :: 		unsigned char IzmTemp(void) {
;Temperature.c,76 :: 		if (wire1_ready()) {
	LCALL _wire1_ready+0
	MOV A, R0
	JZ L_IzmTemp15
;Temperature.c,77 :: 		wire1_write_byte (0xcc);
	MOV FARG_wire1_write_byte_c+0, #204
	LCALL _wire1_write_byte+0
;Temperature.c,78 :: 		wire1_write_byte (0x44);        //запуск преобразования темпер.
	MOV FARG_wire1_write_byte_c+0, #68
	LCALL _wire1_write_byte+0
;Temperature.c,79 :: 		return 1;
	MOV R0, #1
	RET
;Temperature.c,80 :: 		}
L_IzmTemp15:
;Temperature.c,81 :: 		else return 0;
	MOV R0, #0
;Temperature.c,83 :: 		}
	RET
; end of _IzmTemp

_ReadTemp:
;Temperature.c,85 :: 		unsigned char ReadTemp(void) {
;Temperature.c,90 :: 		if (wire1_ready()) {
	LCALL _wire1_ready+0
	MOV A, R0
	JZ L_ReadTemp17
;Temperature.c,91 :: 		EA_bit = 0; //отключить прерывания
	CLR EA_bit+0
;Temperature.c,92 :: 		wire1_write_byte (0xcc);
	MOV FARG_wire1_write_byte_c+0, #204
	LCALL _wire1_write_byte+0
;Temperature.c,93 :: 		wire1_write_byte (0xbe);
	MOV FARG_wire1_write_byte_c+0, #190
	LCALL _wire1_write_byte+0
;Temperature.c,94 :: 		termo0 = wire1_read_byte ();  // температуры
	LCALL _wire1_read_byte+0
	MOV ReadTemp_termo0_L0+0, 0
;Temperature.c,95 :: 		termo1 = wire1_read_byte ();
	LCALL _wire1_read_byte+0
	MOV ReadTemp_termo1_L0+0, 0
;Temperature.c,96 :: 		for(n=0;n!=7;n++) tmp = wire1_read_byte ();  // еще 7 ненужных байтов
	MOV ReadTemp_n_L0+0, #0
L_ReadTemp18:
	MOV A, ReadTemp_n_L0+0
	XRL A, #7
	JZ L_ReadTemp19
	LCALL _wire1_read_byte+0
	INC ReadTemp_n_L0+0
	SJMP L_ReadTemp18
L_ReadTemp19:
;Temperature.c,97 :: 		EA_bit = 1; //включить прерывания
	SETB EA_bit+0
;Temperature.c,98 :: 		return (termo1<<4)|(termo0>>4);
	MOV R0, #4
	MOV A, ReadTemp_termo1_L0+0
	INC R0
	SJMP L__ReadTemp26
L__ReadTemp27:
	CLR C
	RLC A
L__ReadTemp26:
	DJNZ R0, L__ReadTemp27
	MOV R2, A
	MOV R1, #4
	MOV A, ReadTemp_termo0_L0+0
	INC R1
	SJMP L__ReadTemp28
L__ReadTemp29:
	CLR C
	RRC A
L__ReadTemp28:
	DJNZ R1, L__ReadTemp29
	MOV R0, A
	MOV A, R2
	ORL 0, A
	RET
;Temperature.c,99 :: 		}
L_ReadTemp17:
;Temperature.c,100 :: 		else return 0;
	MOV R0, #0
;Temperature.c,101 :: 		}
	RET
; end of _ReadTemp
