package com.unhurdle.spectrum
{
    import org.apache.royale.core.UIBase;

    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
    COMPILE::SWF
    public class CircleLoader extends UIBase{}
    COMPILE::JS
    public class CircleLoader extends UIBase
    {
        public function CircleLoader()
        {
            super();
            typeNames = "spectrum-CircleLoader"
        }
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            var track:HTMLDivElement = newElement("div") as HTMLDivElement();
            track.className = "spectrum-CircleLoader-track";
            elem.appendChild(track);
            var fills:HTMLDivElement = newElement("div") as HTMLDivElement();
            fills.className = "spectrum-CircleLoader-fills";
            var fillMask1:HTMLDivElement = newElement("div") as HTMLDivElement();
            fillMask1.className = "spectrum-CircleLoader-fillMask1";
            var fillSubMask1:HTMLDivElement = newElement("div") as HTMLDivElement();
            fillSubMask1.className = "spectrum-CircleLoader-fillSubMask1";
            var fill1:HTMLDivElement = newElement("div") as HTMLDivElement();
            fill1.className = "spectrum-CircleLoader-fill";
            fillSubMask1.appendChild(fill1);
            fillMask1.appendChild(fillSubMask1);
            fills.appendChild(fillMask1);
            var fillMask2:HTMLDivElement = newElement("div") as HTMLDivElement();
            fillMask2.className = "spectrum-CircleLoader-fillMask2";
            var fillSubMask2:HTMLDivElement = newElement("div") as HTMLDivElement();
            fillSubMask2.className = "spectrum-CircleLoader-fillSubMask2";
            var fill2:HTMLDivElement = newElement("div") as HTMLDivElement();
            fill2.className = "spectrum-CircleLoader-fill";
            fillSubMask2.appendChild(fill2);
            fillMask2.appendChild(fillSubMask2);
            fills.appendChild(fillMask2);
            elem.appendChild(fills);
            if(!!_indeterminate){
                var input:HTMLInputElement = newElement("input") as HTMLInputElement();
                input.type = "number";
                input.min = "0";
                input.max = "100";
                input.setAttribute("display","block");
                input.onchange = "changeLoader(this.previousElementSibling.firstElementChild, this.value)";
                elem.appendChild(input);
            }
            return elem;
        }
        private var _indeterminate:Boolean;

        public function get indeterminate():Boolean
        {
            return _indeterminate;
        }

        public function set indeterminate(value:Boolean):void
        {
            if(value != !!_indeterminate){
                toggle(this,valueToCSS("indeterminate"),value);
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
                var oldSize:String = valueToCSS(_size);
                var newSize:String = valueToCSS(value);
                toggle(this,newSize, true);
                toggle(this,oldSize, false);
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
                toggle(this,valueToCSS("overBackground"),value);
            }
            _overBackground = value;
        }
        private function valueToCSS(stop:String):String{
            return "spectrum-CircleLoader--" + stop;
        }
    }
}