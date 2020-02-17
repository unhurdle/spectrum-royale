package view.components
{
    import org.apache.royale.core.IStrand;
    import org.apache.royale.html.elements.Div;
    import org.apache.royale.core.IParent;
    import org.apache.royale.core.IRenderedObject;
	
	public class MyAlphaSelectorView extends MySliderView
	{
		public function MyAlphaSelectorView()
		{
		}
		
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
            var bg:Div = new Div();
            bg.className = "CheckeredBackground";
            (host as IParent).addElement(bg);
		}
	}
}
