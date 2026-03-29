package funkin.external;

import sys.FileSystem;
import sys.io.File;
import lime.app.Application;

class ExternalFolder
{
  static final ENGINE_FOLDER:String = ".VSliceEngine";
  static final ASSETS_FOLDER:String = ".VSliceEngine/assets";
  static final MODS_FOLDER:String = ".VSliceEngine/mods";

  /**
   * Call this early in Main.hx to initialize the .VSliceEngine folder.
   */
  public static function init():Void
  {
    // Create .VSliceEngine folder if it doesn't exist
    if (!FileSystem.exists(ENGINE_FOLDER))
    {
      FileSystem.createDirectory(ENGINE_FOLDER);
      trace('[VSliceEngine] Created .VSliceEngine folder.');
      showSetupMessage();
      return;
    }

    // If folder exists but assets and mods are missing, show the message
    var hasAssets:Bool = FileSystem.exists(ASSETS_FOLDER);
    var hasMods:Bool = FileSystem.exists(MODS_FOLDER);

    if (!hasAssets || !hasMods)
    {
      showSetupMessage();
    }
  }

  static function showSetupMessage():Void
  {
    var message:String = "Please put the 'assets' and 'mods' folders inside the '.VSliceEngine' folder next to the game executable.";

    #if android
    // On Android, use a native alert dialog
    lime.ui.Alert.show(message, "VSlice Engine Setup");
    #else
    // On desktop, print to console and show a system dialog
    Sys.println("[VSliceEngine] " + message);
    lime.ui.Alert.show(message, "VSlice Engine Setup");
    #end
  }
}

