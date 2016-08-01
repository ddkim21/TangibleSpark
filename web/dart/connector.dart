/*
 * Tangible Spark
 */
part of TangibleSpark;



/**
 * A multi-way connector for components.
 */
class Connector {

  num x = 0, y = 0, radius = 0;

  Component parent;

  List<Component> components = new List<Component>();

   
  Connector(this.parent);


  void clear() {
    components.clear();
  }


  bool isConnected() {
    return components.isNotEmpty;
  }


  bool isConnectedTo(Component c) {
    return components.contains(c);
  }


  bool overlaps(Connector other) {
    return sqrt((other.x - x) * (other.x - x) + (other.y - y) * (other.y - y)) < radius * 2.5;
  }


  bool connect(Connector other) {
    if (other.parent != parent && overlaps(other) && !isConnectedTo(other.parent)) {
      components.add(other.parent);
      other.components.add(parent);
      return true;
    } else {
      return false;
    }
  }

  
  void draw(CanvasRenderingContext2D ctx) {
    ctx.fillStyle = isConnected() ? "rgba(0, 255, 0, 0.5)" : "rgba(255, 0, 0, 0.5)";
    ctx.beginPath();
    ctx.arc(x, y, radius, 0, PI * 2, true);
    ctx.fill();
  }
}  
