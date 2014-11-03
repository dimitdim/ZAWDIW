#include <SPI.h>

const int button = 6;
const int failLED = 7;
const int passLED = 8;
const int runLED = 9;

boolean pass=true;
boolean run=false;

int i;

int data[256];

void shuffle(int *array, size_t n)
{
    if (n > 1) {
        size_t i;
	for (i = 0; i < n - 1; i++) {
	  size_t j = i + rand() / (RAND_MAX / (n - i) + 1);
	  int t = array[j];
	  array[j] = array[i];
	  array[i] = t;
	}
    }
}

void setup() {
  Serial.begin(9600);
  SPI.setBitOrder(MSBFIRST);
  SPI.setClockDivider(SPI_CLOCK_DIV32);
  SPI.setDataMode(SPI_MODE0);
  SPI.begin();
  pinMode(button,INPUT);
  pinMode(failLED,OUTPUT);
  digitalWrite(failLED,LOW);
  pinMode(passLED,OUTPUT);
  digitalWrite(passLED,LOW);
  pinMode(runLED,OUTPUT);
  digitalWrite(runLED,LOW);
  for(i=0;i<256;i++) {
    data[i]=i;
  }
}
void loop() {
  if(digitalRead(button)==HIGH) {
    digitalWrite(runLED,HIGH);
    shuffle(data,256);
    for(i=0;i<128;i++){
      SPI.transfer(2*i);
      SPI.transfer(data[i]);
    }
    for(i=0;i<128;i++) {
      SPI.transfer(2*i+1);
      if(SPI.transfer(0)!=data[i]) {
        pass=false;
        break;
      }
    }
    for(i=0;i<128;i++) {
      SPI.transfer(2*i+1);
      if(SPI.transfer(0)!=data[i]) {
        pass=false;
        break;
      }
    }
    for(i=0;i<128;i++){
      SPI.transfer(2*i);
      SPI.transfer(data[128+i]);
    }
    for(i=0;i<128;i++) {
      SPI.transfer(2*i+1);
      if(SPI.transfer(0)!=data[128+i]) {
        pass=false;
        break;
      }
    }
	for(i=0;i<128;i++) {
      SPI.transfer(2*i+1);
      if(SPI.transfer(0)!=data[128+i]) {
        pass=false;
        break;
      }
    }
    digitalWrite(runLED,LOW);
    digitalWrite(passLED,pass);
    digitalWrite(failLED,!pass);
  }
}
