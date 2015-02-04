package rooms
{
	import entities.LevelIcon;
	
	import net.flashpunk.utils.Input;
	
	import volticpunk.worlds.Room;
	
	public class Menu extends Room
	{
		private var selectionIndex: int = 0;
		private var selection: LevelIcon;
		private var levels: Vector.<LevelIcon>;
		
		public function Menu(fadeIn:Boolean=true)
		{
			super(fadeIn);
			
			levels = new Vector.<LevelIcon>();
		}
		
		override public function begin():void
		{
			super.begin();
			
			disableDarknessOverlay();
			
			var e: LevelIcon;
			
			for (var i: int = 0; i < 26; i++)
			{
				e = add( new LevelIcon(96 * i, 64, i) ) as LevelIcon;
				levels.push(e);
			}
			
			selection = levels[0];
		}
		
		override public function update():void{
			super.update();
			
			if (Input.pressed("Jump"))
			{
				selection.picked();
			}
			
			if (Input.pressed("Right"))
			{
				selection.unselect();
				selectionIndex++;
				selection = levels[selectionIndex];
				selection.select();
			}
			
			if (Input.pressed("Left"))
			{
				selection.unselect();
				selectionIndex--;
				selection = levels[selectionIndex];
				selection.select();
			}
		}
	}
}