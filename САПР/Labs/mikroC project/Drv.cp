#line 1 "D:/Downloads/Source code/mikroC project/Drv.c"
#line 1 "d:/downloads/source code/mikroc project/drv.h"
#line 13 "d:/downloads/source code/mikroc project/drv.h"
unsigned char ScanKbd(void);
void init(void);
unsigned char translate(unsigned char c);
void DelayMs(unsigned int m);
void wr_EEPROM(unsigned int addr,unsigned char eedata);
unsigned char rd_EEPROM(unsigned int addr);
void clear_lcd(void);
void outcw(unsigned char c);
void outd(unsigned char c);
#line 5 "D:/Downloads/Source code/mikroC project/Drv.c"
void init(void){
unsigned char i;


 WMCON = 0b11111001;


 WMCON|=0x08;
 WMCON&=0xfb;


 PCON |= 0x80;
 SCON = 0x72;
 TMOD = 0x22;
 TH1 = 0xF5;
 ES_bit = 0;


 TF1_bit = 0;
 ET1_bit = 1;
 EA_bit = 1;

 GATE1_bit = 0;
 C_T1_bit = 0;
 M11_bit = 0;
 M01_bit = 1;

 TR1_bit = 0;
 TH1 = 0xFC;
 TL1 = 0x18;
 TR1_bit = 1;



 P3=0xff;
 EX0_bit = 1;



 delay_ms(30);
  P3_5_bit  = 0;
 outcw(0x3C);
 outcw(0x0C);
 outcw(0x01);
 outcw(0x06);
 outcw(0x40);
 for(i=0;i<8;i++) outd(0);
 for(i=0;i<8;i++) outd(0x10);
 for(i=0;i<8;i++) outd(0x18);
 for(i=0;i<8;i++) outd(0x1C);
 for(i=0;i<8;i++) outd(0x1E);
 for(i=0;i<8;i++) outd(0x1F);
}

unsigned char ScanKbd(void) {
 unsigned char i;
 unsigned char kp = 0;
 P0 = P0&0x1F|0xC0;
 for(i=0;i<10;i++);
 if (!P1_0_bit) kp = '7';
 else if (!P1_1_bit) kp = '4';
 else if (!P1_2_bit) kp = '1';
 else if (!P1_3_bit) kp = '#';
 P0 = P0&0x1F|0xA0;
 for(i=0;i<10;i++);
 if (!P1_0_bit) kp = '8';
 else if (!P1_1_bit) kp = '5';
 else if (!P1_2_bit) kp = '2';
 else if (!P1_3_bit) kp = '0';
 P0 = P0&0x1F|0x60;
 for(i=0;i<10;i++);
 if (!P1_0_bit) kp = '9';
 else if (!P1_1_bit) kp = '6';
 else if (!P1_2_bit) kp = '3';
 else if (!P1_3_bit) kp = 'e';
 return kp;
}


unsigned char translate(unsigned char c){
switch (c){







 case '?': return 0xA3;
 case '?': return 0xA4;


 case '?': return 'K';
#line 126 "D:/Downloads/Source code/mikroC project/Drv.c"
 case '?': return 0xB6;
 case '?': return 0xB7;








 case '?': return 'p';
 case '?': return 'c';
#line 152 "D:/Downloads/Source code/mikroC project/Drv.c"
 default: return c;
 }
}

void wr_EEPROM(unsigned int addr,unsigned char eedata)
{

 DP0L=addr;
 DP0H=addr>>8;
 WMCON|=0x10;
 ACC = eedata;
 asm movx @DPTR,A;
 WMCON&=0xef;
}

unsigned char rd_EEPROM(unsigned int addr)
{
 while(!(WMCON&2));
 DP0L=addr;
 DP0H=addr>>8;
 asm movx A,@DPTR;
 return ACC;
}

void clear_lcd(void){
 unsigned char i;
 outcw(0x80);
 for(i=0;i<16;i++)
 outd(' ');
}

void outcw(unsigned char c){
unsigned char i;
unsigned int j;
  P3_6_bit  = 0;
  P2  = c;
  P3_7_bit  = 1;
  P3_7_bit  = 2;
 for (i=0; i<20; i++);
 if (c==1||c==2||c==3)
 for (j=0; j<500; j++);
}

void outd(unsigned char c){
unsigned char i;
 c=translate(c);
  P3_6_bit  = 1;
  P2  = c;
  P3_7_bit  = 1;
  P3_7_bit  = 2;
 for (i=0; i<21; i++);
}
