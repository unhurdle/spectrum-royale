package com.unhurdle.spectrum.colorpicker
{
	import com.unhurdle.spectrum.TextField;
	import org.apache.royale.html.accessories.RestrictTextInputBead;
	import org.apache.royale.html.beads.DispatchInputFinishedBead;
	
	[Event(name="inputFinished", type="org.apache.royale.events.Event")]
	public class ColorTextField extends TextField
	{

		public function ColorTextField()
		{
			super();
			quiet = true;
			var restrictBead:RestrictTextInputBead = new RestrictTextInputBead();
			restrictBead.restrict = "#01234567890ABCDEFabcdef";
			var inputFinishedBead:DispatchInputFinishedBead = new DispatchInputFinishedBead();
			addBead(restrictBead);
			addBead(inputFinishedBead);
			COMPILE::JS
			{
				input.style.textTransform = "uppercase";
				//TODO move this into a bead
				input.addEventListener("focus",function():*{
						input.setSelectionRange(0,text.length);
				});
			}
		}
	}
}
