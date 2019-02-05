package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

    public class Label extends SpectrumBase
    {
        public function Label()
        {
            super();
        }
        override protected function getSelector():String{
          return "spectrum-Label";
        }

        private var _color:String;

        /**
         * color can be one of:
         * grey
         * red
         * orange
         * yellow
         * seafoam
         * green
         * blue
         * fuchsia
         * 
         * It can also be:
         * active (blue)
         * inactive (grey)
         * 
         */
        public function get color():String
        {
            return _color;
        }

        public function set color(value:String):void
        {
            if(value != _color){
                var newColor:String = valueToSelector(value);
                toggle(newColor, true);
                if(_color){
                    var oldColor:String = valueToSelector(_color);
                    toggle(oldColor, false);
                }
                _color = value;
            }
        }
        private var _size:String;
        
        /**
         * size by default is "normal" or no value
         * It can be set to "large" or "small" as well
         */
        public function get size():String
        {
        	return _size;
        }

        public function set size(value:String):void
        {
            if(value != _size){
                switch(value){
                    case "small":
                    case "large":
                    case "normal":
                    case "":
                        break;
                    default:
                        throw new Error("Invalid scale: " + value);
                }
                if(_size){
                    toggle(valueToSelector(_size),false);
                }
                // normal has no selector
                if(value == "small" || value == "large"){
                    toggle(valueToSelector(value),true);
                }
                _size = value;
            }
        }

        private var span:TextNode;

        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            addElementToWrapper(this,'span') as HTMLSpanElement;
            span = new TextNode("");
            span.element = element;
            return element;
        }
        public function get text():String
        {
        	return _text;
        }
        private var _text:String;
        public function set text(value:String):void
        {
            _text = value;
            span.text = value;
        }
        
        private var _disabled:Boolean;
        public function get disabled():Boolean
        {
            return _disabled;
        }

        public function set disabled(value:Boolean):void
        {
            toggle("is-disabled",value);
            _disabled = value;
        }
        private var _left:Boolean;
        public function get left():Boolean
        {
            return _left;
        }

        public function set left(value:Boolean):void
        {
            toggle(appendSelector("--left"),value);
            _left = value;
        }
    }
}