package entities.loadable
{
	import entities.Player;
	
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.World;
	
	import volticpunk.V;
	import volticpunk.entities.VEntity;
	
	public class PlayerStart extends VEntity
	{
		public static function create(n:XML, world:World): void
		{
			var e: Player = new Player(n.@x, n.@y);
			world.add(e);
			V.getRoom().cam.follow(e);
		}
		
		public function PlayerStart(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
		}
	}
}