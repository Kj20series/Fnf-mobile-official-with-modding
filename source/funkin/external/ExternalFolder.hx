package funkin.external;

import sys.FileSystem;
import lime.app.Application;

class ExternalFolder
{
  #if android
  // On Android we put everything in public storage so the user can easily access mods/assets
  static final ENGINE_FOLDER:String = "/storage/emulated/0/.VSliceEngine";
  static final ASSETS_FOLDER:String = "/storage/emulated/0/.VSliceEngine/assets";
  static final MODS_FOLDER:String = "/storage/emulated/0/.VSliceEngine/mods";
  #else
  // Desktop / other platforms keep the original relative folder next to the executable
  static final ENGINE_FOLDER:String = ".VSliceEngine";
  static final ASSETS_FOLDER:String = ".VSliceEngine/assets";
  static final MODS_FOLDER:String = ".VSliceEngine/mods";
  #end

  /**
   * Call this early in Main.hx to initialize the .VSliceEngine folder.
   */
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
    var message:String = "Please put the 'assets' and 'mods' folders inside the '.VSliceEngine' folder.\n\n"
      + (lime.system.System.platform == lime.system.Platform.ANDROID
          ? "Location: /storage/emulated/0/.VSliceEngine"
          : "Location: next to the game executable");

    trace("[VSliceEngine] " + message);
    Application.current.window.alert(message, "VSlice Engine Setup");
  }
}
