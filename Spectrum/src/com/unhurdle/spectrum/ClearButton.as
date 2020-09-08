package com.unhurdle.spectrum
{
    COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.html.util.addElementToWrapper;
    }
    import com.unhurdle.spectrum.const.IconType;
    import org.apache.royale.events.Event;

    [Event(name="clear", type="org.apache.royale.events.Event")]
    public class ClearButton extends SpectrumBase
    {
        public function ClearButton()
        {
            super();
        }
        override protected function getSelector():String{
            return "spectrum-ClearButton";
        }

        private var icon:Icon;
        
        override protected function getTag():String{
            return "button";
        }
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            button = super.createElement() as HTMLButtonElement;
            button.type = "reset";
            var type:String = IconType.CROSS_SMALL;
            icon = new Icon(Icon.getCSSTypeSelector(type));
            icon.type = type;
            button.appendChild(icon.element);
            button.onclick = function():void{
                dispatchEvent("clear");
            }
            return element;
        }
        public var button:HTMLButtonElement;
        
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
        private var _small:Boolean = false;

        public function get small():Boolean
        {
        	return _small;
        }

        public function set small(value:Boolean):void
        {
            if(value != _small){
                toggle(valueToSelector("small"),value);
                // it seems like both versions use the small x
                // var type:String = value ? IconType.CROSS_SMALL : IconType.CROSS_MEDIUM;
                // icon.selector = Icon.getCSSTypeSelector(type);
                // icon.type = type;
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

    }
}