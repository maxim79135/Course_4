//#include "89xs8252.h"
#include "drv.h"
#include "temperature.h"


#define R      1 // ��� ���������
#define RY     2
#define G      3
#define GG     4
#define Y      5
#define SR     6
#define SG     7


char key=0;      // ������������� ������� ������
char state=R;    // ������������� ������������ ���������
char t;          // �������� ��������
char tr;         // ����� �������� �������, �
char tg;         // ����� �������� �������, �
char T_FLAG = 0; // ������ �������� "����� �������"
int ms = 0;      // ������� ����������
char temp = 0;   // �����������
unsigned char d; // ������� ��������


void main (void) {

// �������������
     init();
     RED = 0;      // ������� ����
     YEL = 1;      // ������ ����
     GRN = 1;      // ������� ����
     lcd_led = 0;  // ��������� ����������
     tr=rd_EEPROM(0); if((tr>30)||(tr<5)) tr=5;
     tg=rd_EEPROM(1); if((tg>30)||(tg<5)) tg=5;
     t = 10*tr;
/*
     while(1) {
       if(IzmTemp()) {
         DelayMs(250); DelayMs(250); DelayMs(250);
         temp=ReadTemp();
         DelayMs(10);
       }
       else {DelayMs(250); DelayMs(250); temp=0;}
       clear_lcd(); outcw(0x80); outd('t'); outd('=');
       outd(temp/10+48); outd(temp%10+48); outd(' '); outd('C');
       WMCON.WDTRST=1; // ����� ����������� �������
     }
*/
// ���������� ������������ ��������
        while (1) {
              key=ScanKbd();
              switch (state) {
                case R: // �������
                        //PrintOut(outd,"�������         ");
                        clear_lcd(); outcw(0x80); outd('�'); //outd('�'); outd('�');
                        //outd('�'); outd('�'); outd('�'); outd('�');
                        if (T_FLAG) { state=RY;  T_FLAG = 0;  t=20;  YEL=0; }
                        else if (key == '8') { state=SR;  RED=1; }
                        break;
                case RY: // �������-������
                        //PrintOut(outd,"�������-������  ");
                        clear_lcd(); outcw(0x80); outd('�'); outd('�'); outd('.'); outd('-');
                        outd('�'); outd('.'); //outd('�'); outd('�'); outd('�'); outd('�'); outd('�');
                        if (T_FLAG) { state=G;  T_FLAG = 0;  t=10*tg;  RED=1; YEL=1; GRN=0; }
                        else if (key == '8') { state=SR;  RED=1; YEL=1; }
                        break;
                case G: // �������
                        //PrintOut(outd,"�������         ");
                        clear_lcd(); outcw(0x80); outd('�'); //outd('�'); outd('�');
                        //outd('�'); outd('�'); outd('�'); outd('�');
                        if (T_FLAG) { state=GG;  T_FLAG = 0;  t=3; }
                        else if (key == '8') { state=SR;  GRN=1; }
                        break;
                case GG: // �������� �������
                        GRN=0; DelayMs(500);
                        GRN=1; DelayMs(400);
                        if (T_FLAG) { state=Y;  T_FLAG = 0;  t=20;  YEL=0; }
                        break;
                case Y: // ������
                        //PrintOut(outd,"������          ");
                        clear_lcd(); outcw(0x80); outd('�'); //outd('�'); outd('�');
                        //outd('�'); outd('�'); outd('�');
                        if (T_FLAG) { state=R;  T_FLAG = 0;  t=10*tr; YEL=1; RED=0; }
                        else if (key == '8') { state=SR;  YEL=1; }
                        break;
                case SR: // ��������� ������� �������� �������
                        //PrintOut(outd,"t�=%2dc          ", tr);
                        clear_lcd(); outcw(0x80); outd('t'); outd('�'); outd('=');
                        outd(tr/10+48); outd(tr%10+48); outd('c');
                        switch(key) {
                                case '7': if (tr>5) tr--; break;
                                case '9': if (tr<30) tr++; break;
                                case '8': wr_EEPROM(0,tr); state=SG; break;
                        }
                        break;
                case SG: // ��������� ������� �������� �������
                        //PrintOut(outd,"t�=%2dc          ", tg);
                        clear_lcd(); outcw(0x80); outd('t'); outd('�'); outd('=');
                        outd(tg/10+48); outd(tg%10+48); outd('c');
                        switch(key) {
                                case '7': if (tg>5) tg--; break;
                                case '9': if (tg<30) tg++; break;
                                case '8': wr_EEPROM(1,tg); state=R; T_FLAG = 0; t=10*tr; RED=0; break;
                        }
                        break;
              }
              DelayMs(100);            // ���� ������ ��������
              if(t==0) T_FLAG=1; else t--;  // �������
        }
}


/*
void DelayMs(unsigned int m){  // �������� ������ ������
  unsigned char a; //������� �������������� �����
  for(ms=0;ms!=m;ms++) {
    Delay_us(250); Delay_us(250); 
    Delay_us(250); Delay_us(250); // ������ ���� 1��
    //WMCON.WDTRST=1; // ����� ����������� �������
  }
}
*/

void DelayMs(unsigned int m){  // �������� �� �������
  //unsigned char a;
  //a = ms+(m<<1);
  ms=0;
  WMCON.WDTRST=1; // ����� ����������� �������
  while(ms!=m) continue;
}

void Timer1InterruptHandler() org IVT_ADDR_ET1{

  EA_bit = 0;        // Clear global interrupt enable flag
  TF1_bit = 0;       // Ensure that Timer1 interrupt flag is cleared

  TR1_bit = 0;       // Stop Timer1
  TH1 = 0xFC;        // Reset Timer1 high byte  65536-1000
  TL1 = 0x18;        // Reset Timer1 low byte

  //P0 = ~P0;          // Toggle PORT0
  ms++;

  EA_bit = 1;        // Set global interrupt enable flag
  TR1_bit = 1;       // Run Timer1
}

void INT0_Interrupt() org IVT_ADDR_EX0 {
  EA_bit = 0;
  lcd_led=~lcd_led;
  EA_bit = 1;
}
/*
void UART_Interrupt() iv IVT_ADDR_ES {
  if (RI_bit){
    if (SBUF==0x13) {state=SR;  RED=1; YEL=1; GRN=1;}
    RI_bit=0;
  }
  if (TI_bit) TI_bit = 0;
}
*/