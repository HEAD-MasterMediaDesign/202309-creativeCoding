import oscP5.*;  
import netP5.*;
import java.lang.reflect.Method;

interface OscEventListener {
  void onOscEvent(String eventName);
}

class OscBridge {
  OscP5 oscP5;
  NetAddress myRemoteLocation;
  Object parent;

  OscBridge(int listeningPort, int sendingPort, Object parent){

    /* start oscP5, listening for incoming messages at port ... */
    oscP5 = new OscP5(this, listeningPort);

    /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
    * an ip address and a port number. myRemoteLocation is used as parameter in
    * oscP5.send() when sending osc packets to another computer, device, 
    * application. usage see below. for testing purposes the listening port
    * and the port of the remote location address are the same, hence you will
    * send messages back to this sketch.
    */
    myRemoteLocation = new NetAddress("127.0.0.1", sendingPort);

    this.parent = parent;
  }

  void send(String eventName){
    OscMessage myMessage = new OscMessage("/" + eventName);
    /* send the message */
    oscP5.send(myMessage, myRemoteLocation);
  }

  /* incoming osc message are forwarded to the oscEvent method. */
  void oscEvent(OscMessage theOscMessage) {

    /* print the address pattern and the typetag of the received OscMessage */
    // print("### received an osc message.");
    // print(" adress: "+theOscMessage.addrPattern());
    // println(" typetag: "+theOscMessage.typetag());

    try {
      Class parentClass =  parent.getClass();
      Method method = parent.getClass().getMethod("oscEvent", String.class);
      method.invoke(parent, theOscMessage.addrPattern().replace("/", ""));
    }
    catch (Exception e) {
      // no such method, or an error.. 
      println("Calling oscEvent failed");
      e.printStackTrace();
    }
  }
}