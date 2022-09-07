using StringTools;
using haxe.io.Path;

function main() {
    var space : String = "  ";
    var noFormat = false;
    var file : String = null;
    var argsHandler : { getDoc: Void->String, parse: Array<String>->Void } = null;
    function usage() {
        Sys.println('Usage: armcat <file.arm> [options]\n\nOptions:');
        for(l in argsHandler.getDoc().split('\n')) Sys.println('  $l');
    }
    argsHandler = hxargs.Args.generate([
	    @doc("String to use for json formatting")
	    ["--format"] => (str:String) -> {
            if(str == null) {
                Sys.println('Missing argument value');
                Sys.exit(1);
            }
            space = str;
	    },
	    @doc("Do not json format output")
	    ["--no-format"] => () -> {
            noFormat = true;
	    },
	    @doc("Print usage")
	    ["--help"] => () -> {
            usage();
            Sys.exit(0);
	    },
	    _ => (arg:String) -> {
            if(!arg.startsWith('--') && arg.extension() == 'arm') {
                file = arg;
                if(!sys.FileSystem.exists(file)) {
                    Sys.println('File not found: $file');
                    Sys.exit(1);
                }
            } else {
                Sys.println('Unknown argument: $arg\n');
                usage();
                Sys.exit(1);
            }
	    }
    ]);
    var args = Sys.args();
    if(args.length == 0) {
        Sys.println("Missing path to arm file\n");
        usage();
        Sys.exit(1);
    }
    try {
        argsHandler.parse(args);
    } catch(e) {
        Sys.println(e);
        Sys.exit(1);
    }
    if(file == null)
        Sys.exit(1);
    var dec = iron.system.ArmPack.decode(sys.io.File.getBytes(file));
    if(noFormat || space == null) {
        Sys.println(dec);
    } else {
        Sys.println(haxe.Json.stringify(dec, space));
    }
}
