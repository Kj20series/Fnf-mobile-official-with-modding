# Mobile Controls

---

a library made to make the process of adding a mobile controls way easier.

---

- [Setup](https://github.com/ArkoseLabsOfficial/mobile-controls/blob/main/docs/SETUP.md)
- [Features](https://github.com/ArkoseLabsOfficial/mobile-controls/blob/main/docs/FEATURES.md)
- [Usage](#usage)

---

# USAGE

Creating & Handling a mobile controls should be fairly easy and very much self-explanatory

- NOTE: MobilePad & Hitbox are using the same base, so their handling is almost same

```haxe
// *
// * src/Main.hx
// *

import mobile.MobileConfig;
import mobile.MobileConfig.ButtonModes;

class Main {
	static function main():Void {
		MobileConfig.init('MobileControls', 'ArkoseLabs/HaxeTale', 'mobile/',
			[
				['MobilePad/DPadModes', ButtonModes.DPAD],
				['MobilePad/ActionModes', ButtonModes.ACTION],
				['Hitbox/HitboxModes', ButtonModes.HITBOX]
			]
		);
	}
}

// *
// * src/PlayState.hx
// *

import mobile.MobileControlManager;
class PlayState extends FlxState {
	public static var instance:PlayState;
	public var manager:MobileControlManager;
	public function new() {
		super();
		instance = this;
		/* Manager Setup */
		manager = new MobileControlManager(this);
	}
	override function destroy()
	{
		if (manager != null) manager.destroy();
		super.destroy();
	}
	override function create() {
		super.create();

		/* MobilePad Setup */
		manager.addMobilePad('Test', 'Test');
		manager.addMobilePadCamera();

		/* Hitbox Setup */
		manager.addHitbox('Test');
		manager.addHitboxCamera();

		/* JoyStick Setup */
		function onJoystickMove(angle:Float, strength:Float, directionID:Float, directionName:String):Void
		{
			trace('angle:$angle');
			trace('strength:$strength');
			trace('directionID:$directionID');
			trace('directionName:$directionName');
		}

		// manager.addJoyStick(x, y, texture, callback);
		manager.addJoyStick(0, 0, 'JoyStick/joystick', onJoystickMove); //Example With Texture (NOTE: texture and callback is optional)
		manager.joyStick.scale.set(0.7, 0.7);
		manager.addJoyStickCamera();
	}
	override function update(elapsed:Float) {
		//with using buttonIDs
		if (manager.mobilePad.justPressed('A')) {
			trace('hello from A');
		}
		//alternative (buttonName special)
		if (manager.mobilePad.getButton('buttonA').justPressed) {
			trace('hello from buttonA');
		}

		//with using buttonIDs
		if (manager.hitbox.justPressed('up')) {
			trace('hello from buttonUp');
		}
		//alternative (buttonName special)
		if (manager.hitbox.getButton('buttonUp').justPressed) {
			trace('hello from buttonUp');
		}

		if (manager.joyStick.pressed('up')) {
			trace('hello from joyStick up');
		}
	}
}

// *
// * An Example (Probably This Class Won't Work)
// * src/Controls.hx
// *

import flixel.FlxG;

class Controls {
	public var LEFT(get, never):Bool;
	public var RIGHT(get, never):Bool;
	public var UP(get, never):Bool;
	public var DOWN(get, never):Bool;
	public var LEFT_P(get, never):Bool;
	public var RIGHT_P(get, never):Bool;
	public var UP_P(get, never):Bool;
	public var DOWN_P(get, never):Bool;
	public var LEFT_R(get, never):Bool;
	public var RIGHT_R(get, never):Bool;
	public var UP_R(get, never):Bool;
	public var DOWN_R(get, never):Bool;

	public function get_LEFT() return justPressed('left');
	public function get_RIGHT() return justPressed('right');
	public function get_UP() return justPressed('up');
	public function get_DOWN() return justPressed('down');
	public function get_LEFT_P() return pressed('left');
	public function get_RIGHT_P() return pressed('right');
	public function get_UP_P() return pressed('up');
	public function get_DOWN_P() return pressed('down');
	public function get_LEFT_R() return justReleased('left');
	public function get_RIGHT_R() return justReleased('right');
	public function get_UP_R() return justReleased('up');
	public function get_DOWN_R() return justReleased('down');

	public function new() {}

	public static var mobileBinds:Map<String, Dynamic> = [
		'up'			=> ['mpad_up', 'mpad_w'],
		'left'			=> ['mpad_left', 'mpad_a'],
		'down'			=> ['mpad_down', 'mpad_s'],
		'right'			=> ['mpad_right', 'mpad_d']
	];

	public function justPressed(keyName:String) {
		return mobilePadJustPressed(mobileBinds[keyName]) || joyStickJustPressed(keyName);
	}

	public function pressed(keyName:String) {
		return mobilePadPressed(mobileBinds[keyName]) || joyStickPressed(keyName);
	}
	
	public function released(keyName:String) {
		return mobilePadJustReleased(mobileBinds[keyName]) || joyStickJustReleased(keyName);
	}

	public var requestedInstance(get, default):Dynamic;
	@:noCompletion
	private function get_requestedInstance():Dynamic
	{
		return PlayState.instance;
	}

	private function joyStickPressed(key:String):Bool
	{
		if (key != null && requestedInstance.joyStick != null)
			if (requestedInstance.joyStick.pressed(key) == true)
				return true;

		return false;
	}

	private function joyStickJustPressed(key:String):Bool
	{
		if (key != null && requestedInstance.joyStick != null)
			if (requestedInstance.joyStick.justPressed(key) == true)
				return true;

		return false;
	}

	private function joyStickJustReleased(key:String):Bool
	{
		if (key != null && requestedInstance.joyStick != null)
			if (requestedInstance.joyStick.justReleased(key) == true)
				return true;

		return false;
	}

	private function mobilePadPressed(keys:Array<String>):Bool
	{
		if (keys != null && requestedInstance.mobilePad != null)
			if (requestedInstance.mobilePad.pressed(keys) == true)
				return true;

		return false;
	}

	private function mobilePadJustPressed(keys:Array<String>):Bool
	{
		if (keys != null && requestedInstance.mobilePad != null)
			if (requestedInstance.mobilePad.justPressed(keys) == true)
				return true;

		return false;
	}

	private function mobilePadJustReleased(keys:Array<String>):Bool
	{
		if (keys != null && requestedInstance.mobilePad != null)
			if (requestedInstance.mobilePad.justReleased(keys) == true)
				return true;

		return false;
	}
}

```
