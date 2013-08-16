//Dino Tinitigan 
//CPE 400
//Coordinator Application

import processing.serial.*;

int incoming;
int nodeID;
int value;
int numMembers = 5;
int[] members = {2,3,4,5,6};
int[] values = new int[5];
int checksum;
int t = 5;
int ID;

Serial myPort;

//----File IO---------
//use hour(), minute(), seconds();
//ude date()
PrintWriter output;

void setup()
{
  myPort = new Serial(this, Serial.list()[0], 9600); 
  println(Serial.list());
  
  textSize(30);
  size(800, 600);
  background(80, 120, 255);
  
  //-------------------setup File IO-------------------
  output = createWriter("log.csv");
  
  output.print("Date and Time," + "millis since start,");
  for(int i = 0; i < numMembers; i++)
  {
    output.print("Node " + i + ",");
  }
  output.println();
  //-------------------setup File IO-------------------
}

void draw()
{
  if(myPort.available()>0) //data is on serial port
  {
    incoming = myPort.read();
    println("Data Received");
    while((incoming != 255) && myPort.available()>0) //look for header if their is data on serial port
    {
      incoming = myPort.read();
    }
    
    if(incoming == 255) //header found
    {
      //header received
      println("----------header received-----------");
      nodeID = myPort.read(); //read ID
      value = myPort.read();  //read data
      println("Node " + nodeID);
      println(value + " C");
      updateValue(nodeID, value);
    }
  }
  //-------------------------------------------------------------------------------------------------------
}

void updateValue(int ID, int val)
{
  switch(ID)
  {
    case 2:
    {
      int check = myPort.read();
      checksum = ID + val;
      if(checksum >=256)
      {
        checksum = checksum - 256;
      }
      if(checksum == check)
      {
        //draw box
        fill(0,255,0);
        rect(10,10,200, 100);
        fill(0);
        text("Node: " + ID, 30, 40);
        text(val + " C", 30, 100);
        output.print(month() + "/" + day() + "/" + year() + "/" + hour() + ":" + minute() + ":" + second() + "," + millis());
        output.println("," + val);
      }
      break;
    }
    case 3:
    {
      int check = myPort.read();
      checksum = ID + val;
      if(checksum >=256)
      {
        checksum = checksum - 256;
      }
      if(checksum == check)
      {
        fill(0,255,0);
        rect(10,200,200, 100);
        fill(0);
        text("Node: " + ID, 30, 225);
        text(val + " C", 30, 285);
        output.print(month() + "/" + day() + "/" + year() + "/" + hour() + ":" + minute() + ":" + second() + "," + millis());
        output.println(",," + val);
      }
      break;
    }
    case 4:
    {
      int check = myPort.read();
      checksum = ID + val;
      if(checksum >=256)
      {
        checksum = checksum - 256;
      }
      if(checksum == check)
      {
        //draw box
        fill(0,255,0);
        rect(200,10,200, 100);
        fill(0);
        text("Node: " + ID, 220, 40);
        text(val + " C", 220, 100);
        output.print(month() + "/" + day() + "/" + year() + "/" + hour() + ":" + minute() + ":" + second() + "," + millis());
        output.println(",,," + val);
      }
      break;
    }
    case 5:
    {
      int check = myPort.read();
      checksum = ID + val;
      if(checksum >=256)
      {
        checksum = checksum - 256;
      }
      if(checksum == check)
      {
        fill(0,255,0);
        rect(200,200,200, 100);
        fill(0);
        text("Node: " + ID, 220, 225);
        text(val + " C", 220, 285);
        output.print(month() + "/" + day() + "/" + year() + "/" + hour() + ":" + minute() + ":" + second() + "," + millis());
        output.println(",,,," + val);
      }
      break;
    }
    case 6:
    {
      int check = myPort.read();
      checksum = ID + val;
      if(checksum >=256)
      {
        checksum = checksum - 256;
      }
      if(checksum == check)
      {
        //draw box
        fill(0,255,0);
        rect(490,10,200, 100);
        fill(0);
        text("Node: " + ID, 510, 40);
        text(val + " C", 510, 100);
        output.print(month() + "/" + day() + "/" + year() + "/" + hour() + ":" + minute() + ":" + second() + "," + millis());
        output.println(",,,,," + val);
      }
      break;
    }
    default:
    {
    }
  }
  if(key=='x')
  {
    output.close();
    exit();
  }
}

void keyPressed()
{
  println("key pressed");
  if(key=='x')
  {
    exit();
  }
}

void stop()
{
  output.close();
  super.stop();
}

