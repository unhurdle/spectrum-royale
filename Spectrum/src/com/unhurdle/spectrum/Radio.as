package com.unhurdle.spectrum
{
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.utils.UIDUtil;
    }

    public class Radio extends SpectrumBase
    {
        public function Radio()
        {
            super();
            typeNames = "spectrum-Radio";
        }
        COMPILE::JS
        private var input:HTMLInputElement;

        COMPILE::SWF
        private var input:Object;

        private var label:TextNode;


        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            input = newElement("input") as HTMLInputElement;
            input.className = "spectrum-Radio-input";
            input.type = "radio";
            input.id = UIDUtil.createUID();
            elem.appendChild(input);
            var span:HTMLSpanElement = newElement("span") as HTMLSpanElement;
            span.className = "spectrum-Radio-button";
            elem.appendChild(span);
            label = new TextNode("");
            label.element = newElement("label") as HTMLLabelElement;
            label.className = "spectrum-Radio-label";
            elem.appendChild(label.element);
            return elem;
        }
        private var _checked:Boolean;

        private function get checked():Boolean
        {
        	return _checked;
        }

        private function set checked(value:Boolean):void
        {
            if(value != !!_checked){
                input.checked = value;
            }
        	_checked = value;
        }

        private var _disabled:Boolean;

        public function get disabled():Boolean
        {
        	return _disabled;
        }

        public function set disabled(value:Boolean):void
        {
            if(value != !!_disabled){
                input.disabled = value;
            }
        	_disabled = value;
        }
        private var _valid:Boolean;
        public function get valid():Boolean
        {
            return _valid;
        }
        public function set valid(value:Boolean):void
        {
            if(value == !!_valid){
                toggle("is-invalid",!value);
            }
            _valid = value;
        }
        private var _text:String;
        public function get text():String
        {
        	return _text;
        }

        public function set text(value:String):void
        {
        	_text = value
        	label.text = value;
        }
         public function get radioName():String
        {
        	return input.name;
        }
        
        public function set radioName(value:String):void
        {
            input.name = value;
        }
    }
}