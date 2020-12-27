package com.unhurdle.spectrum.colorpicker
{
	import org.apache.royale.html.beads.models.ArrayColorSelectionModel;
	import org.apache.royale.core.IColorModel;
	import org.apache.royale.events.Event;
	import org.apache.royale.core.IColorWithAlphaModel;

	public class ArrayColorSelectionWithAlphaModel extends ArrayColorSelectionModel implements IColorWithAlphaModel
	{
        private var _alpha:Number = 1;
        private var _color:Number;

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

        override protected function dispatchChangeEvent(event:Event):void
        {
            if (selectedItem)
            {
                _color = (selectedItem as IColorModel).color;
                _alpha = (selectedItem as ColorWithAlphaModel).alpha;
            }
            super.dispatchChangeEvent(event);
        }

		override public function get color():Number
		{
			return _color;
		}

        // Usage of this method implies color uniqueness. If that's not the case set selectedItem instead.
		override public function set color(value:Number):void
		{
            if (value == _color || isNaN(value) && isNaN(_color))
            {
                return;
            }
            _color = value;
            var eventDispatched:Boolean = false;
            if (dataProvider)
            {
                var length:int = (dataProvider as Array).length;
                for (var i:int = 0; i < length; i++) 
                {
                    var colorModel:IColorModel = dataProvider[i] as IColorModel;
                    if (colorModel.color == value)
                    {
                        // also dispatches change
                        selectedItem = colorModel;
                        eventDispatched = true;
                        break;
                    }
                }
            } 
            if (!eventDispatched)
            {
                selectedItem = null;
                dispatchEvent(new Event("change"))
            }
		}
		
	}
}
