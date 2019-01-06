package com.unhurdle.spectrum
{
    
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }

    public class Dial extends SpectrumBase
    {
        public function Dial()
        {
            super();
        }

        override protected function getSelector():String{
            return "spectrum-Dial";
        }

        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            if(_withLabel){
                var labelContainer:HTMLElement = newElement("div","spectrum-Dial-labelContainer");
                var label:HTMLLabelElement = newElement("label") as HTMLLabelElement;
                label.className = "spectrum-Dial-label";
                label.id = "dialLabel";
                label.setAttribute("for","labeledDial");
                labelContainer.appendChild(label);
                var div:HTMLDivElement = newElement("div") as HTMLDivElement;
                div.className = "spectrum-Slider-value";
                div.setAttribute("role","textbox");
                div.setAttribute("aria-readonly",true);
                div.setAttribute("aria-labelledby","dialLabel");
                labelContainer.appendChild(div);
                elem.appendChild(labelContainer);
            }
            var controls:HTMLDivElement = newElement("div") as HTMLDivElement;
            controls.className = "spectrum-Dial-controls";
            var handle:HTMLDivElement = newElement("div") as HTMLDivElement;
            handle.className = "spectrum-Dial-handle";
            handle.setAttribute("tabindex",0);
            var input:HTMLInputElement = newElement("input") as HTMLInputElement;
            input.className = "spectrum-Dial-input";
            if(_withLabel){
                input.id = "labeledDial";//when label
            }
            input.type = "range";
            input.value = "0";
            input.min = "0";
            input.max = "100";
            handle.appendChild(input);
            controls.appendChild(handle);
            elem.appendChild(controls);
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
                var oldSize:String = valueToSelector(_size);
                var newSize:String = valueToSelector(value);
                toggle(newSize, true);
                toggle(oldSize, false);
                _size = value;
            }
        }private var _withLabel:Boolean;

        public function get withLabel():Boolean
        {
            return _withLabel;
        }

        public function set withLabel(value:Boolean):void
        {            
            _withLabel = value;
        }
        private var _isDisabled:Boolean;

        public function get isDisabled():Boolean
        {
            return _isDisabled;
        }

        public function set isDisabled(value:Boolean):void
        {
            if(value != !!_isDisabled){
                toggle(valueToSelector("is-disabled"),value);
            }
            _isDisabled = value;
        }
    }
}