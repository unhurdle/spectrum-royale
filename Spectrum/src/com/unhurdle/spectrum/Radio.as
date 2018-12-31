package com.unhurdle.spectrum
{
    import org.apache.royale.core.UIBase;
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.utils.UIDUtil;
    }

    public class Radio extends UIBase
    {
        public function Radio()
        {
            super();
            typeNames = "spectrum-Radio";
        }
        private var input:HTMLInputElement;
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            input = newElement("input") as HTMLInputElement();
            input.className = "spectrum-Radio-input";
            input.id = UIDUtil.createUID();
            elem.appendChild(input);
            var span:HTMLSpanElement = newElement("span") as HTMLSpanElement();
            span.className = "spectrum-Radio-button";
            elem.appendChild(span);
            var label:HTMLLabelElement = newElement("label") as HTMLLabelElement();
            label.className = "spectrum-Radio-label";
            elem.appendChild(label);
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

    }
}