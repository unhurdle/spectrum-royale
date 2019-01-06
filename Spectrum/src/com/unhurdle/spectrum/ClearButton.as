package com.unhurdle.spectrum
{
    COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.html.util.addElementToWrapper;
    }

    public class ClearButton extends SpectrumBase
    {
        public function ClearButton()
        {
            super();
            typeNames = "spectrum-ClearButton";
            toggle("spectrum-ClearButton--medium",true);
        }
        private function setIcon(size:String):void{
            icon.selector = '#spectrum-css-icon-Cross' + size;
            icon.className = "spectrum-Icon spectrum-UIIcon-Cross" + size;
        }
        private var icon:Icon;
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            button = addElementToWrapper(this,'button') as HTMLButtonElement;
            icon = new Icon("#spectrum-css-icon-CrossMedium");
            setIcon("Medium");
            element.appendChild(icon.getElement());
            return element;
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
            toggle("spectrum-ClearButton--small",value);
            toggle("spectrum-ClearButton--medium",!value);
            var size:String = value ? "Small" : "Medium";
            setIcon(size);
        	_small = value;
        }
        
        private var _overBackground:Boolean;

        public function get overBackground():Boolean
        {
        	return _overBackground;
        }

        public function set overBackground(value:Boolean):void
        {
            toggle("spectrum-ClearButton--overBackground",value);
        	_overBackground = value;
        }
    }
}