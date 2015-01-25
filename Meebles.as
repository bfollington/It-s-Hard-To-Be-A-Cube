package
{	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	[SWF(width="640", height="480", backgroundColor="#000000"]
	
	public class Meebles extends Engine
	{
		public function Meebles()
		{
			super(C.WIDTH * 2, C.HEIGHT * 2, 60, false);
			
			FP.screen.scale = 2;
			
			FP.world = new Level();
			
			Input.define("Left", Key.LEFT);
			Input.define("Right", Key.RIGHT);
			Input.define("Up", Key.UP);
			Input.define("Down", Key.DOWN);
			Input.define("Jump", Key.Z);
			Input.define("Dash", Key.X);
			
			FP.console.enable();
			FP.console.toggleKey = Key.TAB;
		}
	}
}