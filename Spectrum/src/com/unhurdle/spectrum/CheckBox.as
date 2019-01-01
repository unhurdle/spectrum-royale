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

        COMPILE::JS
        private var textNode:Text;

        COMPILE::SWF
        private var textNode:Object;
        
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'label');
            input = newElement("input") as HTMLInputElement;
            input.setAttribute("type","checkbox");
            input.setAttribute("class","spectrum-Checkbox-input");
            input.id = UIDUtil.createUID();//?? should this be uidtil ??
            elem.appendChild(input);
            var span:HTMLSpanElement = newElement("span") as HTMLSpanElement;
            span.setAttribute("class","spectrum-Checkbox-box");
            var svgElement:SVGElement = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
            var useElement:SVGUseElement = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGUseElement;
            useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-CheckmarkSmall');
            svgElement.className = "spectrum-Icon spectrum-UIIcon-CheckmarkSmall spectrum-Checkbox-checkmark";
            svgElement.setAttribute("focusable",false);
            svgElement.appendChild(useElement);
            span.appendChild(svgElement);
            svgElement = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
            useElement = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGUseElement;
            useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-DashSmall');
            svgElement.className = "spectrum-Icon spectrum-UIIcon-DashSmall spectrum-Checkbox-partialCheckmark";
            svgElement.setAttribute("focusable",false);
            svgElement.appendChild(useElement);
            span.appendChild(svgElement);
            elem.appendChild(span);
            span = newElement("span") as HTMLSpanElement;
            span.className = "spectrum-Checkbox-label";
            if(!_text){
                _text = "";
            }
            textNode = newTextNode(_text);
            span.appendChild(textNode);
            elem.appendChild(span);
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
                textNode.nodeValue = value;
            }
            _text = value;
        }
        private var _isInvalid:Boolean;

        public function get isInvalid():Boolean
        {
        	return _isInvalid;
        }

        public function set isInvalid(value:Boolean):void
        {
            if(value != !!_isInvalid){
                toggle("is-invalid",value);
            }
        	_isInvalid = value;
        }
        private var _isIndeterminate:Boolean;

        public function get isIndeterminate():Boolean
        {
        	return _isIndeterminate;
        }

        public function set isIndeterminate(value:Boolean):void
        {
            if(value != !!_isIndeterminate){
                toggle("is-indeterminate",value);
            }
        	_isIndeterminate = value;
        }
        private var _isDisabled:Boolean;

        public function get isDisabled():Boolean
        {
        	return _isDisabled;
        }

        public function set isDisabled(value:Boolean):void
        {
            if(value != !!_isDisabled){
                toggle("is-disabled",value);
                COMPILE::JS
                {
                    input.disabled = value;
                }
            }
        	_isDisabled = value;
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
    }
}