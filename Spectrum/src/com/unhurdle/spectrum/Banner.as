package com.unhurdle.spectrum
{
    
    COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
    }

    public class Banner extends SpectrumBase
    {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/banner/dist.css">
     * </inject_html>
     * 
     */

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
            headerNode.text = value;
        	_header = value;
        }

        private var _content:String;

        public function get content():String
        {
        	return _content;
        }

        public function set content(value:String):void
        {
            contentNode.text = value;
        	_content = value;
        }

        private var headerNode:TextNode;
        
        private var contentNode:TextNode;

        COMPILE::JS        
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = super.createElement();
            headerNode = new TextNode("div");
            headerNode.className = appendSelector("-header");
            elem.appendChild(headerNode.element);

            contentNode = new TextNode("div");
            headerNode.className = appendSelector("-content");
            elem.appendChild(contentNode.element);

            return elem;
        }
        private var _type:String;

        public function get type():String
        {
            return _type;
        }
        
        [Inspectable(category="General", enumeration="info,error,warning", defaultValue="info")]
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
                toggle(valueToSelector("corner"),value);
            }
            _corner = value;
        }
    }
}