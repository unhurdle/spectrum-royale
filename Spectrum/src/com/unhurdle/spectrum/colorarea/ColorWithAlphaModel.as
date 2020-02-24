package com.unhurdle.spectrum.colorarea
{
	import org.apache.royale.html.beads.models.ColorModel;
	import org.apache.royale.events.Event;

	public class ColorWithAlphaModel extends ColorModel
	{
        private var _alpha:Number = 1;

        public function get alpha():Number
        {
        	return _alpha;
        }

        public function set alpha(value:Number):void
        {
            if (_alpha != value)
            {
                _alpha = value;
                dispatchEvent(new Event("change"));
            }
        }
	}
}
