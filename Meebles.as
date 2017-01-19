package 
{	
	
	import flash.display.NativeMenu;
	import flash.display.StageDisplayState;
	import flash.geom.Rectangle;
	
	import assets.A;
	
	import entities.Player;
	import entities.Timer;
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import rooms.Level;
	import rooms.Menu;
	import rooms.Title;
	
	import volticpunk.V;
	import volticpunk.entities.Group;
	import volticpunk.util.Choose;
	
	[SWF(width = 640, height = 480, frameRate = 60, backgroundColor = "#000000")]
	public class Meebles extends Engine
	{
		private static var volume: Number = 1;
		private static var currentTrack: Sfx;
		
		public function Meebles()
		{
			super(C.WIDTH, C.HEIGHT, 60, false);
			
			FP.screen.scale = 2;
			
			FP.world = new Title();
			
			Input.define("Left", Key.LEFT);
			Input.define("Right", Key.RIGHT);
			Input.define("Up", Key.UP);
			Input.define("Down", Key.DOWN);
			Input.define("Jump", Key.Z);
			Input.define("Dash", Key.X);
			
			//FP.console.enable();
			//FP.console.toggleKey = Key.TAB;
		}
		
		public static function toggleMute(): void
		{
			volume = 1 - volume;
			currentTrack.volume = volume;
		}
		
		public static function getVolume(): Number
		{
			return volume;
		}
		
		public static function startMusic(): void
		{
			if (currentTrack == null || !currentTrack.playing)
			{
				currentTrack = Choose.choose(A.Track1Sound, A.Track2Sound, A.Track3Sound, A.Track4Sound);
				currentTrack.play();
				currentTrack.complete = startMusic;
			}
		}
		
		public static function getLevel(): Level
		{
			return V.getRoom() as Level;
		}
		
		public static function getTimer(): Timer
		{
			var g: Group = V.getRoom().getMembersByClass(Timer);
			
			return g.getMembers()[0] as Timer;
		}
		
		public static function getPlayer(): Player
		{
			return V.getRoom().getMembersByClass(Player).getMembers()[0] as Player;
		}
	}
}