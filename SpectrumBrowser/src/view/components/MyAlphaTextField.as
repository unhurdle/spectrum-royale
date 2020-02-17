package view.components
{
	import com.unhurdle.spectrum.TextField;
	import org.apache.royale.html.accessories.RestrictTextInputBead;
	import org.apache.royale.html.beads.DispatchInputFinishedBead;

	public class MyAlphaTextField extends TextField
	{

		public function MyAlphaTextField()
		{
            super();
			quiet = true;
            var restrictBead:RestrictTextInputBead = new RestrictTextInputBead();
            restrictBead.restrict = "0123456789%";
            var inputFinishedBead:DispatchInputFinishedBead = new DispatchInputFinishedBead();
            addBead(restrictBead);
            addBead(inputFinishedBead);
		}
    }
}