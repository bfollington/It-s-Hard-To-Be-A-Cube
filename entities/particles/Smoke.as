package entities.particles
{
	import flash.geom.Point;
	
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	import volticpunk.components.LifespanComponent;
	import volticpunk.entities.VEntity;
	import volticpunk.util.ImageUtil;
	
	public class Smoke extends VEntity
	{
		private var velocity: Point;
		private var spin: Number;
		private var lifespan: LifespanComponent;
		
		public function Smoke(x:Number=0, y:Number=0)
		{
			super(x, y, Image.createRect(8, 8, 0xFF999999));
			
			ImageUtil.setPivotPoint(graphic as Image, new Point(4, 4));
			
			velocity = new Point(Math.random() * 1 - 0.5, Math.random() * -0.5);
			spin = Math.random() * 10 - 5;
			
			lifespan = addComponent( new LifespanComponent(1, true) ) as LifespanComponent;
			
			layer = C.LAYER_BACKGROUND;
		}
		
		override public function update():void
		{
			super.update();
			
			x += velocity.x;
			y += velocity.y;
			(graphic as Image).angle += spin;
			(graphic as Image).scale = lifespan.getRemainingPercent();
		}
	}
}