package xreslo.base;

import xreslo.utils.Guid;
import xreslo.Xreslo;
import xreslo.Xreslo.connect;

class Node {
	public var guid(default, null): String;
	public function new() {
		guid = Guid.generate();
	}
}

interface Connectable {
	public function getCurrent():Float;
	public function getVoltage():Float;
	public function connect(b: Connectable): Bool;
}

class Terminal implements Connectable {
	public var a(default, null): Node;
	public var b(default, null): Node;
	
	public var connected: Bool;
	public var link(default,null): Connectable;
	
	var getCurrentFunction: Void->Float;
	var getVoltageFunction: Void->Float;
	
	public function new(getVoltageFunction: Void->Float, getCurrentFunction: Void->Float) {
		connected = false;
		a = new Node();
		b = new Node();
		
		this.getCurrentFunction = getCurrentFunction;
		this.getVoltageFunction = getVoltageFunction;
		
		Xreslo.VerilogAMS('inout ${a.guid}, ${b.guid};');
		Xreslo.VerilogAMS('electrical ${a.guid}, ${b.guid};');
	}
	
	public function connect(b: Connectable): Bool {
		connected = true;
		link = b;
		return true; // TODO check types
	}
	
	public function getCurrent():Float {
		if(getCurrentFunction == null) {
			trace("unimplemented get current");
			return null;
		} else {
			return getCurrentFunction();
		}
	}
	
	public function getVoltage():Float {
		if(getVoltageFunction == null) {
			trace("unimplemented get voltage");
			return null;
		} else {
			return getVoltageFunction();
		}
	}
}

class VoltageOut extends Terminal  {
	var maxCurrent: Float;
	var impedance: Float;
	var voltage: Float;
	
	public function new(voltage:Float, maxCurrent: Float) {
		super(_getVoltage, _getCurrent);
		this.voltage = voltage;
		this.maxCurrent = maxCurrent;
		// maxCurrent = voltage / impedance;
	}
	
	public function setVoltage(terminal:Terminal) {
		// VerilogAMS('V(${a.guid},$1) <+ V($2,$3)', b.a.GUID, terminal.a.GUID, terminal.b.GUID);
	}
	function _getCurrent():Float {
		if(connected) {
			if(link.getCurrent() < maxCurrent) {
				return link.getCurrent();
			} else {
				trace('current ${link.getCurrent()} A overload (max ${maxCurrent} A)');
				return link.getCurrent();
			}
		} else {
			trace("unconnected voltageOut");
			return null;
		}
	}
	function _getVoltage():Float {
		return voltage;
	}
}

/*
class CurrentOut extends Terminal {
	var maxVoltage: Float;
	var admittance: Float;
	var useAdmittance: Bool;
	
	public function new() {
		super();
		maxVoltage = current * admittance;
		useAdmittance = true;
	}
	
	public function setAdmittance(y:Float) {
		admittance = y;
		useAdmittance = true;
	}
	
	public function setMaxVoltage(v:Float) {
		maxVoltage = y;
		useAdmittance = false;
	}
	
	
	public function setCurrent(v:Float) {
		VerilogAMS('I($1,$2) <+ $3', , a.GUID, b.a.GUID);
	}
	public function setCurrent(terminal:Terminal) {
		VerilogAMS('I($1,$2) <+ I($3,$4)', a.GUID, b.a.GUID, terminal.a.GUID, terminal.b.GUID);
	}
}
*/