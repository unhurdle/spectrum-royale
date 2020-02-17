package view.components
{
    import org.apache.royale.core.IStrand;
	
	public class MyAlphaSelectorView extends MySliderView
	{
		public function MyAlphaSelectorView()
		{
		}
		
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
			var bead:AddCheckeredBackgroundBead = new AddCheckeredBackgroundBead();
			value.addBead(bead);
		}
	}
}
