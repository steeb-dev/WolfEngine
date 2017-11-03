public class Camera {
  protected float resolution;
  protected float spacing;
  protected float fov;
  protected float range;
  protected float lightRange;
  protected float scale;

  public Camera(float resolution, float fov) {
    this.resolution = resolution;
    this.spacing = width / resolution;
    this.fov = fov;
    this.range = 14;
    this.lightRange = 5;
    this.scale = (width + height) / 1200;
  }

  public void render(Player player, Map map, color sky) {
    stroke(255);
    fill(0);
    this.drawColumns(player, map, sky);
  }
 

  private void drawColumns(Player player, Map map, color sky) {
    for (int column = 0; column < this.resolution; column++) {
      float angle = this.fov * (column / this.resolution - 0.5);
      Ray ray = map.cast(player.position, player.direction + angle, this.range);
      this.drawColumn(column, ray, angle, map, sky);
    }
  }

  private void drawColumn(float column, Ray ray, float angle, Map map, color sky) 
  {
    float left = floor(column * this.spacing);
    float _width = ceil(this.spacing);
    int hit = -1;

    while (++hit < ray.steps.size() && ray.steps.get(hit)._height <= 0);

    for (int s = ray.steps.size() - 1; s >= 0; s--) {
      Step step = ray.steps.get(s);

      if (s == hit) 
      {
        Projection wall = this.project(step._height, angle, step.distance);
        stroke(255);
        fill(0);
        rect(left, wall.top, _width, wall._height);
        stroke(sky);
        fill(sky);
        rect(left, 0, _width, height - (wall.top + wall._height));  
        return;
      }
    }
  
    stroke(sky);
    fill(sky);
    rect(left, 0, _width, height /2);  
    }
  

  private Projection project(float _h, float angle, float distance) {
    float z = distance * cos(angle);
    float wallHeight = height * _h / z;
    float bottom = height / 2 * (1 + 1 / z);
    return new Projection(bottom - wallHeight, wallHeight);
  }
}