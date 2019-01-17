package com.unhurdle.spectrum
{
    
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }

    public class CoachMark extends SpectrumBase
    {
        public static const DARK:String = "dark";
        public static const LIGHT:String = "light";
        public function CoachMark()
        {
            super();
        }
        override protected function getSelector():String{
            return "spectrum-CoachMarkIndicator";
        }
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            // add three ring elements
            for(var i:int=0;i<3;i++){
                elem.appendChild(newElement("div",appendSelector("-ring")));
            }
            return elem;
        }


        private var _isAbsolute:Boolean;

        public function get isAbsolute():Boolean
        {
        	return _isAbsolute;
        }

        public function set isAbsolute(value:Boolean):void
        {
        	_isAbsolute = value;
        }
         
        private var _quiet:Boolean;

        public function get quiet():Boolean
        {
            return _quiet;
        }

        public function set quiet(value:Boolean):void
        {
            if(value != !!_quiet){
                toggle(valueToSelector("quiet"),value);
            }
            _quiet = value;
        }

        private var _flavor:String;

        public function get flavor():String
        {
            return _flavor;
        }

        public function set flavor(value:String):void
        {
            if(value != _flavor){
                switch (value){
                case "dark":
                case "light":
                case "":
                    break;
                default:
                    throw new Error("Invalid flavor: " + value);
                }
                if(_flavor){
                    var oldFlavor:String = valueToSelector(_flavor);
                    toggle(oldFlavor, false);
                }
                if(value){
                    var newFlavor:String = valueToSelector(value);
                    toggle(newFlavor, true);
                }
                _flavor = value;
            }
        }
    }
}