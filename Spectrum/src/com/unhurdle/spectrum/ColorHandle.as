package com.unhurdle.spectrum
{
    COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.html.util.addElementToWrapper;
    }
    import com.unhurdle.spectrum.const.IconType;
    import org.apache.royale.events.Event;

    public class ColorHandle extends SpectrumBase
    {
        public function ColorHandle()
        {
            super();
        }
        override protected function getSelector():String{
            return "spectrum-ColorHandle";
        }
        
		private var colorLoupe:ColorLoupe;
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            elem.style.position = "absolute";
			var colorDiv:HTMLElement = newElement("div",appendSelector("-color"));
			elem.appendChild(colorDiv);
			// element.addEventListener('mousedown', onMouseDown);
			return elem;
        }
        
        private var _disabled:Boolean = false;

        public function get disabled():Boolean
        {
            return _disabled;
        }

        public function set disabled(value:Boolean):void
        {
            if(value != _disabled){
                _disabled = value;
                toggle("is-disabled",value);
            }
        }
        
        private var _open:Boolean = false;

        public function get open():Boolean
        {
            return _open;
        }

        public function set open(value:Boolean):void
        {
            if(value != _open){
                _open = value;
                if(value){
                    if(!colorLoupe){
                        colorLoupe = new ColorLoupe();
                        addElement(colorLoupe);
                    }
                }else{
                    if(colorLoupe){
                        removeElement(colorLoupe);
                        colorLoupe = null;
                    }
                }
            }
        }
    }
}