#line 1 "D:/Downloads/Source code/mikroC project/mikroC project.c"
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
#line 15 "D:/Downloads/Source code/mikroC project/mikroC project.c"
char state = 0;
char key = 0;
int speed = 100;
char *buf[32];
int head_pos = 0;

int ms = 0;
#line 32 "D:/Downloads/Source code/mikroC project/mikroC project.c"
void DelayMs(unsigned int m){
 unsigned char a;
 for(ms=0;ms!=m;ms++) {
 Delay_us(250); Delay_us(250);
 Delay_us(250); Delay_us(250);

 }
}

void show_string()
{
 int i;
 for (i = 0; i < 32; i++)
 outd(buf[i]);
}


void move_left_string()
{
 int i;
 char tmp = buf[0];
 for (i = 0; i < 31; i++)
 buf[i] = buf[i + 1];
 buf[31] = tmp;
}


void move_right_string()
{
 int i;
 char tmp = buf[31];
 for (i = 31; i > 0; i--)
 buf[i] = buf[i - 1];
 buf[0] = tmp;
}


void reset_string()
{
 while (head_pos > 0) {
 move_left_string();
 head_pos--;
 }
}
int len()
{
 int i;
 int ret = 0;
 for (i = 0; i < 32; i++)
 {
 char tmp = buf[i];
 if (tmp == 0x20)
 {
 return ret;
 }
 ret++;
 }
}

void clear_string()
{
 int i;
 for (i = 0; i < 32; i++)
 buf[i] = ' ';
}

void write_string()
{
 int i;
 for (i = 0; i < 32; i++)
 wr_EEPROM(i, buf[i]);
}

void read_string()
{
 int i;
 for (i = 0; i < 32; i++)
 buf[i] = rd_EEPROM(i);
}

void Timer1InterruptHandler() org IVT_ADDR_ET1
{

 EA_bit = 0;
 TF1_bit = 0;

 TR1_bit = 0;
 TH1 = 0xFC;
 TL1 = 0x18;


 ms++;

 EA_bit = 1;
 TR1_bit = 1;
}

void INT0_Interrupt() org IVT_ADDR_EX0
{
 EA_bit = 0;
  P0_4_bit  = ~ P0_4_bit ;
 if (state ==  2 )
 state =  0 ;
 EA_bit = 1;
}

void INT1_Interrupt() org IVT_ADDR_EX1
{
 EA_bit = 0;
  P0_4_bit  = ~ P0_4_bit ;
 if (state ==  0 )
 state =  1 ;
 EA_bit = 1;
}

void main()
{
 init();
 clear_lcd();
 read_string();
 speed = rd_EEPROM(32);
 if (!speed)
 speed = 10;
 else if (speed > 100) speed = 100;

 while (1)
 {
 key = ScanKbd();
 switch (state)
 {
 case  0 :
 reset_string();
 clear_lcd();
 outcw(0x80);
 show_string();
 if (key ==  'e' )
 {
 write_string();
 state =  2 ;
 }
 if (key >= '0' && key <= '9')
 {
 buf[len()] = key;
 }
 if (key ==  '#' )
 clear_string();
 break;

 case  2 :
 clear_lcd();
 move_right_string();
 head_pos++;
 if (head_pos == 32) head_pos = 0;
 outcw(0x80);
 show_string();
 break;
 case  1 :
 clear_lcd();
 outcw(0x80);
 if ((key ==  'e' ) && (speed > 10))
 {
 speed -= 10;
 }
 if ((key ==  '#' ) && (speed < 100))
 {
 speed += 10;
 }
 break;
 }
 DelayMs(speed * 5);
 }
}
