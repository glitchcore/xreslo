import xreslo.base.Terminal.VoltageOut;
import xreslo.base.Terminal;
// import components.Diode;
import xreslo.components.Passive;
import xreslo.Xreslo.connect;

/*
class VoltageDrivenLed {
	var v2c:seriesZ;
	var led: LED;
	
	public function new(current: Float) {
		
		Xreslo.connect(v2c, led);
	}
	
	public function setCurrent(current: Float) {
		v2c.setCurrent(current);
	}
	
	public function getCurrent() {
	  
	}
	public function connect(src: VoltageTerminal): Bool {
		v2c. = src.voltage;
	}
  
}
*/

class Button {
	var state: Bool;
	
	public var a: Terminal;
	public var b: Terminal;
	
	public function new() {
		state = false;
	}
	
	public function set(state: Bool) {
		this.state = state;
	}
}

class Blinker {
	var load:Resistor;
	var button:Button;
	var battery:VoltageOut;
	
	public function new() {
		load = new Resistor(910); // nominal in Ohm
		button = new Button();
		battery = new VoltageOut(3.0, 1.2); // voltage, maxCurrent
		
		connect(load, button.a);
		connect(battery, button.b);
		
		button.set(true);
		
		trace('battery current = ${battery.getCurrent()}');
		
		button.set(false);
		
		trace('battery current = ${battery.getCurrent()}');
	}
}