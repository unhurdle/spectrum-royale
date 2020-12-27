package com.unhurdle.spectrum.colorpicker
{
	import com.unhurdle.spectrum.TextField;
	import org.apache.royale.html.accessories.RestrictTextInputBead;
	import org.apache.royale.html.beads.DispatchInputFinishedBead;

	public class AlphaTextField extends TextField
	{

		public function AlphaTextField()
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
