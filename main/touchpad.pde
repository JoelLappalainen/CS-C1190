class Touchpad implements Observer {
  
  private static final int MAX_FINGER_BLOBS = 20;

  private int width, height;
  
  TouchpadObservable tpo;
  
  Finger blobs[] = new Finger[MAX_FINGER_BLOBS];

  public Touchpad(int width, int height) { 
    this.width = width;
    this.height=height;
    tpo = TouchpadObservable.getInstance();
    tpo.addObserver(this);
  }

  // Multitouch update event 
  public void update( Observable obj, Object arg ) {
    // The event 'arg' is of type: com.alderstone.multitouch.mac.touchpad.Finger
    Finger f = (Finger) arg;
    int id = f.getID();
    if (id <= MAX_FINGER_BLOBS)
      blobs[id-1]= f;
  } 

  public void update() {}

  public void draw() {

    for (int i=0; i<MAX_FINGER_BLOBS;i++) {
      Finger f = blobs[i];
      if (f != null && f.getState() == FingerState.PRESSED) {

        int x     = (int) (width  * (f.getX()));
        int y     = (int) (height * (1-f.getY()));
        int xsize = (int) (10*f.getSize() * (f.getMajorAxis()/2));
        int ysize = (int) (10*f.getSize() * (f.getMinorAxis()/2));
        int ang   = f.getAngle();
        
        for (int j=i+1; j<MAX_FINGER_BLOBS;j++) {          
          Finger f2 = blobs[j];
          if(f2 != null && f2.getState() == FingerState.PRESSED) {
            float dy = f.getYVelocity();
            float dy2 = f2.getYVelocity();
            if((dy+dy2)/2 > 0.3) {
              swipeUp();
            } else if((dy+dy2)/2 < -0.3) {
              swipeDown();
            }
          }
        }
        
        /*pushMatrix();
          translate(x-xsize/2, y-ysize/2);
          pushMatrix();
            rotate(radians(-ang));  // convert degrees to radians
            fill(255);
            ellipse(0,0,xsize,ysize);
          popMatrix();
          fill(255,0,0);
          text(""+i,0,0);
        popMatrix(); */
      }
    }
  }
}

void swipeUp() {
  if(start) {
    dataIndex--;
    if (dataIndex < 0) dataIndex = nOfStats-1;
  }
}

void swipeDown() {
  if(start) {
    dataIndex++;
    if (dataIndex >= nOfStats) dataIndex = 0;
  }
}