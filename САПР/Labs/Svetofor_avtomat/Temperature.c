#include "temperature.h"
#include "drv.h"


unsigned char wire1_ready(void)
{
  char count;

  WIRE1_PIN = 0;
  Delay_us(250); Delay_us(250);
  WIRE1_PIN = 1;
  while (WIRE1_PIN !=1) {               //ждем установки шины в 1 после сброса
        if (count > 9) {return 0;}        //если ждем слишком долго (>100мкс) - значит
        count++;                        //кто-то подгружает линию - ошибка
        Delay_us(8);
  }
  Delay_us(16);
  count = 0;
  while (WIRE1_PIN !=0) {                //ждем установки шины в 1 после сброса
      if (count > 29) {return 0;}        //если ждем 0 слишком долго (>300 мкс) - значит
      count++;                           //никто не отвечает - ошибка
      Delay_us(8);
  }
  Delay_us(205); Delay_us(205);
  WIRE1_PIN = 1;
  return 1;                                                        //если все впорядке возвращаем 1
}

/*************************/
//Функция записи байта //
/*************************/
void wire1_write_byte(unsigned char c)
{
  unsigned char cnt;                                        //счетчик
  unsigned char tmp_c;                                        //для сохранения с

        WIRE1_PIN = 1;
        EA_bit = 0; //отключить прерывания
        for (cnt = 0; cnt<8; cnt++) {
            tmp_c = c & 0b00000001;
            if(tmp_c == 1) {   //бит запихнуть в шину на 60 мкс
                WIRE1_PIN = 0;  //импульс синхронизации (0 на 6 мкс)
                Delay_us(2);    //2 вместо 6 из-за завала фронта
                WIRE1_PIN = 1;
                Delay_us(6);
            }
            else {
                WIRE1_PIN = 0; // (0 на 60 мкс)
                Delay_us(60);
                WIRE1_PIN = 1; // (1 на 10 мкс)
                Delay_us(10);
            }
            c = c>>1;
        }
        EA_bit = 1; //включить прерывания
}

unsigned char wire1_read_byte(void)
{
 unsigned char c=0,d=0,cnt=0;
  WIRE1_PIN = 1;
  for (cnt = 0; cnt<8; cnt++) {
        WIRE1_PIN = 0;            //импульс синхронизации (0 на 6 мкс)
        Delay_us(2);  // 2 вместо 6 из-за завала фронта
        WIRE1_PIN = 1;
        Delay_us(9);  // задержка на 9 мкс
        c = c>>1;
        if (WIRE1_PIN == 1) {c = c | 0b10000000;}  //бит запихнуть из шины в байт с
        Delay_us (55);  // //ждем пока прибор освободит линию
  }
  return c;
}
  
unsigned char IzmTemp(void) {

if (wire1_ready()) {
 wire1_write_byte (0xcc);
 wire1_write_byte (0x44);        //запуск преобразования темпер.
 return 1;
}
else return 0;

}

unsigned char ReadTemp(void) {

unsigned char n;   //счетчик
unsigned char termo0,termo1,tmp;   //байты температур

if (wire1_ready()) {
  EA_bit = 0; //отключить прерывания
  wire1_write_byte (0xcc);
  wire1_write_byte (0xbe);
  termo0 = wire1_read_byte ();  // температуры
  termo1 = wire1_read_byte ();
  for(n=0;n!=7;n++) tmp = wire1_read_byte ();  // еще 7 ненужных байтов
  EA_bit = 1; //включить прерывания
  return (termo1<<4)|(termo0>>4);
}
else return 0;
}


