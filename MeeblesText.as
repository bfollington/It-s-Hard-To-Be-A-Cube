package
{
	import net.flashpunk.graphics.Text;
	
	public class MeeblesText extends Text
	{
		public function MeeblesText(text:String, x:Number=0, y:Number=0, options:Object=null, size: int = 8)
		{
			super(text, x, y, options);
			
			this.font = "Apple ][";
			this.size = size;
		}
	}
}