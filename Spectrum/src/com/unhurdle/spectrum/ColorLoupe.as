package com.unhurdle.spectrum
{
    COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
    }
    public class ColorLoupe extends SpectrumBase
    {
        public function ColorLoupe()
        {
            super();
        }
        override protected function getSelector():String{
            return "spectrum-ColorLoupe";
        }
        
		private var colorDiv:HTMLElement;
        override protected function getTag():String{
            return "svg";
        }
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = super.createElement();
            var colorLoupeElem:HTMLDivElement = newElement("div") as HTMLDivElement;
            var svgElement:SVGElement = newIconSVG("");
            var innerPathElement:SVGElement = newSVGElement("path","");
            innerPathElement.setAttribute("class","spectrum-ColorLoupe-inner");
            innerPathElement.setAttribute("d","M24,0A24,24,0,0,1,48,24c0,16.255-24,40-24,40S0,40.255,0,24A24,24,0,0,1,24,0Z");
            innerPathElement.setAttribute("fill","rgba(255, 0, 0, 0.5)");
            svgElement.appendChild(innerPathElement);
            var outerPathElement:SVGElement = newSVGElement("path","");
            outerPathElement.setAttribute("class","spectrum-ColorLoupe-outer");
            outerPathElement.setAttribute("d","M24,2A21.98,21.98,0,0,0,2,24c0,6.2,4,14.794,11.568,24.853A144.233,144.233,0,0,0,24,61.132,144.085,144.085,0,0,0,34.4,48.893C41.99,38.816,46,30.209,46,24A21.98,21.98,0,0,0,24,2m0-2A24,24,0,0,1,48,24c0,16.255-24,40-24,40S0,40.255,0,24A24,24,0,0,1,24,0Z");
            outerPathElement.setAttribute("fill","rgb(255, 255, 255)");
            svgElement.appendChild(outerPathElement);
            colorLoupeElem.appendChild(svgElement);
            elem.appendChild(colorLoupeElem);
			return elem;
        }
        private var _open:Boolean;

        public function get open():Boolean
        {
            return _open;
        }

        public function set open(value:Boolean):void
        {
        if(value != _open){
            _open = value;
            toggle("is-open",value);
        }
        }
    }
}