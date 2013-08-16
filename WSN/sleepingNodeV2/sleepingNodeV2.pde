//Dino Tinitigan
//Sleeping Node
//Sleep code derived form sleep code from arduino website
//Sends temperature data to coordinator
//Goes back to sleep after sending data

#include <avr/sleep.h>


int wakePin = 2;  // pin used for waking up
int sleepStatus = 0;  // variable to store a request for sleep
int temp1;
int ID = 3;  //ID of node, change this!!!            
int ledPin = 3;
double t1;
int temp2;
double vref = 5.04;

void wakeUpNow()        // here the interrupt is handled after wakeup
{
  // execute code here after wake-up before returning to the loop() function
  // timers and code using timers (serial.print and more...) will not work here.
  // we don't really need to execute any special functions here, since we
  // just want the thing to wake up
}

void setup()
{
  pinMode(ledPin, OUTPUT);
  
  pinMode(wakePin, INPUT);

  Serial.begin(9600);

  attachInterrupt(0, wakeUpNow, LOW); // use interrupt 0 (pin 2) and run function
                                      // wakeUpNow when pin 2 gets LOW 
}

void sleepNow()         // here we put the arduino to sleep
{
    //Serial.println("Sleeping");
    digitalWrite(ledPin, LOW); 
    set_sleep_mode(SLEEP_MODE_PWR_DOWN);   // sleep mode is set here

    sleep_enable();          // enables the sleep bit in the mcucr register
                             // so sleep is possible. just a safety pin 

    attachInterrupt(0,wakeUpNow, LOW); // use interrupt 0 (pin 2) and run function
                                       // wakeUpNow when pin 2 gets LOW 

    sleep_mode();            // here the device is actually put to sleep!!
                             // THE PROGRAM CONTINUES FROM HERE AFTER WAKING UP

    sleep_disable();         // first thing after waking from sleep:
                             // disable sleep...
    detachInterrupt(0);      // disables interrupt 0 on pin 2 so the 
                             // wakeUpNow code will not be executed 
                             // during normal running time.

}

void loop()
{
  digitalWrite(ledPin, HIGH); //turn led on while awake
  // display information about the counter
  temp1 = getTemp();
  byte checksum = ID + temp1;
  
  Serial.write(255); //header
  Serial.write(ID); //ID BYTE
  Serial.write(temp1); //DATA BYTE/S
  Serial.write(checksum);
  
  //Serial.print("I am ");
  //Serial.println(ID);
  delay(3000);
  sleepNow();  
}

int getTemp()
{
  t1 = analogRead(0);
  t1 = t1*1000; //millivolts factor
  t1 = t1/1024; //10-bit range
  t1 = t1*vref; //vref
  temp2 = (t1-500)/10;
  return temp2;
}
