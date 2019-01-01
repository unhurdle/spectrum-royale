package com.unhurdle.spectrum
{
    
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
    COMPILE::SWF
    public class Dial extends SpectrumBase{}
    COMPILE::JS
    public class Dial extends SpectrumBase
    {
        public function Dial()
        {
            super();
            typeNames = "spectrum-Dial"
        }
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            var controls:HTMLDivElement = newElement("div") as HTMLDivElement();
            controls.className = "spectrum-Dial-controls";
            var handle:HTMLDivElement = newElement("div") as HTMLDivElement();
            handle.className = "spectrum-Dial-handle";
            handle.setAttribute("tabindex",0);
            var input:HTMLInputElement = newElement("input") as HTMLInputElement();
            input.className = "spectrum-Dial-input";
            input.type = "range";
            input.value = "0";
            input.min = "0";
            input.max = "100";
            handle.appendChild(input);
            elem.appendChild(handle);
            elem.appendChild(controls);
            //without label
            return elem;
        }
        private var _size:String;

        public function get size():String
        {
            return _size;
        }

        public function set size(value:String):void
        {
            if(value != _size){
                switch (value){
                case "small":
                case "large":
                    break;
                default:
                    throw new Error("Invalid size: " + value);
                }
                var oldSize:String = valueToCSS(_size);
                var newSize:String = valueToCSS(value);
                toggle(this,newSize, true);
                toggle(this,oldSize, false);
                _size = value;
            }
        }
        private var _isDisabled:Boolean;

        public function get isDisabled():Boolean
        {
            return _isDisabled;
        }

        public function set isDisabled(value:Boolean):void
        {
            if(value != !!_isDisabled){
                toggle(this,valueToCSS("is-disabled"),value);
            }
            _isDisabled = value;
        }
        private function valueToCSS(stop:String):String{
            return "spectrum-CoachMarkIndicator--" + stop;
        }
    }
}