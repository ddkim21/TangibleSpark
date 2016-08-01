/*
 * Tangible Spark
 */
part of TangibleSpark;



/**
 * A base class for all electrical components. A component is
 * any element that can be connected in a circuit.
 */
class Component {

  /** Unique component ID */
  String id = "";
   
  /** Name of the statement (e.g. resistor) */
  String name = 'resistor';

  /** Left TopCode for this component */
  TopCode leftCode = new TopCode();
  TopCode rightCode = new TopCode();

  /** Connectors for this component */
  Connector leftJoint;
  Connector rightJoint;


  /** Is this component visible to the camera? */
  bool visible = false;

   
  Component(Map definition) {
    id = definition['id'];
    name = definition['name'];
    leftCode.code = definition['left-code'];
    rightCode.code = definition['right-code'];
    leftJoint = new Connector(this);
    rightJoint = new Connector(this);
  }


  bool isConnectedTo(Component other) {
    return (leftJoint.isConnectedTo(other) || rightJoint.isConnectedTo(other));
  }

  
/**
 * See if this component is visible to the camera by matching left or right 
 * topcode (or both).
 */
  void locate(List<TopCode> codes) {

    visible = false;


    for (TopCode top in codes) {
      if (top.code == leftCode.code) {
        _initLocation(top, leftCode, rightCode, 2.8);
      }
      else if (top.code == rightCode.code) {
        _initLocation(top, rightCode, leftCode, -2.8);
      }
    }

    // fine tune orientations of the left and right code 
    {
      num between = rightCode.angleBetween(leftCode);
      leftCode.orientation = between;
      rightCode.orientation = between;
    }

    // set connector positions
    {
      leftJoint.x = leftCode.targetX(-1.25, 0);
      leftJoint.y = leftCode.targetY(-1.25, 0);
      leftJoint.radius = leftCode.radius / 2;
      leftJoint.clear();
      rightJoint.x = rightCode.targetX(1.25, 0);
      rightJoint.y = rightCode.targetY(1.25, 0);
      rightJoint.radius = rightCode.radius / 2;
      rightJoint.clear();
    }
  }    


/**
 * Try to connect to this component if they aren't already connected
 */  
  bool connect(Component other) {

    // already connected!
    if (isConnectedTo(other)) return true;

    // try all four combinations for connections
    if (rightJoint.connect(other.rightJoint)) return true;
    if (rightJoint.connect(other.leftJoint)) return true;
    if (leftJoint.connect(other.rightJoint)) return true;
    if (leftJoint.connect(other.leftJoint)) return true;

    return false;
  }


  void _initLocation(TopCode found, TopCode match, TopCode opposite, num dx) {
    match.copyFrom(found);
    if (!visible) {
      opposite.x = match.targetX(dx, 0);
      opposite.y = match.targetY(dx, 0);
      opposite.orientation = match.orientation;
      opposite.unit = match.unit;
    }

    // we've found at least one topcode, so this component is visible
    visible = true; 

    // mark the original topcode so that we don't use it again
    found.code = -1;
  }

  
  void draw(CanvasRenderingContext2D ctx) {
    leftCode.draw(ctx);
    rightCode.draw(ctx);
    leftJoint.draw(ctx);
    rightJoint.draw(ctx);
  }
  
}  
