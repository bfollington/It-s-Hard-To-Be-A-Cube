package entities
{
	import entities.particles.EdgeOfScreenParticle;
	
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	import volticpunk.components.Repeater;
	import volticpunk.entities.VEntity;
	
	public class EdgeOfScreen extends VEntity
	{
		public function EdgeOfScreen()
		{
			super(320 - 1, 0, Image.createRect(1, 240), null);
			
			var img: Image = graphic as Image;
			img.scrollX = 0;
			img.scrollY = 0;
		
			addComponent( new Repeater(0.05, makeParticle) );
		}
		
		private function makeParticle(): void
		{
			(room.create(EdgeOfScreenParticle) as EdgeOfScreenParticle).init(x, y + Math.random() * 240);
		}
	}
}