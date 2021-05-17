#line 1 "D:/Downloads/Source code/Svetofor_avtomat/Temperature.c"
#line 1 "d:/downloads/source code/svetofor_avtomat/temperature.h"


unsigned char IzmTemp(void);
unsigned char ReadTemp(void);
unsigned char wire1_ready(void);
void wire1_write_byte(unsigned char c);
unsigned char wire1_read_byte(void);
#line 1 "d:/downloads/source code/svetofor_avtomat/drv.h"
#line 13 "d:/downloads/source code/svetofor_avtomat/drv.h"
unsigned char ScanKbd(void);
void init(void);
unsigned char translate(unsigned char c);
void DelayMs(unsigned int m);
void wr_EEPROM(unsigned int addr,unsigned char eedata);
unsigned char rd_EEPROM(unsigned int addr);
void clear_lcd(void);
void outcw(unsigned char c);
void outd(unsigned char c);
#line 5 "D:/Downloads/Source code/Svetofor_avtomat/Temperature.c"
unsigned char wire1_ready(void)
{
 char count;

  P1_4_bit  = 0;
 Delay_us(250); Delay_us(250);
  P1_4_bit  = 1;
 while ( P1_4_bit  !=1) {
 if (count > 9) {return 0;}
 count++;
 Delay_us(8);
 }
 Delay_us(16);
 count = 0;
 while ( P1_4_bit  !=0) {
 if (count > 29) {return 0;}
 count++;
 Delay_us(8);
 }
 Delay_us(205); Delay_us(205);
  P1_4_bit  = 1;
 return 1;
}




void wire1_write_byte(unsigned char c)
{
 unsigned char cnt;
 unsigned char tmp_c;

  P1_4_bit  = 1;
 EA_bit = 0;
 for (cnt = 0; cnt<8; cnt++) {
 tmp_c = c & 0b00000001;
 if(tmp_c == 1) {
  P1_4_bit  = 0;
 Delay_us(2);
  P1_4_bit  = 1;
 Delay_us(6);
 }
 else {
  P1_4_bit  = 0;
 Delay_us(60);
  P1_4_bit  = 1;
 Delay_us(10);
 }
 c = c>>1;
 }
 EA_bit = 1;
}

unsigned char wire1_read_byte(void)
{
 unsigned char c=0,d=0,cnt=0;
  P1_4_bit  = 1;
 for (cnt = 0; cnt<8; cnt++) {
  P1_4_bit  = 0;
 Delay_us(2);
  P1_4_bit  = 1;
 Delay_us(9);
 c = c>>1;
 if ( P1_4_bit  == 1) {c = c | 0b10000000;}
 Delay_us (55);
 }
 return c;
}

unsigned char IzmTemp(void) {

if (wire1_ready()) {
 wire1_write_byte (0xcc);
 wire1_write_byte (0x44);
 return 1;
}
else return 0;

}

unsigned char ReadTemp(void) {

unsigned char n;
unsigned char termo0,termo1,tmp;

if (wire1_ready()) {
 EA_bit = 0;
 wire1_write_byte (0xcc);
 wire1_write_byte (0xbe);
 termo0 = wire1_read_byte ();
 termo1 = wire1_read_byte ();
 for(n=0;n!=7;n++) tmp = wire1_read_byte ();
 EA_bit = 1;
 return (termo1<<4)|(termo0>>4);
}
else return 0;
}
