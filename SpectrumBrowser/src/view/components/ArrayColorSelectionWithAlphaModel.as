package view.components
{
	import org.apache.royale.html.beads.models.ArrayColorSelectionModel;

	public class ArrayColorSelectionWithAlphaModel extends ArrayColorSelectionModel
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
                dispatchEvent("change");
            }
        }
	}
}
