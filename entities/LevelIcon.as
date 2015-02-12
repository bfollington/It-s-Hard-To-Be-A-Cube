package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Data;
	
	import rooms.Level;
	
	import volticpunk.V;
	import volticpunk.entities.Group;
	import volticpunk.entities.VEntity;
	
	public class LevelIcon extends Group
	{
		private var mainText: Entity;
		private var bestTime: Entity;
		
		private var levelNumber: Number;
		
		public function LevelIcon(x:Number=0, y:Number=0, levelNumber: int = 0)
		{
			super(x, y);
			
			mainText = add( new VEntity(x, y, new MeeblesText(C.LETTERS[levelNumber], 0, 0, null, 48)) );
			bestTime = add( new VEntity(x, y, new MeeblesText(Data.readString(C.LETTERS[levelNumber] + "_best_time") )) );
			
			this.levelNumber = levelNumber;
		}
		
		public function select(): void
		{
			doToEachObject( function(member: Entity): void {
				(member.graphic as Text).alpha = 1;
			});
		}
		
		public function unselect(): void
		{
			doToEachObject( function(member: Entity): void {
				(member.graphic as Text).alpha = 0.5;
			});
		}
		
		public function picked(): void
		{
			V.changeRoom( new Level(C.LETTERS[levelNumber]));
		}
		
		override public function update():void
		{
			super.update();
			
			mainText.x = x;
			mainText.y = y;
			bestTime.x = x;
			bestTime.y = y + 48;
		}
	}
}