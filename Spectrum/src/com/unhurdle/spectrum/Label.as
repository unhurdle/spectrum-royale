package com.unhurdle.spectrum
{
    import org.apache.royale.core.UIBase;

    public class Label extends UIBase
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
                toggle(this,newColor, true);
                if(_color){
                    var oldColor:String = valueToCSS(_color);
                    toggle(this,oldColor, false);
                }
                _color = value;
            }
        }
        private function valueToCSS(stop:String):String{
            return "spectrum-Label--" + stop;
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
                toggle(this,newScale, true);
                if(_size){
                    var oldScale:String = valueToCSS(_size);
                    toggle(this,oldScale, false);
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
            toggle(this,newActive, true);
            if(_active != "undefined"){
                var oldActive:String;
                if(_active){
                    oldActive = "spectrum-Label--active";
                }
                else{
                    oldActive = "spectrum-Label--inactive";
                }
                toggle(this,oldActive, false);
            }
        	_active = value;
        }
    }
}