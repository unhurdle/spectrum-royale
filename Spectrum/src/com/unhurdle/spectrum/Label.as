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
            typeNames = "spectrum-Label";
        }
        private var _color:String;

        public function get color():String
        {
            return _color;
        }

        public function set color(value:String):void
        {
            if(value != _color){
                var newColor:String = valueToCSS(value);
                toggle(newColor, true);
                if(_color){
                    var oldColor:String = valueToCSS(_color);
                    toggle(oldColor, false);
                }
                _color = value;
            }
        }
        private function valueToCSS(value:String):String{
            return "spectrum-Label--" + value;
        }
        private var _size:String;

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
                        break;
                    default:
                        throw new Error("Invalid scale: " + value);
                }
                var newScale:String = valueToCSS(value);
                toggle(newScale, true);
                if(_size){
                    var oldScale:String = valueToCSS(_size);
                    toggle(oldScale, false);
                }
                _size = value;
            }
        }
        private var _active:Boolean;//active and inactive??? should be 2 vars or 1?

        public function get active():Boolean
        {
        	return _active;
        }

        public function set active(value:Boolean):void
        {
            var newActive:String;
            if(value){
                newActive = "spectrum-Label--active";
            }
            else{
                newActive = "spectrum-Label--inactive";
            }
            toggle(newActive, true);
            if(_active != "undefined"){
                var oldActive:String;
                if(_active){
                    oldActive = "spectrum-Label--active";
                }
                else{
                    oldActive = "spectrum-Label--inactive";
                }
                toggle(oldActive, false);
            }
        	_active = value;
        }
        COMPILE::JS
        private var label:HTMLLabelElement;

        COMPILE::SWF
        private var label:Object;
        
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            addElementToWrapper(this,'label');
            return element;
        }
        public function get text():String
        {
        	return label.text;
        }

        public function set text(value:String):void
        {
        	label.text = value;
        }
    }
}