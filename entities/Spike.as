package entities
{
	import assets.A;
	
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	
	import volticpunk.entities.VEntity;
	import volticpunk.worlds.Room;
	
	public class Spike extends VEntity
	{
		public static function create(n: XML, world: World): void
		{
			var spike: Spike = new Spike(n.@x, n.@y);
			world.add(spike);
		}
		
		public function Spike(x:Number=0, y:Number=0)
		{
			super(x, y, new Image(A.Spike), new Hitbox(16, 16) );
			type = "spike";
		}
		
		override public function update():void
		{
			var player: Player = collide("player", x, y) as Player;
			
			if (player)
			{
				player.kill();
			}
		}
	}
}