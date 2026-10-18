package com.unhurdle.spectrum
{

	import org.apache.royale.geom.Rectangle;
	import com.unhurdle.spectrum.utils.getPopUpHostLocalBounds;

	[Event(name="change", type="org.apache.royale.events.Event")]
	public class TagComboBoxList extends ComboBoxList
	{
		public override function positionPopup(componentBounds:Rectangle,preferredWidth:Number = NaN,skipSpaceCalculation:Boolean = true):void
		{
			super.positionPopup(componentBounds, preferredWidth, skipSpaceCalculation);
			var appBounds:Rectangle = getPopUpHostLocalBounds(Application.current.initialView);
			var availableWidth:Number = appBounds.width - componentBounds.x;
			setStyle("maxWidth",availableWidth + "px");
			var leftSpace:Number = componentBounds.x;
			setStyle("left",leftSpace + "px");
		}
	}
}