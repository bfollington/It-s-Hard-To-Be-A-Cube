package entities
{
	import assets.A;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Data;
	
	import rooms.Level;
	
	import volticpunk.V;
	import volticpunk.entities.Group;
	import volticpunk.entities.VEntity;
	import volticpunk.util.FixedGroup;
	
	public class LevelIcon extends FixedGroup
	{
		private var mainText: Entity;
		private var bestTime: Entity;
		
		private var levelNumber: Number;
		
		public function LevelIcon(x:Number=0, y:Number=0, levelNumber: int = 0)
		{
			super(x, y);
			
			var time: Number = Number(Data.readString(C.LETTERS[levelNumber] + "_best_time", "0"));
			
			mainText = add( new VEntity(0, 24, new MeeblesText(C.LETTERS[levelNumber], 0, 0, null, 48)) );
			bestTime = add( new VEntity(14, 3, new MeeblesText(Data.readString(C.LETTERS[levelNumber] + "_best_time") )) );
			
			var medalImage: Class = A.WhiteSmall;
			
			if (time < C.TIMES[C.LETTERS[levelNumber]][0])
			{
				medalImage = A.BronzeSmall;
			}
			
			if (time < C.TIMES[C.LETTERS[levelNumber]][1])
			{
				medalImage = A.SilverSmall;
			}
			
			if (time < C.TIMES[C.LETTERS[levelNumber]][2])
			{
				medalImage = A.GoldSmall;
			}
			
			var medalX: Number = -4;
			
			if (time == 0)
			{
				medalImage = A.BlankSmall;
				medalX = 16;
			}
			
			add( new VEntity(medalX, 0, new Image(medalImage)) );
			
			add( new VEntity(18, 77, new MeeblesText(C.TIMES[C.LETTERS[levelNumber]][0])) );
			add( new VEntity(0, 74, new Image(A.BronzeSmall)) );
			add( new VEntity(18, 101, new MeeblesText(C.TIMES[C.LETTERS[levelNumber]][1])) );
			add( new VEntity(0, 98, new Image(A.SilverSmall)) );
			add( new VEntity(18, 125, new MeeblesText(C.TIMES[C.LETTERS[levelNumber]][2])) );
			add( new VEntity(0, 122, new Image(A.GoldSmall)) );
			
			this.levelNumber = levelNumber;
		}
		
		public function select(): void
		{
			doToEachObject( function(member: Entity): void {
				if (member.graphic is Text)
				{
					(member.graphic as Text).alpha = 1;	
				} else if (member.graphic is Image)
				{
					(member.graphic as Image).alpha = 1;
				}
			});
		}
		
		public function unselect(): void
		{
			doToEachObject( function(member: Entity): void {
				if (member.graphic is Text)
				{
					(member.graphic as Text).alpha = 0.5;	
				} else if (member.graphic is Image)
				{
					(member.graphic as Image).alpha = 0.5;
				}
			});
		}
		
		public function picked(): void
		{
			V.changeRoom( new Level(C.LETTERS[levelNumber]));
		}
		
		override public function update():void
		{
			super.update();

		}
	}
}