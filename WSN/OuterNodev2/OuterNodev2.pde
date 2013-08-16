//Dino Tinitigan
//CPE 400
//Outer Node

byte nodeID = 5;
byte centralID = 1;
byte buff[15];
byte checksum;
int i;
int temperature;
byte temp2;
boolean timeout = false;
unsigned int prevT;
unsigned int currentT;
unsigned int diff;
boolean valid;


void setup()
{
  Serial.begin(9600);
}

void loop()
{
  //gather sensor data
  
  i = 0;
  checksum = 0;  //reset checksum
  
  //wait for ID to be called
  if(Serial.available())
  {
    //check for header
    buff[i] = Serial.read(); 
  }
  
  prevT = millis();
  /**
  while((buff[i] != 255) && (Serial.available()) && (!timeout))//keep looping till header is detected or timesout
  {
    buff[i] = Serial.read();
    diff = millis() - prevT;
    if(diff >= 5000) //5 sec timeout
    {
      timeout = true;
    }
  }
  **/
  
  if(buff[i] == 255)
  {
    i++;
  
    if(Serial.available())
    {
      //read for ID
      buff[i] = Serial.read();
    
      if(buff[i] == nodeID)//check if message is for this node
      {
        checksum = checksum + buff[i];
        i++;
        //read checksum byte
        if(Serial.available())
        {
          buff[i] = Serial.read();
          if(buff[i] == checksum)
          {
            //------------------------------transmit data--------------------------
            checksum = centralID + temp2;
            Serial.write(255);  //header byte
            Serial.write(centralID);  //ID byte
            Serial.write(temp2);  //data
            Serial.write(checksum);  //checksum byte
            //------------------------------transmit data--------------------------  
          }
        }    
      }     
    }
  } 
  Serial.flush(); //clear serial buffer
  
}
