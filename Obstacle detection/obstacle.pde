//Obstacle Avoiding robot
const int left=1,mid=2,right=3;
const int i1=8,i2=10,ea=9,i3=5,i4=7,eb=6;
const int cthres=600,rthres=600,lthres=600;
int s1=0;
int s2=0;
int s3=0;
int r;

void setup()
{
  Serial.begin(9600);
  pinMode(i1,OUTPUT);
  pinMode(i2,OUTPUT);
  pinMode(ea,OUTPUT);
  pinMode(13,OUTPUT);
  pinMode(i4,OUTPUT);
  pinMode(eb,OUTPUT);
}

void updateS()
{
  s1=analogRead(left);
  s2=analogRead(mid);
  s3=analogRead(right);
}

void moveforward()
{
 analogWrite(ea,200);
 analogWrite(eb,200);
 digitalWrite(i2,LOW);
 digitalWrite(i1,HIGH);
 digitalWrite(i4,LOW);
 digitalWrite(i3,HIGH); 
}

void turnleft()
{
  analogWrite(ea,150);
  analogWrite(eb,150);
  digitalWrite(i1,LOW);
  digitalWrite(i2,HIGH);
  digitalWrite(i4,LOW);
  digitalWrite(i3,HIGH);
}

void turnright()
{
  analogWrite(eb,150);
  analogWrite(ea,150);
  digitalWrite(i2,LOW);
  digitalWrite(i1,HIGH);
  digitalWrite(i3,LOW);
  digitalWrite(i4,HIGH);
}  

void loop()
{ 
  moveforward();
  
  updateS();
  
  if(s2>cthres)
  {
    randomSeed(analogRead(0));
    r=random(3000);
    if(r%2==0)
        turnright();
    else
        turnleft();
    while((s3>rthres-10||s2>cthres-10))
    {
      updateS();
      delay(10);
    }
    moveforward();
  }
  
  if((s3>rthres)||((s3>rthres)&&(s2>cthres)))
  {
    turnleft();
    while(s3>rthres-10)
    {
      updateS();
      delay(10);
    }
    moveforward();
  }
  
  if((s1>lthres)||((s1>lthres)&&(s2>cthres)))
  {
    turnright();
    while(s1>lthres-10)
    {
      updateS();
      delay(10);
    }
    moveforward();
  }
    
}
