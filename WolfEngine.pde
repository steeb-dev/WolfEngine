   
  Player player;
  Map map;
  Camera camera;
  int lastFrameMillis;
  float delta;
  color skycolor;
  color groundcolor;
  
 void setup ()
 {
   groundcolor = color(0);
   skycolor = color(205,70,200);
   
   size(1024, 768);
   this.player = new Player(15.3, -1.2, PI * 0.3);
   this.map = new Map(32);
   this.camera = new Camera(80, PI * 0.4);

   this.map.randomize();
   
   background(groundcolor);
 }
 
 void draw()
 {
   stroke(0);
   fill(0);
   rect(0, height/2, width, height);
   
   stroke(skycolor);
   fill(skycolor);
   rect(0, 0, width, height/2);

   delta = (float)(millis() - lastFrameMillis) / 1000.0;
   lastFrameMillis = millis();
   if(keyPressed)
   {     
     if(key == 'a') player.Rotate(-PI * (float)delta);
     if (key == 'd') player.Rotate(PI * (float)delta);
     if (key == 'w')
     {
       player.Walk(3 * delta, map);
     }
     if (key == 's') player.Walk(-3 * delta, map);
   }
   camera.render(player, map, skycolor);
 }
 