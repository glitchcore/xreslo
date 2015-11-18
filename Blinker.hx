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
		a = new Terminal(
			function() { if(state) return _getVoltage(b); else return 0; },
			function() { if(state) return _getCurrent(b); else return 0; }
		);
		b = new Terminal(
			function() { if(state) return _getVoltage(a); else return 0; },
			function() { if(state) return _getCurrent(a); else return 0; }
		);
		state = false;
	}
	
	
	function _getCurrent(self: Terminal):Float {
		if(self.connected) {
			return self.link.getCurrent();
		} else {
			trace("unconnected button");
			return null;
		}
	}
	function _getVoltage(self: Terminal):Float {
		if(self.connected) {
			return self.link.getVoltage();
		} else {
			trace("unconnected button");
			return null;
		}
	}
	
	public function set(state: Bool) {
		this.state = state;
	}
}

class Blinker {

	public function new() {
		var load = new Resistor(910); // nominal in Ohm
		var button = new Button();
		var battery = new VoltageOut(3.0, 1.2); // voltage, maxCurrent
		
		var LVDSload = new Resistor(50); // nominal in Ohm
		var LVDSsource = new CurrentOut(0.01, 5);
		
		connect(LVDSload, LVDSsource);
		
		connect(load, button.a);
		connect(battery, button.b);
		// connect(battery, load); // direct connect
		
		button.set(true);
		
		trace('battery current = ${battery.getCurrent()}');
		
		button.set(false);
		
		trace('battery current = ${battery.getCurrent()}');
		
		trace('LVDS load voltage = ${LVDSload.getVoltage()}');
		
	}
}