

class Diode {
	var IS: Float;
	var V: Float;
	var T: Float;
	var N: Float;
	
	public function new(IS, N, BV) {
	}
	
	public function new(Vnom) {
	}
	
	public function new() {
	}
	
	public function getCurrent(): Float {
		if(V < BV) {
			return IS * (exp((Xreslo.Q * V) / (N * Xreslo.k * T)) - 1);
		} else {
			return -inf;
		}
	}
}

class LED extends Diode {
	public function new() {
		super();
	}
	
}