#include <SPI.h>

const int button = 6;
const int failLED = 7;
const int passLED = 8;
const int runLED = 9;

boolean pass=true;
boolean run=false;

void SPIsetup() {
  SPI.setBitOrder(MSBFIRST);
  SPI.setClockDivider(SPI_CLOCK_DIV32);
  SPI.setDataMode(SPI_MODE3);
}

void setup() {
  Serial.begin(9600);
  pinMode(button,INPUT);
  pinMode(failLED,OUTPUT);
  digitalWrite(failLED,LOW);
  pinMode(passLED,OUTPUT);
  digitalWrite(passLED,LOW);
  pinMode(runLED,OUTPUT);
  digitalWrite(runLED,HIGH);
}
void loop() {
  if(digitalRead(button)==HIGH) {
    digitalWrite(runLED,LOW);
    digitalWrite(passLED,LOW);
    digitalWrite(failLED,LOW);
    delay(500);
    SPI.begin();
    SPIsetup();
    SPI.transfer(100);
    SPI.transfer(24);
    SPI.end();
    SPI.begin();
    SPIsetup();
    SPI.transfer(101);
    Serial.println(SPI.transfer(0));
    SPI.end();
    digitalWrite(runLED,HIGH);
    digitalWrite(passLED,pass);
    digitalWrite(failLED,!pass);
    delay(1000);
  }
}
