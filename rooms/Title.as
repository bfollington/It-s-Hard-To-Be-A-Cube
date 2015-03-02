package rooms
{
	import assets.A;
	
	import net.flashpunk.utils.Data;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import volticpunk.V;
	import volticpunk.components.Tweener;
	import volticpunk.entities.VEntity;
	import volticpunk.util.XMLUtil;
	import volticpunk.worlds.Room;
	import volticpunk.worlds.TileLayer;
	
	public class Title extends Room
	{
		
		private var cube: VEntity;
		private var subtitle: VEntity;
		private var title: VEntity;
		
		private var pressZ: VEntity;
		
		public function Title(fadeIn:Boolean=true)
		{
			super(fadeIn);
			
			cube = new VEntity(160, 64, A.TitleCubeImage);
			cube.addComponent( new Tweener() );
			A.TitleCubeImage.centerOrigin();
			add(cube);
			
			subtitle = new VEntity(160, 124, A.TitleSmallTextImage);
			subtitle.addComponent( new Tweener() );
			A.TitleSmallTextImage.centerOrigin();
			add(subtitle);
			
			title = new VEntity(160, 150, A.TitleCubeTextImage);
			title.addComponent( new Tweener() );
			A.TitleCubeTextImage.centerOrigin();
			add(title);
			
			pressZ = new VEntity(160, 200, A.ZToStartImage);
			pressZ.addComponent( new Tweener() );
			A.ZToStartImage.centerOrigin();
			add(pressZ);
			
			pressZ.layer = C.LAYER_FOREGROUND;
		}
		
		private function fadeIn(): void
		{
			pressZ.getImage().alpha = 0.5;
			pressZ.getTweener().tween(pressZ.getImage(), {alpha: 1}, 0.2, Ease.cubeInOut);
			pressZ.getTweener().setCallback(fadeOut);
		}
		
		private function fadeOut(): void
		{
			pressZ.getImage().alpha = 1;
			pressZ.getTweener().tween(pressZ.getImage(), {alpha: 0.5}, 0.2, Ease.cubeInOut);
			pressZ.getTweener().setCallback(fadeIn);
		}
		
		override public function begin():void
		{
			super.begin();
			
			Data.load("meebles");
			disableDarknessOverlay();
			Meebles.startMusic();
			
			var map: XML = XMLUtil.loadXml(A.MenuBGMap);
			
			add( new TileLayer(map, A.LevelTiles, map.Ground, C.LAYER_GROUND) );
			
			cube.getImage().alpha = 0;
			cube.getImage().y = 16;
			cube.getTweener().tween(cube.getImage(), {alpha: 1, y: 0}, 1.0, Ease.cubeOut);
			
			title.getImage().alpha = 0;
			title.getImage().x = 16;
			title.getTweener().tween(title.getImage(), {alpha: 1, x: 0}, 1.0, Ease.cubeOut);
			
			subtitle.getImage().alpha = 0;
			subtitle.getImage().x = -16;
			subtitle.getTweener().tween(subtitle.getImage(), {alpha: 1, x: 0}, 1.0, Ease.cubeOut);
			
			fadeIn();
		}
		
		override public function update():void{
			super.update();
			
			if (Input.pressed("Jump"))
			{
				V.changeRoom( new Menu() );
			}
			
			if (Input.pressed(Key.M))
			{
				Meebles.toggleMute();
			}
		}
	}
}