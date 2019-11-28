package com.unhurdle.spectrum
{
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }

    public class Radio extends SpectrumBase
    {
        public function Radio()
        {
            super();
        }
        override protected function getSelector():String{
            return "spectrum-Radio";
        }
        private var input:HTMLInputElement;

        private var label:TextNode;


        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            input = newElement("input",appendSelector("-input")) as HTMLInputElement;
            input.type = "radio";
            elem.appendChild(input);
            elem.appendChild(newElement("span",appendSelector("-button")));
            label = new TextNode("label");
            label.className = appendSelector("-label");
            elem.appendChild(label.element);
            return elem;
        }
        private var _checked:Boolean;

        public function get checked():Boolean
        {
        	return _checked;
        }

        public function set checked(value:Boolean):void
        {
            if(value != !!_checked){
                input.checked = value;
            }
        	_checked = value;
        }
        private var _labelBelow:Boolean;

        public function get labelBelow():Boolean
        {
        	return _labelBelow;
        }

        public function set labelBelow(value:Boolean):void
        {
            if(value != !!_labelBelow){
                toggle(valueToSelector("labelBelow"),value);
            }
        	_labelBelow = value;
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
        private var _invalid:Boolean;
        public function get invalid():Boolean
        {
            return _invalid;
        }
        public function set invalid(value:Boolean):void
        {
            if(value == !!_invalid){
                toggle("is-invalid",value);
            }
            _invalid = value;
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

        private var _quiet:String;
        public function get quiet():String
        {
        	return _quiet;
        }

        public function set quiet(value:String):void
        {
        	_quiet = value
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