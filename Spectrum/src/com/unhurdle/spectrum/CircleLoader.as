package com.unhurdle.spectrum
{
    
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }

   
    public class CircleLoader extends SpectrumBase
    {
        public function CircleLoader()
        {
            super();
        }
        override protected function getSelector():String{
            return "spectrum-CircleLoader";
        }
        

        COMPILE::JS
        private var elem:WrappedHTMLElement;
        COMPILE::SWF
        private var elem:Object;
        COMPILE::JS
        private var fillSubMask1:HTMLDivElement;
        COMPILE::SWF
        private var fillSubMask1:Object;
        COMPILE::JS
        private var fillSubMask2:HTMLDivElement;
        COMPILE::SWF
        private var fillSubMask2:Object;
        COMPILE::JS
        private var input:HTMLInputElement;
        COMPILE::SWF
        private var input:Object;

        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            elem = addElementToWrapper(this,'div');
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
         COMPILE::JS
        override public function addedToParent():void{
			super.addedToParent();
            if(!_indeterminate){
                input = newElement("input") as HTMLInputElement;
                input.type = "number";
                input.min = "0";
                input.max = "100";
                input.setAttribute("display","block");
                input.addEventListener("change",changeLoader);
                elem.appendChild(input);
            }
        }
        private function changeLoader():void {
            var angle:Number;
            var value:Number = Number(input.value);
            if(value > 0 && value <= 50) {
                angle = -180 + (value/50 * 180);
                fillSubMask1.style.transform = 'rotate('+angle+'deg)';
                fillSubMask2.style.transform = 'rotate(-180deg)';
            }
            else if (value > 50) {
                angle = -180 + (value-50)/50 * 180;
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
                addedToParent();
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

        public function set size(value:String):void
        {
            if(value != _size){
                switch (value){
                case "small":
                case "large":
                    break;
                default:
                    throw new Error("Invalid size: " + value);
                }
                var oldSize:String = valueToSelector(_size);
                var newSize:String = valueToSelector(value);
                toggle(newSize, true);
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