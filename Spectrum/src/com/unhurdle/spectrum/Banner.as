package com.unhurdle.spectrum
{
    
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }

    public class Banner extends SpectrumBase
    {
        public function Banner()
        {
            super();
            type = "info";
            _header = "";
            _content = "";
        }
        override protected function getSelector():String{
            return "spectrum-Banner";
        }

        private var _header:String;

        public function get header():String
        {
        	return _header;
        }

        public function set header(value:String):void
        {
            headerNode.nodeValue = value;
        	_header = value;
        }

        private var _content:String;

        public function get content():String
        {
        	return _content;
        }

        public function set content(value:String):void
        {
            contentNode.nodeValue = value;
        	_content = value;
        }

        COMPILE::JS
        private var headerNode:Text;

        COMPILE::SWF
        private var headerNode:Object;
        
        COMPILE::JS
        private var contentNode:Text;

        COMPILE::SWF
        private var contentNode:Object;

        COMPILE::JS        
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            
            var headerElem:HTMLDivElement = newElement("div") as HTMLDivElement;
            headerElem.className = "spectrum-Banner-header";
            headerNode = newTextNode("");
            headerElem.appendChild(headerNode);
            elem.appendChild(headerElem);

            var contentElem:HTMLDivElement = newElement("div") as HTMLDivElement;
            contentElem.className = "spectrum-Banner-content";
            contentNode = newTextNode("");
            contentElem.appendChild(contentNode);
            elem.appendChild(contentElem);

            return elem;
        }
        private var _type:String;

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
                var oldType:String = valueToSelector(_type);
                var newType:String = valueToSelector(value);
                toggle(newType, true);
                toggle(oldType, false);
                _type = value;
            }
        }

        private var _corner:Boolean;

        public function get corner():Boolean
        {
            return _corner;
        }

        public function set corner(value:Boolean):void
        {
            if(value != !!_corner){
                toggle("spectrum-Banner--corner",value);
            }
            _corner = value;
        }
    }
}