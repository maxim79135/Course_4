#define RED P0_0_bit
#define YEL P0_1_bit
#define GRN P0_2_bit
//#define BLUE P0_3_bit
#define lcd_led P0_4_bit
#define DB P2
#define E P3_7_bit
#define RS P3_6_bit
#define RW P3_5_bit

//extern int ms=0;      // ������� ����������

unsigned char ScanKbd(void);  // ������������ ����������
void init(void);     // �������������
unsigned char translate(unsigned char c); // ������� �� ���� ����������
void DelayMs(unsigned int m);             // �������� � ��
void wr_EEPROM(unsigned int addr,unsigned char eedata); // ������ � EEPROM
unsigned char rd_EEPROM(unsigned int addr);             // ������ �� EEPROM
void clear_lcd(void);        // ������� LCD
void outcw(unsigned char c); // ����� ���. �����
void outd(unsigned char c);  // ����� ������