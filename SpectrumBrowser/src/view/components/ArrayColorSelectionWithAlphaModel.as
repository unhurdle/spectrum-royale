package view.components
{
	import org.apache.royale.html.beads.models.ArrayColorSelectionModel;
	import org.apache.royale.events.Event;
	import org.apache.royale.core.IColorWithAlphaModel;

	public class ArrayColorSelectionWithAlphaModel extends ArrayColorSelectionModel
	{
        private var _alpha:Number = 1;
        private var _color:uint;

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
            _color = (selectedItem as IColorWithAlphaModel).color;
            _alpha = (selectedItem as IColorWithAlphaModel).alpha;
            super.dispatchChangeEvent(event);
        }

		override public function get color():Number
		{
			return _color;
		}

        // Usage of this method implies color uniqueness. If that's not the case set selectedItem instead.
		override public function set color(value:Number):void
		{
            if (value == _color)
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
                    var colorModel:IColorWithAlphaModel = dataProvider[i] as IColorWithAlphaModel;
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
                dispatchEvent(new Event("change"))
            }
		}
		
	}
}
