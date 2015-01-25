package
{
	import entities.Spike;
	import entities.loadable.Box;
	import entities.loadable.ChargeStation;
	import entities.loadable.Cliff;
	
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