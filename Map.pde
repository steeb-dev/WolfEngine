class Map
{
  int size;
  int[] wallGrid;
  
  Map(int _size)
  {
    size = _size;
    wallGrid = new int[_size * _size];
  }
  
   int get(float x, float y) 
   {
    x = floor(x);
    y = floor(y);
    if (x < 0 || x > size - 1 || y < 0 || y > size - 1) return -1;
    return wallGrid[(int)(y * this.size + x)];
   }  
   
  void randomize() {
    for (int i = 0; i < this.size * this.size; i++) {
      this.wallGrid[i] = random(1.0) <= 0.3 ? 1 : 0;
    }
}
   
  Ray cast(Vec point, float angle, float range) {
    return new Ray(this, new Step(point.x, point.y, 0, 0, 0, 0, 0), sin(angle), cos(angle), range);
  }
}