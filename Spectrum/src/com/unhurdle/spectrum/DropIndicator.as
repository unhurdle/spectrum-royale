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
            direction = "horizontal";
        }
        override protected function getSelector():String{
            return "spectrum-DropIndicator";
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
                if(_direction){
                    var oldDirection:String = valueToSelector(_direction);
                    toggle(oldDirection, false);
                }
                var newDirection:String = valueToSelector(value);
                toggle(newDirection, true);
                _direction = value;
            }
        }
    }
}