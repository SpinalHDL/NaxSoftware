#include <type.h>
#include <stdio.h>
#include <riscv.h>

#include <mac_sg.h>

#define MACSG_BASE 0xF1000000

volatile struct macsg_tx_descriptor tx_desc[10] __attribute__ ((aligned (32)));
char tx_data[10][2000];

volatile struct macsg_rx_descriptor rx_desc[100+1] __attribute__ ((aligned (32)));
char rx_data[100][2000];

void putChar(char v){
  //write_u32(v, 0x10000000);
while (read_u32(0xf0001004));
 write_u32(v, 0xf0001000);
}
void putString(char *v){
    while(*v){
      putChar(*v++);
    }
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

  // Setup rx descriptor
  for(int i = 0;i < 100;i++){
    rx_desc[i].status = 0;
    rx_desc[i].control = 2000;
    rx_desc[i].to = (u32)(rx_data + i);
    rx_desc[i].next = (u32)(rx_desc + i + 1);
  }
  rx_desc[99].next = rx_desc;
  rx_desc[100].status = MACSG_RX_DESC_STATUS_COMPLETED;

  asm("fence w,o");

  macsg_rx_set_next(MACSG_BASE, (u32)(rx_desc+0));
  macsg_rx_start(MACSG_BASE);


  // Setup tx descriptor
  tx_desc[0].status = 0;
  tx_desc[0].control = 511 | MACSG_TX_DESC_CONTROL_LAST;
  tx_desc[0].from = (u32)(tx_data + 0);
  tx_desc[0].next = (u32)(tx_desc + 1);

  tx_desc[1].status = 0;
  tx_desc[1].control = 32 | MACSG_TX_DESC_CONTROL_LAST;
  tx_desc[1].from = (u32)(tx_data + 1);
  tx_desc[1].next = (u32)(tx_desc + 2);

  tx_desc[2].status = 0;
  tx_desc[2].control = 31 | MACSG_TX_DESC_CONTROL_LAST;
  tx_desc[2].from = (u32)(tx_data + 1);
  tx_desc[2].next = (u32)(tx_desc + 3);

  tx_desc[3].status = 0;
  tx_desc[3].control = 512 | MACSG_TX_DESC_CONTROL_LAST;
  tx_desc[3].from = (u32)(tx_data + 0);
  tx_desc[3].next = (u32)(tx_desc + 4);

  tx_desc[4].status = 0;
  tx_desc[4].control = 511 | MACSG_TX_DESC_CONTROL_LAST;
  tx_desc[4].from = (u32)(tx_data + 0);
  tx_desc[4].next = (u32)(tx_desc + 5);

  tx_desc[5].status = 0;
  tx_desc[5].control = 32 | MACSG_TX_DESC_CONTROL_LAST;
  tx_desc[5].from = (u32)(tx_data + 1);
  tx_desc[5].next = (u32)(tx_desc + 6);

  tx_desc[6].status = 0;
  tx_desc[6].control = 31 | MACSG_TX_DESC_CONTROL_LAST;
  tx_desc[6].from = (u32)(tx_data + 1);
  tx_desc[6].next = (u32)(tx_desc + 7);

  tx_desc[7].status = 0;
  tx_desc[7].control = 512 | MACSG_TX_DESC_CONTROL_LAST;
  tx_desc[7].from = (u32)(tx_data + 0);
  tx_desc[7].next = (u32)(tx_desc + 8);

  tx_desc[8].status = MACSG_TX_DESC_STATUS_COMPLETED;

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
  putChar('\n');
int rxCount = 1;
while(1)
for(int i = 0;i < 100;i++){
    char str[100];
    volatile struct macsg_rx_descriptor* d = rx_desc + i;
    while(1){
        int completed = d->status & MACSG_RX_DESC_STATUS_COMPLETED;
        if(completed) break;
        if(!macsg_rx_busy(MACSG_BASE)){
            putString("Dma halted ???\n");
            while(1);
          macsg_rx_set_next(MACSG_BASE, (u32)(d));
          macsg_rx_start(MACSG_BASE);
        }
    }
    int error = d->status & MACSG_RX_DESC_STATUS_ERROR;
    if(error) putString("Got error, ");
    int bytes = d->status & MACSG_RX_DESC_STATUS_BYTES;
    sprintf(str, "%d with %d bytes\n", rxCount, bytes);
    putString(str);
    for(int i2 = 0;i2 < bytes;i2++){
        sprintf(str, "%02x ", rx_data[i][i2]);
        putString(str);
        if((i2 & 31) == 31){
            putChar('\n');
        }
    }
    rxCount += 1;
    d->status = 0;
  putString("\n");
  }
  while(1) putString("done\n");
  //for(int i = 0;i< 100000;i++) asm("nop");
  return 0;
  }
  return 0;
}

