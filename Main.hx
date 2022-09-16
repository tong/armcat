import haxe.Json;
import haxe.io.Bytes;
import iron.system.ArmPack;
import sys.FileSystem;
import sys.io.File;
using StringTools;
using haxe.io.Path;

function main() {
    var space : String = "  ";
    var noFormat = false;
    var file : String = null;
    var outFile : String = null;
    var argsHandler : { getDoc: Void->String, parse: Array<String>->Void } = null;
    function usage() {
        var str = 'Usage: armcat <file.arm> [options]\n\nOptions:\n';
        for(l in argsHandler.getDoc().split('\n')) str += '  $l\n';
        return str;
    }
    argsHandler = hxargs.Args.generate([
	    @doc("Indention string")
	    ["--json-indent"] => (str:String) -> {
            if((space = str) == null)
                exit(1, 'Missing argument value');
	    },
	    @doc("Skip json formatting")
	    ["--no-json"] => () -> {
            noFormat = true;
	    },
	    @doc("File to write output")
	    ["--out","-o"] => (path:String) -> {
            outFile = path;
	    },
	    ["--help"] => () -> {
            exit(0, usage());
	    },
	    _ => (arg:String) -> {
            if(arg.startsWith('--')) {
                exit(1, 'Unknown argument: $arg\n');
            } else {
                if(!FileSystem.exists(arg))
                    exit(1, 'File not found: $file');
                file = arg;
            }
	    }
    ]);
    var args = Sys.args();
    if(args.length == 0)
        exit(1, "Missing arguments\n");
    try argsHandler.parse(args) catch(e:String)
        exit(1, e);
    if(file == null) exit(1);
    var out : Bytes = null;
    switch file.extension() {
    case "arm":
        var dec = ArmPack.decode(File.getBytes(file));
        if(noFormat || space == null) {
            out = Bytes.ofString(dec);
        } else {
            out = Bytes.ofString(Json.stringify(dec, space));
        }
    case "json":
        out = ArmPack.encode(Json.parse(File.getContent(file)));
    default:
       exit(1, 'Unkown file type'); 
    }
    if(out != null) {
        if(outFile == null) {
            Sys.stdout().write(out);
        } else {
            File.saveBytes(outFile, out);
        }
    }
}

function exit(code=0,?info:String) {
    if(info!=null) {
        if(code == 0)
            Sys.stdout().writeString(info);
        else
            Sys.stderr().writeString(info);
    }
    Sys.exit(code);
}
