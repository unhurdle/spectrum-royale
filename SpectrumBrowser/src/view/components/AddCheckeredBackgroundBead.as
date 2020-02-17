package view.components
{
    import org.apache.royale.core.IStrand;
    import org.apache.royale.html.elements.Div;
    import org.apache.royale.core.IParent;
    import org.apache.royale.core.IBead;
	
	public class AddCheckeredBackgroundBead implements IBead
	{
		public function AddCheckeredBackgroundBead()
		{
		}
		
		public function set strand(value:IStrand):void
		{
            var bg:Div = new Div();
            bg.className = "CheckeredBackground";
            (value as IParent).addElement(bg);
		}
	}
}
