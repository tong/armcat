function main() {
	Sys.println(haxe.Json.stringify(iron.system.ArmPack.decode(sys.io.File.getBytes(Sys.args()[0]))));
}
