package com.unhurdle.spectrum
{
    import org.apache.royale.core.UIBase;
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
    // COMPILE::SWF
    // public class ClearButton extends UIBase{}
    COMPILE::JS
    public class ClearButton extends SpectrumBase
    {
        public function ClearButton()
        {
            super();
            typeNames = "spectrum-ClearButton";
        }
        // COMPILE::JS
        private var svgElement:SVGElement;
        private var useElement:SVGUseElement;
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'button');
            svgElement = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
            useElement = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGUseElement;
            useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-CrossSmall');
            svgElement.className = "spectrum-Icon spectrum-UIIcon-CrossSmall";
            svgElement.setAttribute("focusable",false);
            svgElement.appendChild(useElement);
            elem.appendChild(svgElement);
            return elem;
        }
        // COMPILE::JS
        private var button:HTMLButtonElement;
        private var _disabled:Boolean;

        public function get disabled():Boolean
        {
        	return _disabled;
        }
        // COMPILE::JS
        public function set disabled(value:Boolean):void
        {
            if(value != !!_disabled){
                button.disabled = value;
            }
        	_disabled = value;
        }
        private var _small:Boolean;

        public function get small():Boolean
        {
        	return _small;
        }

        public function set small(value:Boolean):void
        {
            if(value && !_small){
                toggle("spectrum-ClearButton--small",true);
            }
        	_small = value;
        }
    }
}