package xreslo;
import xreslo.base.Terminal.Connectable;

class Xreslo {

	public static function connect(a: Connectable, b: Connectable): Bool {
		// call both connect method
		if(!a.connect(b)) {
			return false;
		}
		if(!b.connect(a)) {
			return false;
		}
		return true;
	}
	
	public static function VerilogAMS(s: String) {
		trace("[V-AMS] " + s);
	}
	
}