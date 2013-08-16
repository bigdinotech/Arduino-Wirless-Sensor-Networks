//Dino Tinitigan
//CPE 400
//Central Node

byte masterID = 99;
byte nodeID = 1;
byte members[5] = {5,6,7,8,9};
int memcount = 5;
int y;
byte ACK;

void setup()
{
  Serial.begin(9600);
}

void loop()
{
  byte data[memcount];
  ACK = 0;
  y = 0;
  //Ask data from members
  for(int x = 0; x < memcount; x++)
  {
    //if data is not valid send 0
    //ask for retrans if not received
  }
  
  //------------------Send data to master--------------------
  Serial.write(255); //header byte
  Serial.write(masterID);
  //-------------data-------------
  for(int x = 0; x < memcount; x++)
  {
    Serial.write(members[x]); //ID of data
    Serial.write(data[x]);
  }
  //time stamp?
  Serial.write(255);  //trailer byte
  //------------------Send data to master--------------------
  
  //wait for ACK else retransmit
  //Main will respond 10x
  int tries = 0;
  while((ACK != 255) || (tries <10))
  {
    delay(100);
    if(Serial.available())
    {
      ACK = Serial.read();
    }
    tries++;
  }
  if(ACK!=255)
  {
    //retransmit once but dont wait for ACK this time
  }
  
  Serial.flush();
  
}
