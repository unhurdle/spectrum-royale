package com.unhurdle.spectrum
{
    
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }

    COMPILE::SWF
    public class Banner extends SpectrumBase{}

    COMPILE::JS    
    public class Banner extends SpectrumBase
    {
        public function Banner()
        {
            super();
            typeNames = "spectum-Banner";
            _type = "info";
        }
        
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            var header:HTMLDivElement = newElement("div") as HTMLDivElement();
            header.className = "spectrum-Banner-header";
            elem.appendChild(header);
            var content:HTMLDivElement = newElement("div") as HTMLDivElement();
            content.className = "spectrum-Banner-content";
            elem.appendChild(content);
            return elem;
        }
        private var _type:String;

        /**
         * The colorstop of the app. One of the four ColorStop values
         */
        public function get type():String
        {
            return _type;
        }

        public function set type(value:String):void
        {
            if(value != _type){
                switch (value){
                // check that values are valid
                case "info":
                case "error":
                case "warning":
                    break;
                default:
                    throw new Error("Invalid type: " + value);
                }
                var oldType:String = valueToCSS(_type);
                var newType:String = valueToCSS(value);
                toggle(this,newType, true);
                toggle(this,oldType, false);
                _type = value;
            }
        }
        private function valueToCSS(type:String):String{
            return "spectrum-Banner--" + type;
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