package com.unhurdle.spectrum
{
    
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
    COMPILE::SWF
    public class BarLoader extends SpectrumBase{}
    COMPILE::JS
    public class BarLoader extends SpectrumBase
    {
        public function BarLoader()
        {
            super();
            typeNames = "spectum-BarLoader";
        }
        private var _ariaValuMin:int;

        public function get ariaValuMin():int
        {
        	return _ariaValuMin;
        }

        public function set ariaValuMin(value:int):void
        {
        	_ariaValuMin = value;
        }
        private var _ariaValuMax:int;

        public function get ariaValuMax():int
        {
        	return _ariaValuMax;
        }

        public function set ariaValuMax(value:int):void
        {
        	_ariaValuMax = value;
        }
        private var _ariaValuNow:int;

        public function get ariaValuNow():int
        {
        	return _ariaValuNow;
        }

        public function set ariaValuNow(value:int):void
        {
        	_ariaValuNow = value;
        }
        private var _role:String;

        public function get role():String
        {
        	return _role;
        }

        public function set role(value:String):void
        {
        	_role = value;
        }
        private var _value:int;

        public function get value():int
        {
        	return _value;
        }

        public function set value(value:int):void
        {
        	_value = value;
        }
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            var track:HTMLDivElement = newElement("div") as HTMLDivElement();
            track.className = "spectrum-BarLoader-track";
            var fill:HTMLDivElement = newElement("div") as HTMLDivElement();
            fill.className = "spectrum-BarLoader-fill";
            fill.style.width = value;
            track.appendChild(fill);
            elem.appendChild(track);
            var label:HTMLDivElement = newElement("div") as HTMLDivElement();
            label.className = "spectrum-BarLoader-label";
            elem.appendChild(label);
            var percentage:HTMLDivElement = newElement("div") as HTMLDivElement();
            percentage.className = "spectrum-BarLoader-percentage";
            elem.appendChild(percentage);
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
                case "is-positive":
                case "is-warning":
                case "is-critical":
                    break;
                default:
                    throw new Error("Invalid color: " + value);
                }
                var oldStop:String = _color;
                var newStop:String = value;
                toggle(this,newStop, true);
                toggle(this,oldStop, false);
                _color = value;
            }
        }
        private var _sideLabel:Boolean;

        public function get sideLabel():Boolean
        {
            return _sideLabel;
        }

        public function set sideLabel(value:Boolean):void
        {
            if(value != !!_sideLabel){
                toggle(this,valueToCSS("sideLabel"),value);
            }
            _sideLabel = value;
        }
        private var _small:Boolean;

        public function get small():Boolean
        {
            return _small;
        }

        public function set small(value:Boolean):void
        {
            if(value != !!_small){
                toggle(this,valueToCSS("small"),value);
            }
            _small = value;
        }
        private var _overBackground:Boolean;

        public function get overBackground():Boolean
        {
            return overBackground;
        }

        public function set overBackground(value:Boolean):void
        {
            if(value != !!_overBackground){
                toggle(this,valueToCSS("overBackground"),value);
            }
            _overBackground = value;
        }
        private function valueToCSS(stop:String):String{
            return "spectrum-BarLoader--" + stop;
        }
    }
}