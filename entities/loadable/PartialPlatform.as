package entities.loadable
{
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	
	import net.flashpunk.utils.Ease;
	
	import volticpunk.entities.VEntity;
	import volticpunk.components.Tweener;
	
	public class PartialPlatform extends VEntity
	{
		private var effectTimer:int = 0;
		
		private var targetScale: Number = 1;
		
		public static function create(n:XML, world:World): void
		{
			var e: PartialPlatform = new PartialPlatform(n.@x, n.@y);
			world.add(e);
		}
		
		public function PartialPlatform(x:Number=0, y:Number=0)
		{
			super(x + 8, y + 8, Image.createRect(16, 16), new Hitbox(16, 16, -8, -8));
			
			getImage().centerOrigin();
			addComponent( new Tweener() );
			
			this.type = "level";
		}
		
		override public function update():void
		{	
			effectTimer += 10;
			getImage().alpha = 0.8 + 0.1 * Math.sin(effectTimer * Math.PI/180);
			
			if (Meebles.getPlayer().isDashing())
			{
				if (!getTweener().isActive() && targetScale == 1)
				{
					if (collide("player", x, y))
					{
						targetScale = 0.15;
						getTweener().tween(getImage(), {scale: 0.15}, 0.1, Ease.cubeOut);
					} else {
						targetScale = 0.3;
						getTweener().tween(getImage(), {scale: 0.3}, 0.1, Ease.cubeOut);
					}
					
				} else if (getTweener().isActive() && targetScale != 0.15)
				{
					if (collide("player", x, y))
					{
						targetScale = 0.15;
						getTweener().tween(getImage(), {scale: 0.15}, 0.1, Ease.cubeOut);
					}
				}
				
				this.collidable = false;
				
			} else {
				
				if (targetScale != 1 && !getTweener().isActive())
				{
					targetScale = 1;
					getTweener().tween(getImage(), {scale: 1}, 0.1, Ease.cubeOut);
				}
				
				this.collidable = true;
			}	
		}
	}
}