package
{
	import entities.Spike;
	
	import volticpunk.worlds.LookupDictionary;
	
	public class MeeblesLookupDictionary extends LookupDictionary
	{
		public function MeeblesLookupDictionary()
		{
			super();
			
			dict["spike"] = Spike;
		}
		
	}
}