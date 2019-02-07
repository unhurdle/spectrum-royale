package models
{
   	import org.apache.royale.collections.ArrayList;
   	import vos.GuitarristVO;

	

		[Bindable]
	public class TablesModel 
	{
		private var _guitarrists:ArrayList = new ArrayList([
			new GuitarristVO("Steve Vai", "Passion & Warfare", 1990),
			new GuitarristVO("Joe Satriani", "Surfing With The Alien", 1987),
			new GuitarristVO("Yngwie Malmsteen", "Rising Force", 1984),
			new GuitarristVO("Steve Morse", "Southern Steel", 1991),
			new GuitarristVO("Mark Knopfler", "Local Hero", 1983),
			new GuitarristVO("Eric Sardinas", "Treat Me Right", 1999),
			new GuitarristVO("Mike Oldfield", "Tubular Bells", 1973),
			new GuitarristVO("Van Halen", "1984", 1984)
		]);
		
		public function get guitarrists():ArrayList
		{
			return _guitarrists;
		}
	} 
}