package
{

	public class C
	{

		public static const WIDTH: int = 320;
		public static const HEIGHT: int = 240;
		public static const GRID: int = 16;
		public static const TILE_SIZE:int = 16;
		
		public static const LEFT:int = -1;
		public static const RIGHT:int = 1;
		
		public static const LETTERS: Array = ["A", "A2", "B", "B2", "C", "C2", "D", "D2", "E", "E2", "F", "F2", "G", "G2", "H", "H2", "I", "I2", "J"];
		public static const LETTERS_REAL: Array = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
		
		
        public static const LAYER_BACKGROUND:int = 15;
        public static const LAYER_GROUND:int = 0;
        public static const LAYER_LIGHT:int = -2;
        public static const LAYER_FOREGROUND:int = -3;
        public static const LAYER_DARKNESS:int = -5;
        public static const LAYER_MENU:int = -10;
        public static const LAYER_MENU_UI:int = -11;
		
		public static const FAST_TWEEN:Number = 0.1;
		public static const MEDIUM_TWEEN:Number = 1;
		public static const VERY_SLOW_TWEEN:Number = 1.25;
		public static const FADE_TWEEN:Number = 0.5;

		public static const DEFAULT_COLLISION_TYPE:String = "level";
		
		/** Types the player should collide with */
		public static const COLLISION_TYPES:Array = [DEFAULT_COLLISION_TYPE, "moving_platform", "rotating_platform"];
		
	}
}