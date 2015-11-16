class Node {
	public var GUID:String;
	public function new() {
		GUID = makeGUID();
	}
}

class Terminal {
	public var a: Node;
	public var b: Node;
	
	var connected: Bool;
	
	public function new() {
		a = new Node();
		b = new Node();
		VerilogAMS('inout $1, $2;', a.GUID, b.a.GUID);
		VerilogAMS('electrical $1, $1;', a.GUID, b.a.GUID);
	}
}

class VoltageOut extends Terminal {
	var maxCurrent: Float;
	var impedance: Float;
	var voltage: Float;
	
	public function new() {
		super();
		maxVoltage = current * admittance;
	}
	
	public function setVoltage(v:Float) {
		VerilogAMS('V($1,$2) <+ $3', , a.GUID, b.a.GUID, );
	}
	public function setVoltage(terminal:Terminal) {
		VerilogAMS('V($1,$2) <+ V($3,$4)', a.GUID, b.a.GUID, terminal.a.GUID, terminal.b.GUID);
	}
	public function getCurrent():Float;
}

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