//Dino Tinitigan
//CPE 400
//Main applicatino

import processing.serial.*;

int incoming;
int checksum;
int temp;
boolean valid;
int tempID;
int tVal;
int inv = -1;

Serial myPort; //serial porrt object

void setup()
{
  myPort = new Serial(this, Serial.list()[1], 19200); 
  print("Temperature WSN v.01");
  println(Serial.list());
  size(800, 600);
  background(80, 120, 255);
  textSize(20);
  
}

void draw()
{
  askData(2);
  temp = readData();
  if(temp!=inv)
  {
    println("Valid data received");
    background(80, 120, 255);
    println(temp);
    textSize(40);
    fill(0);
    text(temp, 300, 300);
  }
  else
  {
    println("Invalid data received");
    println(temp);
  }
}

void askData(int ID)
{
  myPort.write(255);
  myPort.write(ID);
  delay(1000); //allow time for response
}

int readData()
{
  if(myPort.available()>0)
  {
    incoming = myPort.read(); //check for header byte
    while((incoming != 255) && (myPort.available()>0)) //wait for the next possible header byte
    {
      incoming = myPort.read();
      println(incoming);
    }
    if(incoming == 255)
    {
      println("---------Header Found----------------");
      tempID = myPort.read(); // IDbyte
      tVal = myPort.read(); //dataByte
      checksum = tempID + tVal;
      if(checksum == myPort.read())
      {
        valid = true;
      }
      else
      {
        valid = false;
      }
    }
    else
    {
      valid = false;
    }
  }
  if(valid)
  {
    return tVal;
  }
  else
  {
    return inv;
  }
}

void displayData(int ID, int data)
{
}
