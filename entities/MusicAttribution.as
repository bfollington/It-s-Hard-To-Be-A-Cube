package entities
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import assets.A;
	
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	
	import volticpunk.entities.VEntity;
	import volticpunk.util.FixedGroup;
	
	public class MusicAttribution extends FixedGroup
	{
		private var ccImage: VEntity;
		
		public function MusicAttribution(x:Number=0, y:Number=0)
		{
			super(x, y, 0, C.LAYER_MENU);
			
			ccImage = add( new VEntity(105, 32, A.CCImage) ) as VEntity;
			add( new VEntity(0, 0, new MeeblesText("Music: Decktonic - Forgotten Machines\nAttribution CC License, 2015" )) );
			
			add( new VEntity(0, 72, new MeeblesText("Game by Voltic Games\nhttp://voltic.com.au" )) );
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.mousePressed && Input.mouseX > ccImage.x && Input.mouseX < ccImage.x + 88 && Input.mouseY > ccImage.y && Input.mouseY < ccImage.y + 31)
			{
				var request:URLRequest = new URLRequest("http://creativecommons.org/licenses/by/4.0/");
				navigateToURL(request, "_blank");
			}
		}
	}
}