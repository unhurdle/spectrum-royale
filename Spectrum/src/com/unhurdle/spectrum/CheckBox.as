package com.unhurdle.spectrum
{
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.utils.UIDUtil;
    }

    public class CheckBox extends SpectrumBase
    {
        public function CheckBox()
        {
            super();
            typeNames = "spectrum-Checkbox";
        }
        COMPILE::JS
        private var input:HTMLInputElement;

        private var spanLabel:TextNode;
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'label');
            input = newElement("input") as HTMLInputElement;
            input.setAttribute("type","checkbox");
            input.setAttribute("class","spectrum-Checkbox-input");
            input.id = UIDUtil.createUID();//?? should this be uidtil ??
            elem.appendChild(input);
            // var span:HTMLSpanElement = newElement("span") as HTMLSpanElement;
            // span = new TextNode("");
            var spanBox:HTMLSpanElement = newElement("span") as HTMLSpanElement;
            spanBox.className = "spectrum-Checkbox-box";
            var svgElement:SVGElement = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
            var useElement:SVGUseElement = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGUseElement;
            useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-CheckmarkSmall');
            svgElement.setAttribute("class","spectrum-Icon spectrum-UIIcon-CheckmarkSmall spectrum-Checkbox-checkmark");
            svgElement.setAttribute("focusable",false);
            svgElement.appendChild(useElement);
            spanBox.appendChild(svgElement);
            svgElement = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
            useElement = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGUseElement;
            useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-DashSmall');
            svgElement.setAttribute("class","spectrum-Icon spectrum-UIIcon-DashSmall spectrum-Checkbox-partialCheckmark");
            svgElement.setAttribute("focusable",false);
            svgElement.appendChild(useElement);
            spanBox.appendChild(svgElement);
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
                COMPILE::JS
                {
                    input.disabled = value;
                }
            }
        	_disabled = value;
        }
        private var _checked:Boolean;

        public function get checked():Boolean
        {
        	return _checked;
        }

        public function set checked(value:Boolean):void
        {
            if(value != !!_checked){
                COMPILE::JS
                {
                    input.checked = value;

                }
            }
        	_checked = value;
        }
        private var _quite:Boolean;

        public function get quite():Boolean
        {
        	return _quite;
        }

        public function set quite(value:Boolean):void
        {
            if(value && !_quite){
                toggle("spectrum-Checkbox--quiet",true);
            }
        	_quite = value;
        }
    }
}