package xreslo;
import xreslo.base.Terminal.Connectable;

class Xreslo {

	public static function connect(a: Connectable, b: Connectable): Bool {
		// call both connect method
		if(!a.connect(b)) {
			throw "cannot connect b to a";
		}
		if(!b.connect(a)) {
			throw "cannot connect a to b";
		}
		return true;
	}
	
	public static function VerilogAMS(s: String) {
		trace("[V-AMS] " + s);
	}
	
}