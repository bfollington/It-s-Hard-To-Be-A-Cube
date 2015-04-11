package entities
{
	import assets.A;
	
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	import rooms.Level;
	import rooms.Menu;
	
	import volticpunk.V;
	import volticpunk.entities.VEntity;
	import volticpunk.util.FixedGroup;
	
	public class EndOfLevelPopup extends FixedGroup
	{
		private var newBestTime: VEntity;
		private var wasBestTime: Boolean;
		private var timeDisplay: VEntity;
		
		public function EndOfLevelPopup(x:int, y:int, bestTime: Boolean, oldTime: Number, newTime: Number)
		{
			super(x, y, 0, C.LAYER_MENU);
			
			wasBestTime = bestTime;
			var text: Text;
			var medalImage: Image;
			
			var medalTime: Number;
			
			add( new VEntity(-8, 72, A.EndOfLevelControlsImage) );
			
			if (wasBestTime)
			{
				medalTime = newTime;
				if (oldTime == 0)
				{
					text = new Text("New Best Time!");	
				} else {
					text = new Text("New Best Time!\n" + (oldTime - newTime).toFixed(2).toString()+"s faster");
				}
					
			} else {
				medalTime = newTime;
				
				text = new Text("Level Complete!");
			}
			
			text.align = "center";
			
			var timeText: Text = new Text(newTime.toFixed(2).toString());
			timeDisplay = new VEntity(36, 40, timeText);
			add( timeDisplay );
			
			medalImage = A.WhiteImage;
			
			if (medalTime < C.TIMES[(room as Level).getCode()][0])
			{
				medalImage = A.BronzeImage;
			}
			
			if (medalTime < C.TIMES[(room as Level).getCode()][1])
			{
				medalImage = A.SilverImage;
			}
			
			if (medalTime < C.TIMES[(room as Level).getCode()][2])
			{
				medalImage = A.GoldImage;
			}
			
			text.font = "Apple ][";
			text.size = 8;
			
			newBestTime = new VEntity(-64, 0, text);
			add( newBestTime );
			
			add( new VEntity(0, 32, medalImage));
			
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.pressed("Jump"))
			{
				(room as Level).nextLevel();
			}
			
			if (Input.pressed("Dash"))
			{
				(room as Level).reset();	
			}
		}
	}
}