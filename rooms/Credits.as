package rooms
{
	import assets.A;
	
	import entities.MusicAttribution;
	
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Data;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import volticpunk.V;
	import volticpunk.entities.VEntity;
	import volticpunk.util.XMLUtil;
	import volticpunk.worlds.Room;
	import volticpunk.worlds.TileLayer;
	
	public class Credits extends Room
	{
		public function Credits(fadeIn:Boolean=true)
		{
			super(fadeIn);
			
			var e: Entity = add( new VEntity(8, 224, A.CreditsControlsImage) );
			e.layer = C.LAYER_FOREGROUND;
			
			e = add( new MusicAttribution(10, 10) );
		}
		
		override public function begin():void
		{
			super.begin();
			
			disableDarknessOverlay();
			
			var map: XML = XMLUtil.loadXml(A.MenuBGMap);
			
			add( new TileLayer(map, A.LevelTiles, map.Ground, C.LAYER_GROUND) );
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.pressed("Dash"))
			{
				V.changeRoom( new Title() );
			}
			
			if (Input.pressed(Key.M))
			{
				Meebles.toggleMute();
			}
		}
	}
	
}