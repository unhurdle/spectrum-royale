package com.unhurdle.spectrum
{
    
        COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }

    public class DropIndicator extends SpectrumBase
    {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/dropindicator/dist.css">
     * </inject_html>
     * 
     */
        public function DropIndicator()
        {
            super();
            direction = "horizontal";
        }
        override protected function getSelector():String{
            return "spectrum-DropIndicator";
        }
        
        COMPILE::JS
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
            var elem:HTMLElement = element as HTMLElement;
            if(value != _direction){
                switch (value){
                    case "vertical":elem.offsetWidth = 20;
                                    elem.offsetHeight = 2;
                        break;
                    case "horizontal":elem.offsetWidth = 2;
                                    elem.offsetHeight = 20;
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