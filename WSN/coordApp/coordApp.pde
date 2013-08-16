//Dino Tinitigan 
//CPE 400
//Coordinator Application

import processing.serial.*;

int incoming;
int numMembers = 5;
int[] members = {2,3,4,5,6};
int[] values = new int[5];
int checksum;
int t = 5;
int ID;

Serial myPort;

//----File IO---------
PrintWriter output;

void setup()
{
  myPort = new Serial(this, Serial.list()[1], 9600); 
  println(Serial.list());
  
  textSize(30);
  size(800, 600);
  background(80, 120, 255);
  
  //-------------------setup File IO-------------------
  output = createWriter("log.csv");
  output.print("Time,");
  for(int i = 0; i < numMembers; i++)
  {
    output.print("Node " + i + ",");
  }
  output.println();
  //-------------------setup File IO-------------------
}

void draw()
{
  //delay for t secs
  print("Waiting for ");
  print(t);
  println(" seconds");
  delay(1000*t);
  output.print(millis() +",");
  //-------------------------ask and receive data from members-----------------------------------
  for(int i = 0; i<numMembers; i++)
  {
    int tID = members[i];
    print("polling: ");
    println(tID);
    
    myPort.write('A'); //send byte to wake nodes
    delay(5);
    myPort.write(255); //header
    delay(5);
    myPort.write(tID);
    myPort.clear();
    delay(6000);//allow the remote node time to wakeup and respond;
    if(myPort.available()>0) //response received
    {
      incoming = myPort.read();
      if(incoming == 255)
      {
        //header received
        println("----------header received-----------");
        delay(5);
        incoming = myPort.read();
        if(incoming == members[i]) //ID match
        {
          println("ID match");
          delay(5);
          ID = incoming;
          incoming = myPort.read(); //read actual value
          values[i] = incoming;
          
          checksum = values[i] + ID; //calculate checksum
          incoming = myPort.read(); //read checksum BYTE
          if(checksum == incoming)
          {
	    print("Temp is: ");
	    println(values[i]);
	    print("Time since start is: ");
	    println(millis());
	    updateValue(ID, values[i]);
	  }
	  else
	  {
	    println("checksum error");
            output.print(",");
	  }
          
        }
      }
      else
      {
        println("header error");
        output.print(",");
      }
    }
    else //no response
    {
      println("no response");
      output.print(",");
    }
    //update table
    
    myPort.clear();
  }
  output.println();
  //-------------------------------------------------------------------------------------------------------
  
  //-------------------log values into file---------------------------------
  for(int i = 0; i <numMembers; i++)
  {
  }
  //------------------------------------------------------------------------
}

void updateValue(int ID, int val)
{
  switch(ID)
  {
    case 2:
    {
      //draw box
      fill(0,255,0);
      rect(10,10,200, 100);
      fill(0);
      text("Node: " + ID, 30, 40);
      text(val + " C", 30, 100);
      break;
    }
    case 3:
    {
      fill(0,255,0);
      rect(10,240,200, 100);
      fill(0);
      text("Node: " + ID, 30, 40);
      text(val + " C", 30, 100);
      //output.print(val +",");
      break;
    }
    case 4:
    {
      break;
    }
    case 5:
    {
      break;
    }
    case 6:
    {
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
    output.close();
    exit();
  }
}

