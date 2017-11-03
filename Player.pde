class Player
{
  Vec position;
  float direction;
  
  Player(float x, float y, float dir)
  {
    position = new Vec(x,y);
    direction = dir;
  }
  
  void Rotate(float angle)
  {
    direction = (direction + angle + (PI * 2)) % (PI * 2);    
  }
  
  void Walk(float distance, Map map)
  {
    float dx = cos(direction) * distance; //<>//
    float dy = sin(direction) * distance;
    if(map.get(position.x + dx, position.y) <= 0)
    {
      position.x += dx; //<>//
    }
    if(map.get(position.x, position.y + dy) <= 0) 
    {
      position.y += dy;    
    }
  }
  
}