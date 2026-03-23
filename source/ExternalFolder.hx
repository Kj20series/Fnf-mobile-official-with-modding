package;

#if sys
import sys.FileSystem;
import lime.system.System;
#end

class ExternalFolder 
{
    public static function init():Void 
    {
        #if android
        // This targets the internal user storage (usually /storage/emulated/0/)
        var root:String = System.userDirectory; 
        
        // You can remove the '.' if you want the folder to be visible in all file managers
        var enginePath:String = root + ".VsliceEngine/";
        var modsPath:String = enginePath + "mods/";

        try {
            if (!FileSystem.exists(enginePath)) {
                FileSystem.createDirectory(enginePath);
                trace("Created Engine Folder: " + enginePath);
            }

            if (!FileSystem.exists(modsPath)) {
                FileSystem.createDirectory(modsPath);
                trace("Created Mods Folder: " + modsPath);
            }
        } catch (e:Dynamic) {
            trace("Error creating folders: " + e);
        }
        #end
    }
}

