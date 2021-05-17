#define  WIRE1_PIN  P1_4_bit

unsigned char IzmTemp(void);
unsigned char ReadTemp(void);
unsigned char wire1_ready(void);
void wire1_write_byte(unsigned char c);
unsigned char wire1_read_byte(void);
