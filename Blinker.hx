import base.Terminal;

class LED {
	public function new() {
	  
	}
	public function setCurrent() {
	  
	}
	public function getCurrent() {
	  
	}
	public function connect() {
		
	}
  
}
class Button {

}
class Blinker {
	var led:VoltageDrivenLed;
	var button:Button;
	var battery:VoltageTerminal;
	
	public function new() {
		led = new VoltageDrivenLed(0.14); // nominal current of led
		button = new Button();
		battery = new VoltageTerminal(3.0, 1.2); // voltage, maxCurrent
		
		connect(led, button);
		connect(battery, button);
		
		button.set(true);
		
		trace("battery current = $1", battery.getCurrent());
		
		button.set(false);
		
		trace("battery current = $1", battery.getCurrent());
	}
}