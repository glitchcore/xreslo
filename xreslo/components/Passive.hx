package xreslo.components;

import xreslo.base.Terminal;

class Resistor extends Terminal {
	var resistance: Float;
	
	public function new(resistance: Float){
		super();
		this.resistance = resistance;
	}
	
	override public function getCurrent(): Float {
		if(connected) {
			return link.getVoltage() / resistance;
		}
		trace("Resistor unconnected");
		return null;
	}
	
	override public function getVoltage(): Float {
		if(connected) {
			return link.getCurrent() * resistance;
		}
		trace("Resistor unconnected");
		return null;
	}
}