#include "temperature.h"
#include "drv.h"


unsigned char wire1_ready(void)
{
  char count;

  WIRE1_PIN = 0;
  Delay_us(250); Delay_us(250);
  WIRE1_PIN = 1;
  while (WIRE1_PIN !=1) {               //���� ��������� ���� � 1 ����� ������
        if (count > 9) {return 0;}        //���� ���� ������� ����� (>100���) - ������
        count++;                        //���-�� ���������� ����� - ������
        Delay_us(8);
  }
  Delay_us(16);
  count = 0;
  while (WIRE1_PIN !=0) {                //���� ��������� ���� � 1 ����� ������
      if (count > 29) {return 0;}        //���� ���� 0 ������� ����� (>300 ���) - ������
      count++;                           //����� �� �������� - ������
      Delay_us(8);
  }
  Delay_us(205); Delay_us(205);
  WIRE1_PIN = 1;
  return 1;                                                        //���� ��� �������� ���������� 1
}

/*************************/
//������� ������ ����� //
/*************************/
void wire1_write_byte(unsigned char c)
{
  unsigned char cnt;                                        //�������
  unsigned char tmp_c;                                        //��� ���������� �

        WIRE1_PIN = 1;
        EA_bit = 0; //��������� ����������
        for (cnt = 0; cnt<8; cnt++) {
            tmp_c = c & 0b00000001;
            if(tmp_c == 1) {   //��� ��������� � ���� �� 60 ���
                WIRE1_PIN = 0;  //������� ������������� (0 �� 6 ���)
                Delay_us(2);    //2 ������ 6 ��-�� ������ ������
                WIRE1_PIN = 1;
                Delay_us(6);
            }
            else {
                WIRE1_PIN = 0; // (0 �� 60 ���)
                Delay_us(60);
                WIRE1_PIN = 1; // (1 �� 10 ���)
                Delay_us(10);
            }
            c = c>>1;
        }
        EA_bit = 1; //�������� ����������
}

unsigned char wire1_read_byte(void)
{
 unsigned char c=0,d=0,cnt=0;
  WIRE1_PIN = 1;
  for (cnt = 0; cnt<8; cnt++) {
        WIRE1_PIN = 0;            //������� ������������� (0 �� 6 ���)
        Delay_us(2);  // 2 ������ 6 ��-�� ������ ������
        WIRE1_PIN = 1;
        Delay_us(9);  // �������� �� 9 ���
        c = c>>1;
        if (WIRE1_PIN == 1) {c = c | 0b10000000;}  //��� ��������� �� ���� � ���� �
        Delay_us (55);  // //���� ���� ������ ��������� �����
  }
  return c;
}
  
unsigned char IzmTemp(void) {

if (wire1_ready()) {
 wire1_write_byte (0xcc);
 wire1_write_byte (0x44);        //������ �������������� ������.
 return 1;
}
else return 0;

}

unsigned char ReadTemp(void) {

unsigned char n;   //�������
unsigned char termo0,termo1,tmp;   //����� ����������

if (wire1_ready()) {
  EA_bit = 0; //��������� ����������
  wire1_write_byte (0xcc);
  wire1_write_byte (0xbe);
  termo0 = wire1_read_byte ();  // �����������
  termo1 = wire1_read_byte ();
  for(n=0;n!=7;n++) tmp = wire1_read_byte ();  // ��� 7 �������� ������
  EA_bit = 1; //�������� ����������
  return (termo1<<4)|(termo0>>4);
}
else return 0;
}


