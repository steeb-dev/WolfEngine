public class Step {
  protected float x;
  protected float y;
  protected float _height;
  protected float distance;
  protected float length2;
  protected float shading;
  protected float offset;

  public Step(float x, float y, float h, float distance, float length2, float shading, float offset) {
    this.x = x;
    this.y = y;
    this._height = h;
    this.distance = distance;
    this.length2 = length2;
    this.shading = shading;
    this.offset = offset;
  }
}