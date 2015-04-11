package rooms
{
	import assets.A;
	
	import entities.LevelIcon;
	
	import net.flashpunk.utils.Data;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import volticpunk.V;
	import volticpunk.entities.VEntity;
	import volticpunk.util.Choose;
	import volticpunk.util.Constrain;
	import volticpunk.util.NumberUtil;
	import volticpunk.util.XMLUtil;
	import volticpunk.worlds.Room;
	import volticpunk.worlds.TileLayer;
	
	public class Menu extends Room
	{
		private var selectionIndex: int = 0;
		private var selection: LevelIcon;
		private var levels: Vector.<LevelIcon>;
		private var moveRight:Boolean = true;
		
		private var controls: VEntity;
		
		public function Menu(fadeIn:Boolean=true)
		{
			super(fadeIn);
			
			levels = new Vector.<LevelIcon>();
			levelHeight = 240;
			levelWidth = 26*192;
			
			controls = new VEntity(8, 210, A.ControlsImage);
			A.ControlsImage.scrollX = 0;
			A.ControlsMutedImage.scrollX = 0;
			controls.layer = C.LAYER_FOREGROUND;
			
			add( controls );
		}
		
		override public function begin():void
		{
			super.begin();
			
			disableDarknessOverlay();
			
			var map: XML = XMLUtil.loadXml(A.MenuBGMap);
			
			var tiles: TileLayer = new TileLayer(map, A.LevelTiles, map.Ground, C.LAYER_GROUND);
			tiles.graphic.scrollX = 0.5;
			
			add( tiles );
			
			var e: LevelIcon;
			var iconWidth: int = 128;
			
			for (var i: int = 0; i < C.LETTERS.length; i++)
			{
				e = add( new LevelIcon( ((320 - iconWidth / 2) / 2) + iconWidth * i, 32, i) ) as LevelIcon;
				levels.push(e);
				e.unselect();
			}
			
			selection = levels[0];
			selection.select();
		}
		
		override public function update():void{
			super.update();
			
			if (Meebles.getVolume() == 0)
			{
				controls.graphic = A.ControlsMutedImage;
			} else {
				controls.graphic = A.ControlsImage;
			}
			
			if (Input.pressed(Key.M))
			{
				Meebles.toggleMute();
			}
			
			if (Input.pressed("Jump"))
			{
				selection.picked();
			}
			
			if (Input.pressed("Dash"))
			{
				selection.unselect();
				selectionIndex = Constrain.constrain(selectionIndex + 5*(int(moveRight)*2-1), 0, C.LETTERS.length - 1);
				selection = levels[selectionIndex];
				selection.select();
				V.getRoom().cam.follow(selection);
			}
			
			if (Input.pressed("Right"))
			{
				moveRight = true;
				selection.unselect();
				selectionIndex = Constrain.constrain(selectionIndex + 1, 0, C.LETTERS.length - 1);
				selection = levels[selectionIndex];
				selection.select();
				V.getRoom().cam.follow(selection);
				
			}
			
			if (Input.pressed("Left"))
			{
				moveRight = false;
				selection.unselect();
				selectionIndex = Constrain.constrain(selectionIndex - 1, 0, C.LETTERS.length - 1);
				selection = levels[selectionIndex];
				selection.select();
				V.getRoom().cam.follow(selection);
			}
		}
	}
}