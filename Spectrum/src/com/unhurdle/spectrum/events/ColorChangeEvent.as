package com.unhurdle.spectrum.events
{
	import org.apache.royale.events.Event;
	import com.unhurdle.spectrum.interfaces.IRGBA;

	public class ColorChangeEvent extends Event
	{
		public static const COLOR_CHANGED:String = "colorChanged";
		public function ColorChangeEvent(type:String)
		{
			super(type);
		}
		public var oldColor:IRGBA;
		public var newColor:IRGBA;
	}
}