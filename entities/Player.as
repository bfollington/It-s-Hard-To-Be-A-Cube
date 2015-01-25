package entities
{
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	
	import volticpunk.components.PlatformerMovement;
	import volticpunk.entities.VEntity;
	
	public class Player extends VEntity
	{
		private var move: PlatformerMovement;
		
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			move = new PlatformerMovement();
			
			addComponent(move, "move");
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.check("Left"))
			{
				move.velocity.x = -2;	
			}
			
			if (Input.check("Right"))
			{
				move.velocity.x = 2;	
			}
			
			if (Input.pressed("Jump"))
			{
				move.velocity.y = -3;	
			}
		}
	}
}