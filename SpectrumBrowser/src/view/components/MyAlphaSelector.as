package view.components
{
	import org.apache.royale.html.Slider;

	public class MyAlphaSelector extends Slider
	{
		public function MyAlphaSelector()
		{
			super();
			typeNames = "AlphaSelector CheckeredBackground";
			minimum = 0;
			maximum = 100;
		}
	}
}
