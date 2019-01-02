package com.unhurdle.spectrum
{
 COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
  
  COMPILE::JS
  public class SliderWithTracks extends Slider
  {
    public function SliderWithTracks()
    {
      super();
    }
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            var labelContainer:HTMLDivElement = newElement("div") as HTMLDivElement;
            labelContainer.className = "spectrum-Slider-labelContainer";
            if(_range){
                labelContainer.setAttribute("role","presentation");
            }
            var label:HTMLLabelElement = newElement("label") as HTMLLabelElement;
            label.className = "spectrum-Slider-label";
            label.id = "my-pectrum-Slider-label";
            label.setAttribute("for","my-pectrum-Slider-input");
            labelContainer.appendChild(label);
            var inputValue:HTMLDivElement = newElement("div") as HTMLDivElement;
            inputValue.className = "spectrum-Slider-value";
            inputValue.setAttribute("role","textbox");
            inputValue.setAttribute("aria-readonly",true);
            inputValue.setAttribute("aria-labelledby","my-pectrum-Slider-label");
            labelContainer.appendChild(inputValue);
            elem.appendChild(labelContainer);
            var controls:HTMLDivElement = newElement("div") as HTMLDivElement;
            controls.className = "spectrum-Slider-controls";
            if(_range){
                controls.setAttribute("role","presentation");
            }
            var firstTrack:HTMLDivElement = newElement("div") as HTMLDivElement;
            firstTrack.className = "spectrum-Slider-track";
            controls.appendChild(firstTrack);
            if(_tick){
                var ticks:HTMLDivElement = newElement("div") as HTMLDivElement;
                ticks.className = "spectrum-Slider-ticks";
                var tick1:HTMLDivElement = newElement("div") as HTMLDivElement;
                tick1.className = "spectrum-Slider-tick";
                if(_tickLabel){
                    var tickLabel1:HTMLDivElement = newElement("div") as HTMLDivElement;
                    tickLabel1.className = "spectrum-Slider-tickLabel";
                    tickLabel1.text = "0";
                    tick1.appendChild(tickLabel1);
                }
                ticks.appendChild(tick1);
                var tick2:HTMLDivElement = newElement("div") as HTMLDivElement;
                tick2.className = "spectrum-Slider-tick";
                if(_tickLabel){
                    var tickLabel2:HTMLDivElement = newElement("div") as HTMLDivElement;
                    tickLabel2.className = "spectrum-Slider-tickLabel";
                    tickLabel2.text = "20";
                    tick2.appendChild(tickLabel2);
                }
                ticks.appendChild(tick2);
                var tick3:HTMLDivElement = newElement("div") as HTMLDivElement;
                tick3.className = "spectrum-Slider-tick";
                if(_tickLabel){
                    var tickLabel3:HTMLDivElement = newElement("div") as HTMLDivElement;
                    tickLabel3.className = "spectrum-Slider-tickLabel";
                    tickLabel3.text = "40";
                    tick3.appendChild(tickLabel3);
                }
                ticks.appendChild(tick3);
                var tick4:HTMLDivElement = newElement("div") as HTMLDivElement;
                tick4.className = "spectrum-Slider-tick";
                if(_tickLabel){
                    var tickLabel4:HTMLDivElement = newElement("div") as HTMLDivElement;
                    tickLabel4.className = "spectrum-Slider-tickLabel";
                    tickLabel4.text = "60";
                    tick4.appendChild(tickLabel4);
                }
                ticks.appendChild(tick4);
                var tick5:HTMLDivElement = newElement("div") as HTMLDivElement;
                tick5.className = "spectrum-Slider-tick";
                if(_tickLabel){
                    var tickLabel5:HTMLDivElement = newElement("div") as HTMLDivElement;
                    tickLabel5.className = "spectrum-Slider-tickLabel";
                    tickLabel5.text = "80";
                    tick5.appendChild(tickLabel5);
                }
                ticks.appendChild(tick5);
                var tick6:HTMLDivElement = newElement("div") as HTMLDivElement;
                tick6.className = "spectrum-Slider-tick";
                if(_tickLabel){
                    var tickLabel6:HTMLDivElement = newElement("div") as HTMLDivElement;
                    tickLabel6.className = "spectrum-Slider-tickLabel";
                    tickLabel6.text = "100";
                    tick6.appendChild(tickLabel6);
                }
                ticks.appendChild(tick6);
            }
            var handle:HTMLDivElement = newElement("div") as HTMLDivElement;
            handle.className = "spectrum-Slider-handle";
            handle.style.left = "40%"
            var input:HTMLInputElement = newElement("input") as HTMLInputElement;
            input.className = "spectrum-Slider-input";
            input.id = "my-spectrum-Slider-input";
            input.type = "range";
            input.value = "14";
            input.min = "10";
            input.max = "20";
            input.step = "2";
            handle.appendChild(input);
            controls.appendChild(handle);
            var secondTrack:HTMLDivElement = newElement("div") as HTMLDivElement;
            secondTrack.className = "spectrum-Slider-track";
            controls.appendChild(secondTrack);
            elem.appendChild(controls);
            return elem;
            //range in middle
            //buffer in middle
        }
        private var _range:Boolean;
        public function get range():Boolean
        {
            return _range;
        }
        public function set range(value:Boolean):void
        {
            if(value != !!_range){
                toggle(super.valueToCSS("range"),value);
            }
            _range = value;
        }
        //  private var _buffer:Boolean;
        // public function get buffer():Boolean
        // {
        //     return _buffer;
        // }
        // public function set buffer(value:Boolean):void
        // {
        //     if(value != !!_buffer){
        //         toggle("spectrum-Slider-buffer",value);
        //     }
        //     _buffer = value;
        // }
        
        private var _filled:Boolean;
        public function get filled():Boolean
        {
            return _filled;
        }
        public function set filled(value:Boolean):void
        {
            if(value != !!_filled){
                toggle(super.valueToCSS("filled"),value);
            }
            _filled = value;
        }
        private var _tick:Boolean;
        public function get tick():Boolean
        {
            return _tick;
        }
        public function set tick(value:Boolean):void
        {
            if(value != !!_tick){
                toggle(super.valueToCSS("tick"),value);
            }
            _tick = value;
        }
        private var _tickLabel:Boolean;
        public function get tickLabel():Boolean
        {
            return _tickLabel;
        }
        public function set tickLabel(value:Boolean):void
        {
            _tickLabel = value;
        }
  }
}