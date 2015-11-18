package xreslo.components;

import xreslo.base.Terminal;

class Resistor extends Terminal {
	var resistance: Float;
	
	public function new(resistance: Float){
		super(_getVoltage, _getCurrent);
		this.resistance = resistance;
	}
	
	function _getCurrent(): Float {
		if(connected) {
			return link.getVoltage() / resistance;
		}
		throw "Resistor unconnected";
		return null;
	}
	
	function _getVoltage(): Float {
		if(connected) {
			return link.getCurrent() * resistance;
		}
		throw "Resistor unconnected";
		return null;
	}
}