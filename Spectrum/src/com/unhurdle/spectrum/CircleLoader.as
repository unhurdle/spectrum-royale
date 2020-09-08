package com.unhurdle.spectrum
{
    
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }

   
    public class CircleLoader extends SpectrumBase
    {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/circleloader/dist.css">
     * </inject_html>
     * 
     */
        public function CircleLoader()
        {
            super();
        }
        override protected function getSelector():String{
            return "spectrum-CircleLoader";
        }
        
        private var elem:Object;
        private var fillSubMask1:HTMLDivElement;
        private var fillSubMask2:HTMLDivElement;
        private var input:HTMLInputElement;

        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = super.createElement();
            var track:HTMLDivElement = newElement("div") as HTMLDivElement;
            track.className = appendSelector("-track");
            elem.appendChild(track);
            var fills:HTMLDivElement = newElement("div") as HTMLDivElement;
            fills.className = appendSelector("-fills");
            var fillMask1:HTMLDivElement = newElement("div") as HTMLDivElement;
            fillMask1.className = appendSelector("-fillMask1");
            fillSubMask1 = newElement("div") as HTMLDivElement;
            fillSubMask1.className = appendSelector("-fillSubMask1");
            var fill1:HTMLDivElement = newElement("div") as HTMLDivElement;
            fill1.className = appendSelector("-fill");
            fillSubMask1.appendChild(fill1);
            fillMask1.appendChild(fillSubMask1);
            fills.appendChild(fillMask1);
            var fillMask2:HTMLDivElement = newElement("div") as HTMLDivElement;
            fillMask2.className = appendSelector("-fillMask2");
            fillSubMask2 = newElement("div") as HTMLDivElement;
            fillSubMask2.className = appendSelector("-fillSubMask2");
            var fill2:HTMLDivElement = newElement("div") as HTMLDivElement;
            fill2.className = appendSelector("-fill");
            fillSubMask2.appendChild(fill2);
            fillMask2.appendChild(fillSubMask2);
            fills.appendChild(fillMask2);
            elem.appendChild(fills);
            return elem;
        }

        private var _max:Number = 100;

        public function get max():Number
        {
        	return _max;
        }

        public function set max(value:Number):void
        {
        	_max = value;
            if(_value){
                calculatePosition();
            }
        }

        private var _min:Number = 0;

        public function get min():Number
        {
        	return _min;
        }

        public function set min(value:Number):void
        {
        	_min = value;
            if(_value){
                calculatePosition();
            }
        }

        private var _value:Number = 0;

        public function get value():Number
        {
        	return _value;
        }

        public function set value(value:Number):void
        {
        	_value = value;
            calculatePosition();
        }
        override public function addedToParent():void{
            super.addedToParent();
            calculatePosition();
        }
        private function calculatePosition():void {
            var angle:Number;
            if(value){
                var total:Number = _max - _min;
                var percent:Number = value / total * 100;
            } else {
                percent = 0;
            }
            if(percent > 0 && percent <= 50) {
                angle = -180 + (percent/50 * 180);
                fillSubMask1.style.transform = 'rotate('+angle+'deg)';
                fillSubMask2.style.transform = 'rotate(-180deg)';
            }
            else if (percent > 50) {
                angle = -180 + (percent-50)/50 * 180;
                fillSubMask1.style.transform = 'rotate(0deg)';
                fillSubMask2.style.transform = 'rotate('+angle+'deg)';
            }
        }
        private var _indeterminate:Boolean;

        public function get indeterminate():Boolean
        {
            return _indeterminate;
        }

        public function set indeterminate(value:Boolean):void
        {
            if(!value){
                calculatePosition();
            }
            if(value != !!_indeterminate){
                toggle(valueToSelector("indeterminate"),value);
            }
            _indeterminate = value;
        }

        private var _size:String;

        public function get size():String
        {
            return _size;
        }

        [Inspectable(category="General", enumeration="small,large,normal", defaultValue="normal")]
        public function set size(value:String):void
        {
            if(value != _size){
                switch (value){
                case "small":
                case "large":
                case "normal":
                    break;
                default:
                    throw new Error("Invalid size: " + value);
                }
                var oldSize:String = valueToSelector(_size);
                if(value != "normal"){
                    var newSize:String = valueToSelector(value);
                    toggle(newSize, true);
                }
                toggle(oldSize, false);
                _size = value;
            }
        }
        private var _overBackground:Boolean;

        public function get overBackground():Boolean
        {
            return overBackground;
        }

        public function set overBackground(value:Boolean):void
        {
            if(value != !!_overBackground){
                toggle(valueToSelector("overBackground"),value);
            }
            _overBackground = value;
        }
    }
}