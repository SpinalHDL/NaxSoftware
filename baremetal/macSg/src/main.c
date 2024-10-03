#include <type.h>
#include <stdio.h>
#include <riscv.h>

#include <mac_sg.h>

#define MACSG_BASE 0xF1000000

volatile struct macsg_tx_descriptor tx_desc[10] __attribute__ ((aligned (32)));
char tx_data[10][1500];
void putChar(char v){
// write_u32(v, 0xf0001000);
}

char premade[] = {0xff,0xff,0xff,0xff,0xff,0xff,0x36,0x11,0x22,0x33,0x44,0xf5,0x08,0x06,0x00,0x01,0x08,0x00,0x06,0x04,0x00,0x01,0x36,0xf0,0x72,0x16,0xe9,0xf5,0xc0,0xa8,0x01,0x64,0x00,0x00,0x00,0x00,0x00,0x00,0x5b,0xbd,0x5b,0x62};
u32 premade_bytes = 32+8+2;

int main(){
  u8 off = 0;
  u32 bytes = 1024;

  for(int i = 0;i < bytes;i++)tx_data[0][i] = i+off;
  for(int i = 0;i < 6;i++)tx_data[0][i] = 0xFF;
  tx_data[0][12] = 0x08;
  tx_data[0][13] = 0x06;

  bytes = 32;
  for(int i = 0;i < 12;i++)tx_data[1][i] = 0xFF;
  for(int i = 0;i < bytes;i++)tx_data[1][i] = i+off;
  tx_data[1][12] = 0x08;
  tx_data[1][13] = 0x06;



  while(1)
  {
  putChar('\n');
  putChar('0');
  // Build packet

 // bytes = 1024;
 // for(int i = 0;i < bytes;i++)tx_data[0][i] = i;

  // Setup descriptor
  tx_desc[0].status = 0;
  tx_desc[0].control = 1024 | MACSG_TX_DESC_CONTROL_LAST;
  tx_desc[0].from = (u32)(tx_data + 0);
  tx_desc[0].next = (u32)(tx_desc + 1);

  tx_desc[1].status = 0;
  tx_desc[1].control = 32 | MACSG_TX_DESC_CONTROL_LAST;
  tx_desc[1].from = (u32)(tx_data + 1);
  tx_desc[1].next = (u32)(tx_desc + 2);

  tx_desc[2].status = 0;
  tx_desc[2].control = 32 | MACSG_TX_DESC_CONTROL_LAST;
  tx_desc[2].from = (u32)(tx_data + 1);
  tx_desc[2].next = (u32)(tx_desc + 3);

  tx_desc[3].status = 0;
  tx_desc[3].control = 1024 | MACSG_TX_DESC_CONTROL_LAST;
  tx_desc[3].from = (u32)(tx_data + 0);
  tx_desc[3].next = (u32)(tx_desc + 4);
//  tx_desc[3].next = (u32)(tx_desc + 0);

  tx_desc[4].status = MACSG_TX_DESC_STATUS_COMPLETED;

  asm("fence w,o");

  macsg_tx_set_next(MACSG_BASE, (u32)(tx_desc+0));
  macsg_tx_start(MACSG_BASE);

//  while(1){
//    for(int i = 0;i < 4;i++){
//      tx_desc[i].status = 0;
//    }
//  }
  putChar('1');
  while(macsg_tx_busy(MACSG_BASE));
  putChar('2');
  //for(int i = 0;i< 100000;i++) asm("nop");
  }
  return 0;
}

