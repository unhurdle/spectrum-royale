package com.unhurdle.spectrum
{
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
    /**
     *  Dispatched when the user checks or un-checks the CheckBox.
     *
     */
	[Event(name="change", type="org.apache.royale.events.Event")]

    public class CheckBox extends SpectrumBase
    {
        public function CheckBox()
        {
            super();
            typeNames = "spectrum-Checkbox";
        }
        COMPILE::JS
        private var input:HTMLInputElement;

        COMPILE::SWF
        private var input:Object;

        private function elementClicked():void{
            indeterminate = false;
            checked = !checked;
        }
        private var spanLabel:TextNode;
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'label');
            input = newElement("input") as HTMLInputElement;
            input.setAttribute("type","checkbox");
            input.setAttribute("class","spectrum-Checkbox-input");
            input.onclick = elementClicked;
            elem.appendChild(input);
            var spanBox:HTMLSpanElement = newElement("span") as HTMLSpanElement;
            spanBox.className = "spectrum-Checkbox-box";
            var icon:Icon = new Icon("#spectrum-css-icon-CheckmarkSmall")
            icon.className = "spectrum-Icon spectrum-UIIcon-CheckmarkSmall spectrum-Checkbox-checkmark";
            icon.selector = "#spectrum-css-icon-CheckmarkSmall";
            spanBox.appendChild(icon.getElement());
            icon = new Icon("#spectrum-css-icon-DashSmall");
            icon.className = "spectrum-Icon spectrum-UIIcon-DashSmall spectrum-Checkbox-partialCheckmark";
            icon.selector = "#spectrum-css-icon-DashSmall";
            spanBox.appendChild(icon.getElement());
            elem.appendChild(spanBox);
            spanLabel = new TextNode("");
            spanLabel.element = newElement("span") as HTMLSpanElement;
            spanLabel.className = "spectrum-Checkbox-label";
            if(!_text){
                _text = "";
            }
            // textNode = newTextNode(_text);
            // span.element.appendChild(textNode);
            elem.appendChild(spanLabel.element);
            return elem;
        }

        private var _text:String;
        public function get text():String
        {
        	return _text;
        }

        public function set text(value:String):void
        {
            if(_text != value){
                spanLabel.text = value;
                // textNode.nodeValue = value;
            }
            _text = value;
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
        private var _indeterminate:Boolean;

        public function get indeterminate():Boolean
        {
        	return _indeterminate;
        }

        public function set indeterminate(value:Boolean):void
        {
            if(value != !!_indeterminate){
                toggle("is-indeterminate",value);
                checked = false;
            }
        	_indeterminate = value;
        }
        private var _disabled:Boolean;

        public function get disabled():Boolean
        {
        	return _disabled;
        }

        public function set disabled(value:Boolean):void
        {
            if(value != !!_disabled){
                toggle("is-disabled",value);
                input.disabled = value;
            }
        	_disabled = value;
        }
        private var _checked:Boolean;
        [Bindable]
        public function get checked():Boolean
        {
        	return _checked;
        }

        public function set checked(value:Boolean):void
        {
            if(value != !!_checked){
                input.checked = value;
                indeterminate = false;
            }
        	_checked = value;
        }
        private var _quiet:Boolean;

        public function get quiet():Boolean
        {
        	return _quiet;
        }

        public function set quiet(value:Boolean):void
        {
            if(value && !_quiet){
                toggle("spectrum-Checkbox--quiet",true);
            }
        	_quiet = value;
        }
    }
}