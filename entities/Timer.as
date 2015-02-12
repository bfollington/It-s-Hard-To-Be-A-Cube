package entities
{
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Text;
	
	import volticpunk.entities.VEntity;
	
	public class Timer extends VEntity
	{
		private var text: Text;
		private var timer: Number = 0;
		
		[Embed(source = '/assets/apple.ttf', embedAsCFF="false", fontFamily = "Apple ][")] private const CONSOLE:Class;
		
		public function Timer(x:Number=0, y:Number=0)
		{
			text = new Text("00:00:00", 0, 0, {align: "right"});
			text.font = "Apple ][";
			text.size = 8;
			super(x, y, text);
			
			text.scrollX = text.scrollY = 0;
		}
		
		override public function update():void
		{
			super.update();
			
			timer += FP.elapsed;
			
			var mins: int = Math.floor(timer / 60);
			var secs: int = Math.floor(timer % 60);
			var millis: int = Math.floor(timer % 1 * 1000);
			
			text.text = pad(mins, 2) + ":" + pad(secs, 2) + ":" + pad(millis, 3);
			
			text.text = (timer.toFixed(2));
		}
		
		public function getTime(): Number
		{
			return timer;
		}
		
		private function pad(n: Number, length: int): String
		{
			var s: String = n.toString();
			
			while (s.length < length)
			{
				s = "0" + s;
			}
			
			return s;
		}
	}
}