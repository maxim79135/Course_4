#include "drv.h"

#define D1 P0_0_bit
#define D2 P0_1_bit
#define D3 P0_2_bit
#define D4 P0_3_bit

#define S_INIT 0
#define S_CHANGE_SPEED 1
#define S_MOVING 2

#define KEY_UP 'e'
#define KEY_DOWN '#'

char state = 0;
char key = 0;
int speed = 100;
char *buf[32];
int head_pos = 0;

int ms = 0;

   /*
void DelayMs(int m)
{
    ms = 0;
    WMCON.WDTRST = 1;
    while (ms != m)
        continue;
}*/

void DelayMs(unsigned int m){  // ???????? ?????? ??????
  unsigned char a; //??????? ?????????????? ?????
  for(ms=0;ms!=m;ms++) {
    Delay_us(250); Delay_us(250);
    Delay_us(250); Delay_us(250); // ?????? ???? 1??
    //WMCON.WDTRST=1; // ????? ??????????? ???????
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

    EA_bit = 0;  // Clear global interrupt enable flag
    TF1_bit = 0; // Ensure that Timer1 interrupt flag is cleared

    TR1_bit = 0; // Stop Timer1
    TH1 = 0xFC;  // Reset Timer1 high byte  65536-1000
    TL1 = 0x18;  // Reset Timer1 low byte

    //P0 = ~P0;          // Toggle PORT0
    ms++;

    EA_bit = 1;  // Set global interrupt enable flag
    TR1_bit = 1; // Run Timer1
}

void INT0_Interrupt() org IVT_ADDR_EX0
{
    EA_bit = 0;
    lcd_led = ~lcd_led;
    if (state == S_MOVING)
        state = S_INIT;
    EA_bit = 1;
}

void INT1_Interrupt() org IVT_ADDR_EX1
{
    EA_bit = 0;
    lcd_led = ~lcd_led;
    if (state == S_INIT)
        state = S_CHANGE_SPEED;
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
        case S_INIT:
            reset_string();
            clear_lcd();
            outcw(0x80);
            show_string();
            if (key == KEY_UP)
            {
                write_string();
                state = S_MOVING;
            }
            if (key >= '0' && key <= '9')
            {
                buf[len()] = key;
            }
            if (key == KEY_DOWN)
                clear_string();
            break;

        case S_MOVING:
            clear_lcd();
            move_right_string();
            head_pos++;
            if (head_pos == 32) head_pos = 0;
            outcw(0x80);
            show_string();
            break;
        case S_CHANGE_SPEED:
            clear_lcd();
            outcw(0x80);
            if ((key == KEY_UP) && (speed > 10))
            {
                speed -= 10;
            }
            if ((key == KEY_DOWN) && (speed < 100))
            {
                speed += 10;
            }
            break;
        }
        DelayMs(speed * 5);
    }
}