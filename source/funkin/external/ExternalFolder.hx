package funkin.external;

import sys.FileSystem;
import lime.app.Application;

class ExternalFolder
{
  #if android
  static final ENGINE_FOLDER:String = "/storage/emulated/0/.VSliceEngine";
  static final ASSETS_FOLDER:String = "/storage/emulated/0/.VSliceEngine/assets";
  static final MODS_FOLDER:String = "/storage/emulated/0/.VSliceEngine/mods";
  #else
  static final ENGINE_FOLDER:String = ".VSliceEngine";
  static final ASSETS_FOLDER:String = ".VSliceEngine/assets";
  static final MODS_FOLDER:String = ".VSliceEngine/mods";
  #end

  public static function init():Void
  {
    if (!FileSystem.exists(ENGINE_FOLDER))
    {
      FileSystem.createDirectory(ENGINE_FOLDER);
      trace('[VSliceEngine] Created ${ENGINE_FOLDER} folder.');
      showSetupMessage();
      return;
    }

    var hasAssets:Bool = FileSystem.exists(ASSETS_FOLDER);
    var hasMods:Bool = FileSystem.exists(MODS_FOLDER);

    if (!hasAssets || !hasMods)
    {
      showSetupMessage();
    }
  }

  static function showSetupMessage():Void
  {
    #if android
    var location:String = "/storage/emulated/0/.VSliceEngine";
    #else
    var location:String = "next to the game executable";
    #end

    var message:String = "Please put the 'assets' and 'mods' folders inside the '.VSliceEngine' folder.\n\nLocation: " + location;

    trace("[VSliceEngine] " + message);
    Application.current.window.alert(message, "VSlice Engine Setup");
  }
}
