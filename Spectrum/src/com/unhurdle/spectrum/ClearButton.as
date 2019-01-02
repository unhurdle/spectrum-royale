package com.unhurdle.spectrum
{
    COMPILE::JS
    {
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.html.util.addElementToWrapper;
    }

    public class ClearButton extends SpectrumBase
    {
        public function ClearButton()
        {
            super();
            typeNames = "spectrum-ClearButton";
        }

        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            // var elem:WrappedHTMLElement = addElementToWrapper(this,'button');
            button = addElementToWrapper(this,'button') as HTMLButtonElement;
            var svgElement:SVGElement = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
            var useElement:SVGElement = document.createElementNS('http://www.w3.org/2000/svg', 'use') as SVGElement;
            useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#spectrum-css-icon-CrossSmall');
            svgElement.setAttribute("class","spectrum-Icon spectrum-UIIcon-CrossSmall");
            svgElement.setAttribute("focusable",false);
            svgElement.appendChild(useElement);
            // elem.appendChild(svgElement);
            button.appendChild(svgElement);
            return button as WrappedHTMLElement;
            // return elem;
        }
        COMPILE::JS
        private var button:HTMLButtonElement;

        COMPILE::SWF
        private var button:Object;
        
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