
import java.util.ArrayList;
import java.util.List;

public class Ray {
  protected Map map;
  protected float sin;
  protected float cos;
  protected List<Step> steps;

  public Ray(Map map, Step origin, float sin, float cos, float range) {
    this.steps = new ArrayList<Step>();
    this.map = map;
    this.sin = sin;
    this.cos = cos;

    this.cast(origin, range);
  }

  protected void cast(Step origin, float range) {
    Step stepX = step(sin, cos, origin.x, origin.y, false);
    Step stepY = step(cos, sin, origin.y, origin.x, true);
    Step nextStep = stepX.length2 < stepY.length2
      ? inspect(stepX, 1, 0, origin.distance, stepX.y)
      : inspect(stepY, 0, 1, origin.distance, stepY.x);

    this.steps.add(origin);
    if (nextStep.distance < range) {
      this.cast(nextStep, range);
    }
  }

  protected Step step(float rise, float run, float x, float y, boolean inverted) {
    if (run == 0) return new Step(0.0, 0.0, 0.0, 0.0, (float)Double.POSITIVE_INFINITY, 0.0, 0.0);
    float dx = run > 0 ? floor(x + 1) - x : ceil(x - 1) - x;
    float dy = dx * (rise / run);
    return new Step(inverted ? y + dy : x + dx, inverted ? x + dx : y + dy, 0, 0, dx * dx + dy * dy, 0, 0);
  }

  protected Step inspect(Step step, float shiftX, float shiftY, float distance, float offset) {
    float dx = cos < 0 ? shiftX : 0;
    float dy = sin < 0 ? shiftY : 0;
    step._height = map.get(step.x - dx, step.y - dy);
    step.distance = distance + sqrt(step.length2);
    if (shiftX == 1) step.shading = cos < 0 ? 2 : 0;
    else step.shading = sin < 0 ? 2 : 1;
    step.offset = offset - floor(offset);
    return step;
  }
}