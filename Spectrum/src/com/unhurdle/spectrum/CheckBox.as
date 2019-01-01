package com.unhurdle.spectrum
{
    // import org.apache.royale.core.UIBase;
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.utils.UIDUtil;
    }
    // COMPILE::SWF
    // public class CheckBox extends UIBase{}
    COMPILE::JS
    public class CheckBox extends spectrum
    {
        public function CheckBox()
        {
            super();
            typeNames = "spectrum-Checkbox";
        }
        private var input:HTMLInputElement;
        private var svgElement1:SVGElement;
        private var useElement1:SVGUseElement;
        private var svgElement2:SVGElement;
        private var useElement2:SVGUseElement;
        private var span2:HTMLSpanElement;
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'label');
            input = newElement("input") as HTMLInputElement();
            input.setAttribute("type","checkbox");
            input.setAttribute("class","spectrum-Checkbox-input");
            input.id = UIDUtil.createUID();//?? should this be uidtil ??
            elem.appendChild(input);
            var span1:HTMLSpanElement = newElement("span") as HTMLSpanElement();
            span1.setAttribute("class","spectrum-Checkbox-box");
            svgElement1 = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
            useElement1 = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGUseElement;
            useElement1.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-CheckmarkSmall');
            svgElement1.className = "spectrum-Icon spectrum-UIIcon-CheckmarkSmall spectrum-Checkbox-checkmark";
            svgElement1.setAttribute("focusable",false);
            svgElement1.appendChild(useElement1);
            span1.appendChild(svgElement1);
            svgElement2 = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
            useElement2 = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGUseElement;
            useElement2.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-DashSmall');
            svgElement2.className = "spectrum-Icon spectrum-UIIcon-DashSmall spectrum-Checkbox-partialCheckmark";
            svgElement2.setAttribute("focusable",false);
            svgElement2.appendChild(useElement2);
            span1.appendChild(svgElement2);
            elem.appendChild(span1);
            span2 = newElement("span") as HTMLSpanElement();
            span2.className = "spectrum-Checkbox-label";
            elem.appendChild(span2);
            return elem;
        }
        public function get text():String
        {
        	return span2.text;
        }

        public function set text(value:String):void
        {
            span2.text = value;
        }
        private var _isInvalid:Boolean;

        public function get isInvalid():Boolean
        {
        	return _isInvalid;
        }

        public function set isInvalid(value:Boolean):void
        {
            if(value != !!_isInvalid){
                toggle(this,"is-invalid",value);
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
                toggle(this,"is-indeterminate",value);
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
                toggle(this,"is-disabled",value);
                if(value){
                    input.setAttribute("disabled","");
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
            if(value){
                input.setAttribute("checked","");
            }
        	_checked = value;
        }
    }
}