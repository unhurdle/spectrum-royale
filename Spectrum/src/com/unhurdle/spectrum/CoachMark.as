package com.unhurdle.spectrum
{
    
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
    COMPILE::SWF
    public class CoachMark extends SpectrumBase{}
    COMPILE::JS
    public class CoachMark extends SpectrumBase
    {
        public function CoachMark()
        {
            super();
            typeNames = "spectrum-CoachMarkIndicator"
        }
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            var div1:HTMLDivElement = newElement("div") as HTMLDivElement;
            div1.className = "spectrum-CoachMarkIndicator-ring";
            elem.appendChild(div1);
            var div2:HTMLDivElement = newElement("div") as HTMLDivElement;
            div2.className = "spectrum-CoachMarkIndicator-ring";
            elem.appendChild(div2);
            var div3:HTMLDivElement = newElement("div") as HTMLDivElement;
            div3.className = "spectrum-CoachMarkIndicator-ring";
            elem.appendChild(div3);
            //without dialog
            return elem;
        }
        private var _quiet:Boolean;

        public function get quiet():Boolean
        {
            return _quiet;
        }

        public function set quiet(value:Boolean):void
        {
            if(value != !!_quiet){
                toggle(valueToCSS("quiet"),value);
            }
            _quiet = value;
        }

        private var _shade:String;

        public function get shade():String
        {
            return _shade;
        }

        public function set shade(value:String):void
        {
            if(value != _shade){
                switch (value){
                case "small":
                case "large":
                    break;
                default:
                    throw new Error("Invalid size: " + value);
                }
                var oldSize:String = valueToCSS(_shade);
                var newSize:String = valueToCSS(value);
                toggle(newSize, true);
                toggle(oldSize, false);
                _shade = value;
            }
        }
        private function valueToCSS(value:String):String{
            return "spectrum-CoachMarkIndicator--" + value;
        }
    }
}