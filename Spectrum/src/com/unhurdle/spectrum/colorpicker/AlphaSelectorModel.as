package com.unhurdle.spectrum.colorpicker
{
    import org.apache.royale.core.IColorModel;
    import org.apache.royale.html.beads.models.RangeModel;
	import org.apache.royale.events.Event;
	
	public class AlphaSelectorModel extends RangeModel implements IColorModel
	{
        private var _color:Number;

		public function AlphaSelectorModel()
		{
		}

        [Bindable("change")]
        public function get color():Number
        {
        	return _color;
        }

        public function set color(value:Number):void
        {
        	_color = value;
			dispatchEvent(new Event("change"));
        }

	}
}
