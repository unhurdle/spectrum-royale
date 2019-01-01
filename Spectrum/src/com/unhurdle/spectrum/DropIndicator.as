package com.unhurdle.spectrum
{
    
        COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
    COMPILE::SWF
    public class DropIndicator extends SpectrumBase{}
    COMPILE::JS
    public class DropIndicator extends SpectrumBase
    {
        public function DropIndicator()
        {
            super();
            typeNames = "spectrum-DropIndicator"
        }
        
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            return elem;
        }
        private var _direction:String;

        public function get direction():String
        {
            return _direction;
        }

        public function set direction(value:String):void
        {
            if(value != _direction){
                switch (value){
                    case "vertical":
                    case "horizontal":
                        break;
                    default:
                        throw new Error("Invalid direction: " + value);
                }
                var oldDirection:String = valueToCSS(_direction);
                var newDirection:String = valueToCSS(value);
                toggle(newDirection, true);
                toggle(oldDirection, false);
                _direction = value;
            }
        }
        private function valueToCSS(direction:String):String{
            return "spectrum-DropIndicator--" + direction;
        }
    }
}