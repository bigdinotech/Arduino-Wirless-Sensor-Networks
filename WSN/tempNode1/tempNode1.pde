//Dino Tinitigan
//CPE 400
//Outer Node

double temp1;
int temp2;
double vref = 5.04;
byte ID = 2;
byte IDcheck;
byte checksum;
boolean turn = false;
byte incoming;

void setup()
{
  Serial.begin(19200);
}

void loop()
{
  temp1 = analogRead(1);
  temp1 = temp1*1000; //millivolts factor
  temp1 = temp1/1024; //10-bit range
  temp1 = temp1*vref; //vref
  temp2 = (temp1-500)/10;
  
  /**
  Serial.print("The reading is: ");
  Serial.print(temp2);
  Serial.println(" celsius");
  **/
  
  //listen for turn
  turn = false;
  if(Serial.available()>0)
  {
    incoming = Serial.read();
    while((incoming != 255) && (Serial.available()>0)) //wait for the next possible header byte
    {
      incoming = Serial.read();
    }
    incoming = Serial.read();
    if(incoming = 2)
    {
      turn = true;
    }
    else
    {
      turn = false;
    }
  }
  checksum = ID + temp2;
  //turn = true;
  //----------------transmit data-----------------------
  if(turn) //transmit data if it is node's turn
  {
    Serial.write(255); //header byte
    Serial.write(ID); //ID byte
    Serial.write(temp2); //data byte/s
    Serial.write(checksum); //checksum byte
    //Serial.println("Turn Found");
  }
  //----------------transmit data-----------------------
  delay(100);
  
}
