import haxe.Json;
import haxe.format.JsonPrinter;
import iron.system.ArmPack;
import sys.io.File;
import Sys.println;

function main() {
	var args = Sys.args();
	var path = args.pop();
	/*var pretty:String = null;
		var argHandler = hxargs.Args.generate([@doc("Json format space")
			["--pretty"] => (?str = "  ") -> {
				pretty = str;
			},
			_ => (arg:String) -> {
				println('Unknow option: $arg');
				Sys.exit(1);
			}
		]);
		argHandler.parse(args); */
	var obj = ArmPack.decode(File.getBytes(path));
	// var str = (pretty != null) ? JsonPrinter.print(obj, pretty) : Json.stringify(obj);
	var str = Json.stringify(obj);
	println(str);
}
