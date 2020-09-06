package com.unhurdle.spectrum
{
    COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.html.util.addElementToWrapper;
    }
    import org.apache.royale.svg.elements.Path;

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
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = addElementToWrapper(this,'svg');
            var inner:Path = new Path();
            inner.className = appendSelector("-inner");
            inner.d = "M24,0A24,24,0,0,1,48,24c0,16.255-24,40-24,40S0,40.255,0,24A24,24,0,0,1,24,0Z";
            inner.fill="rgba(255, 0, 0, 0.5)";
            elem.appendChild(inner.element);

            var outer:Path = new Path();
            outer.d = "M24,2A21.98,21.98,0,0,0,2,24c0,6.2,4,14.794,11.568,24.853A144.233,144.233,0,0,0,24,61.132,144.085,144.085,0,0,0,34.4,48.893C41.99,38.816,46,30.209,46,24A21.98,21.98,0,0,0,24,2m0-2A24,24,0,0,1,48,24c0,16.255-24,40-24,40S0,40.255,0,24A24,24,0,0,1,24,0Z";
            elem.appendChild(outer.element);
			// element.addEventListener('mousedown', onMouseDown);
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