import processing.sound.*;
import processing.net.*;



Client c;
String input;
float data[];
ArrayList<PVector> coords = new ArrayList<PVector>();

float origin_x, origin_y;
float prevOriginX, prevOriginY;

float mappedDataX, mappedDataY;

float btnPosX, btnPosY, btnSize;

SoundFile file;



// update

// display


void setup() 
{
  size(800, 800);
  origin_x = width/2;
  origin_y = height/2;

  btnPosX = random(200, width-200);
  btnPosY = random(200, height-200);
  // file = new SoundFile(this, "Email-notification-sound.mp3");

  colorMode(HSB);
  noStroke();
  //frameRate(5); // Slow it down a little
  // Connect to the server's IP address and port
  c = new Client(this, "127.0.0.1", 12345); // Replace with your server's IP and port
}

void draw() 
{
  background(50);
  // Receive data from server
  if (c.available() > 0) {
    //println("0");

    input = c.readString();
    //println(input);
    //println("----");
    if (input != null) {
      //if (input.length() > 1) {
      //  input = input.substring(0, input.indexOf("\n"));
      //}
      String[] inputLines = split(input, '\n');
      data = float(split(inputLines[0], " "));
      if (data.length==2) {
        //println(data[0] + "," + data[1]);

        //coords.add( new PVector(data[0], data[1]) );
        //if (coords.size() > 300) {
        //  coords.remove(0);
        //}

        //int minX = 1000000;
        //int minY = 1000000;
        //int maxX = 0;
        //int maxY = 0;

        //for (int i=0; i<coords.size(); i++) {

        //  int x = int(coords.get(i).x);
        //  int y = int(coords.get(i).y);
        //  if (minX > x) {
        //    minX = x;
        //  }
        //  if (minY > y) {
        //    minY = y;
        //  }
        //  if (maxX < x) {
        //    maxX = x;
        //  }
        //  if (maxY < y ) {
        //    maxY = y;
        //  }



        //  if (minX != maxX && minY !=  maxY) {
        //    mappedDataX = map(x, minX, maxX, 100, 700);
        //    mappedDataY = map(y, minY, maxY, 100, 700);
        //  }

        mappedDataX = constrain(map(data[0], .46, .53, 0, 800), 0, 800);
        mappedDataY = constrain(map(data[1], .42, .49, 0, 800), 0, 800);


        //println( "X Values:  " + "(" + minX + "," + maxX + ")");
        //println( "Y Values:  " + "(" + minY + "," + maxY + ")");
        println( "Mapped Data Coords:  " + "(" + mappedDataX + "," + mappedDataY + ")");


        origin_x = lerp(origin_x, mappedDataX, 0.05);
        origin_y = lerp(origin_y, mappedDataY, 0.05);

        //println( "Origin Coords  " + "(" + origin_x + "," + origin_y + ")");

        float distance = dist(btnPosX, btnPosY, origin_x, origin_y);

        if ( distance < btnSize/2) { // radius
          btnPosX = random(300, width-200);
          btnPosY = random(300, height-200);
          background(200);
          // file.play();
        } else {
          noFill();
        }
      }
    }
  }

  // display
  //__________________________________________ELLIPSE________________________________________________
  //fill((frameCount/10)%45, 100, 255);
  // noStroke();
  // ellipse(origin_x, origin_y, random(2,13),random(3,13));

  //______________________________________LINE________________________________________________
  pushStyle();
  stroke((frameCount/10)%255, 175, 255);
  strokeWeight(25);
  line(prevOriginX, prevOriginY, origin_x, origin_y);
  popStyle();

  //______________________________________Button________________________________________________
  pushStyle();
  btnSize = sin(frameCount*0.02)*60 + 90;
  fill((frameCount/10)%255, 100, 255);
  strokeWeight(16);
  stroke((frameCount/10)%255, 175, 255);
  ellipse(btnPosX, btnPosY, btnSize, btnSize);
  popStyle();


  prevOriginX = origin_x;
  prevOriginY = origin_y;
}
