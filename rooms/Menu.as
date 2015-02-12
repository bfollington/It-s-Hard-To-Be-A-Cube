package rooms
{
	import assets.A;
	
	import entities.LevelIcon;
	
	import net.flashpunk.utils.Data;
	import net.flashpunk.utils.Input;
	
	import volticpunk.V;
	import volticpunk.util.Choose;
	import volticpunk.util.Constrain;
	import volticpunk.util.NumberUtil;
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
			levelHeight = 240;
			levelWidth = 2548;
		}
		
		override public function begin():void
		{
			super.begin();
			
			Data.load("meebles");
			disableDarknessOverlay();
			
			var e: LevelIcon;
			var iconWidth: int = 128;
			
			for (var i: int = 0; i < C.LETTERS.length; i++)
			{
				e = add( new LevelIcon( ((320 - iconWidth / 2) / 2) + iconWidth * i, 64, i) ) as LevelIcon;
				levels.push(e);
				e.unselect();
			}
			
			selection = levels[0];
			selection.select();

			Meebles.startMusic();
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
				selectionIndex = Constrain.constrain(selectionIndex + 1, 0, C.LETTERS.length - 1);
				selection = levels[selectionIndex];
				selection.select();
				V.getRoom().cam.follow(selection);
			}
			
			if (Input.pressed("Left"))
			{
				selection.unselect();
				selectionIndex = Constrain.constrain(selectionIndex - 1, 0, C.LETTERS.length - 1);
				selection = levels[selectionIndex];
				selection.select();
				V.getRoom().cam.follow(selection);
			}
		}
	}
}