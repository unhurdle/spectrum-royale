package com.unhurdle.spectrum
{
    import org.apache.royale.core.UIBase;
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }

    public class Banner extends UIBase
    {
        public function Banner()
        {
            super();
            typeNames = "spectum-Banner";
            _color = "info";
        }
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            var header:WrappedHTMLElement = new WrappedHTMLElement();
            header.className = "spectrum-Banner-header";
            elem.appendChild(header);
            var content:WrappedHTMLElement = new WrappedHTMLElement();
            content.className = "spectrum-Banner-content";
            elem.appendChild(content);
            return elem;
        }
        private var _color:String;

        /**
         * The colorstop of the app. One of the four ColorStop values
         */
        public function get color():String
        {
            return _color;
        }

        public function set color(value:String):void
        {
            if(value != _color){
                switch (value){
                // check that values are valid
                case "info":
                case "error":
                case "warning":
                    break;
                default:
                    throw new Error("Invalid color: " + value);
                }
                var oldStop:String = valueToCSS(_color);
                var newStop:String = valueToCSS(value);
                toggle(this,newStop, true);
                toggle(this,oldStop, false);
                _color = value;
            }
        }
        private function valueToCSS(stop:String):String{
            return "spectrum-Banner--" + stop;
        }
        private var _corner:Boolean;

        public function get corner():Boolean
        {
            return _corner;
        }

        public function set corner(value:Boolean):void
        {
            if(value != !!_corner){
                toggle(this,"spectrum-Banner--corner",value);
            }
            _corner = value;
        }
    }
}