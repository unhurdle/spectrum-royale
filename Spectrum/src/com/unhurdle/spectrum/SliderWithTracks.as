package com.unhurdle.spectrum
{
 COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
  
  
  public class SliderWithTracks extends Slider
  {
    public function SliderWithTracks()
    {
      super();
    }
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            if(_range){
                labelContainer.setAttribute("role","group");
                inputValue.setAttribute("aria-labelledby","my-spectrum-Slider-label2");
            }
            var labelContainer:HTMLDivElement = newElement("div") as HTMLDivElement;
            labelContainer.className = "spectrum-Slider-labelContainer";
            if(_range){
                labelContainer.setAttribute("role","presentation");
            }
            var label:HTMLLabelElement = newElement("label") as HTMLLabelElement;
            label.className = "spectrum-Slider-label";
            label.id = "my-spectrum-Slider-label2";
            label.setAttribute("for","my-spectrum-Slider-input2-1");
            labelContainer.appendChild(label);
            var inputValue:HTMLDivElement = newElement("div") as HTMLDivElement;
            inputValue.className = "spectrum-Slider-value";
            if(!!_player){
                inputValue.setAttribute("role","textbox");
                inputValue.setAttribute("aria-readonly",true);
                inputValue.setAttribute("aria-labelledby","my-spectrum-Slider-label2");
            }
            labelContainer.appendChild(inputValue);
            elem.appendChild(labelContainer);
            var controls:HTMLDivElement = newElement("div") as HTMLDivElement;
            controls.className = "spectrum-Slider-controls";
            var firstTrack:HTMLDivElement = newElement("div") as HTMLDivElement;
            if(_range){
                controls.setAttribute("role","presentation");
                firstTrack.style.width = "20%";
            }
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
            else if(_player){
                var firstBuffer:HTMLDivElement = newElement("div") as HTMLDivElement;
                firstBuffer.className = "spectrum-Slider-buffer";
                firstBuffer.style.width = "20%";
                firstBuffer.setAttribute("role","progressbar");
                firstBuffer.setAttribute("aria-valuemin","0");
                firstBuffer.setAttribute("aria-valuemax","100");
                firstBuffer.setAttribute("aria-valuenow","50");
                firstBuffer.setAttribute("aria-labelledby","my-spectrum-Slider-label2");
                controls.appendChild(firstBuffer);
            }
            var handle:HTMLDivElement = newElement("div") as HTMLDivElement;
            handle.className = "spectrum-Slider-handle";
            if(_range){
                handle.style.left = "20%";                
                handle.setAttribute("role","presentation");
            }
            else{
                handle.style.left = "40%";
            }
            var input:HTMLInputElement = newElement("input") as HTMLInputElement;
            input.className = "spectrum-Slider-input";
            input.id = "my-spectrum-Slider-input2-1";
            input.type = "range";
             if(_player){
                input.value = "228";
                input.min = "0";
                input.max = "760";
                input.setAttribute("aria-valuetext","3:48");
            }
            else{
                input.value = "14";
                input.min = "10";
                input.max = "20";
                input.step = "2";
                if(_range){
                    input.setAttribute("aria-label","max");
                    input.setAttribute("aria-labelledby","my-spectrum-Slider-label2 my-spectrum-Slider-input2-1");
                }
            }
            handle.appendChild(input);
            controls.appendChild(handle);
             if(_player){
                var secondBuffer:HTMLDivElement = newElement("div") as HTMLDivElement;
                secondBuffer.className = "spectrum-Slider-buffer";
                secondBuffer.style.left = "20%";
                secondBuffer.style.width = "30%";
                controls.appendChild(secondBuffer);
            }
            if(_range){
                var middleTrack:HTMLDivElement = newElement("div") as HTMLDivElement;
                controls.setAttribute("role","presentation");
                middleTrack.style.width = "20%";
                middleTrack.style.right = "40%";
                middleTrack.className = "spectrum-Slider-track";
                controls.appendChild(middleTrack);
                var secondHandle:HTMLDivElement = newElement("div") as HTMLDivElement;
                secondHandle.className = "spectrum-Slider-handle";
                secondHandle.style.left = "20%";                
                secondHandle.setAttribute("role","presentation");
                var secondInput:HTMLInputElement = newElement("input") as HTMLInputElement;
                secondInput.className = "spectrum-Slider-input";
                secondInput.id = "my-spectrum-Slider-input2-2";
                secondInput.type = "range";
                secondInput.value = "14";
                secondInput.min = "10";
                secondInput.max = "20";
                secondInput.step = "2";
                secondInput.setAttribute("aria-label","max");
                secondInput.setAttribute("aria-labelledby","my-spectrum-Slider-label2 my-spectrum-Slider-input2-2");
                secondHandle.appendChild(input);
                controls.appendChild(secondHandle);
            }            
            var lastTrack:HTMLDivElement = newElement("div") as HTMLDivElement;
            lastTrack.className = "spectrum-Slider-track";
            if(_range){
                lastTrack.style.width = "40%";
            }
            controls.appendChild(lastTrack);
            elem.appendChild(controls);
            return elem;
        }
        private var _range:Boolean;
        public function get range():Boolean
        {
            return _range;
        }
        public function set range(value:Boolean):void
        {
            if(value != !!_range){
                toggle(valueToSelector("range"),value);
            }
            _range = value;
        }
        private var _player:Boolean;
        public function get player():Boolean
        {
            return _player;
        }
        public function set player(value:Boolean):void
        {
            _player = value;
        }
        
        private var _tick:Boolean;
        public function get tick():Boolean
        {
            return _tick;
        }
        public function set tick(value:Boolean):void
        {
            if(value != !!_tick){
                toggle(valueToSelector("tick"),value);
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