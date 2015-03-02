package entities.loadable
{	
	import net.flashpunk.World;

	public class RotatingLong 
	{
		public static function create(n:XML, world:World): void
		{
			var e: RotatingPlatform = new RotatingPlatform(n.@x - 64, n.@y - 64, Number(n.@time), "____", n.@angle);
			world.add(e);
		}
		
		public function RotatingLong()
		{
			
		}
	}
}