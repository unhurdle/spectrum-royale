package com.unhurdle.spectrum.colorpicker
{
	import com.unhurdle.spectrum.TextField;
	import org.apache.royale.html.accessories.RestrictTextInputBead;
	import org.apache.royale.html.beads.DispatchInputFinishedBead;
	import org.apache.royale.utils.number.pinValue;
	import org.apache.royale.utils.sendStrandEvent;

	[Event(name="inputFinished", type="org.apache.royale.events.Event")]
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

			addEventListener("onArrowDown",function(ev:Event):void{
				var value:Number = parseFloat(text);
				if(isNaN(value)){
					changeTextValue(100);
				} else {
					changeTextValue(pinValue(value-1,0,100));
				}
			});
			addEventListener("onArrowUp",function(ev:Event):void{
				var value:Number = parseFloat(text);
				if(isNaN(value)){
					changeTextValue(100);
				} else {
					changeTextValue(pinValue(value+1,0,100));
				}
			});
			
		}
		private function changeTextValue(value:Number):void{
			text = value + "%";
			input.setSelectionRange(0,text.length);
			sendStrandEvent(this,"inputFinished");
		}
	}
}
