package com.unhurdle.spectrum
{
    COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.html.util.addElementToWrapper;
    }
    import com.unhurdle.spectrum.const.IconType;
    import org.apache.royale.events.Event;

	[Event(name="change", type="org.apache.royale.events.Event")]
    public class ClearButton extends SpectrumBase
    {
        public function ClearButton()
        {
            super();
            small = false;
        }
        override protected function getSelector():String{
            return "spectrum-ClearButton";
        }

        private var icon:Icon;
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            button = addElementToWrapper(this,'button') as HTMLButtonElement;
            button.onclick = remove;
            icon = new Icon("");
            addElement(icon);
            return element;
        }
        COMPILE::JS
        public var button:HTMLButtonElement;

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
            if(value != _small){
                toggle(valueToSelector("small"),value);
                toggle(valueToSelector("medium"),!value);
                var type:String = value ? IconType.CROSS_SMALL : IconType.CROSS_MEDIUM;
                icon.selector = Icon.getCSSTypeSelector(type);
                icon.type = type;
                _small = value;
            }
        }
        
        private var _overBackground:Boolean;

        public function get overBackground():Boolean
        {
        	return _overBackground;
        }

        public function set overBackground(value:Boolean):void
        {
            toggle(valueToSelector("overBackground"),value);
        	_overBackground = value;
        }

        private function remove():void{
            this.dispatchEvent(new Event("change"));
        }
    }
}