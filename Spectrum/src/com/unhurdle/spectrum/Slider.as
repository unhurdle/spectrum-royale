package com.unhurdle.spectrum
{
 COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
    COMPILE::SWF
  public class Slider extends SpectrumBase{}
  
  COMPILE::JS
  public class Slider extends SpectrumBase
  {
    public function Slider()
    {
      super();
      typeNames = "spectrum-Slider";
    }
    private var input:HTMLInputElement;
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            var labelContainer:HTMLDivElement = newElement("div") as HTMLDivElement;
            labelContainer.className = "spectrum-Slider-labelContainer";
            var label:HTMLLabelElement = newElement("label") as HTMLLabelElement;
            label.className = "spectrum-Slider-label";
            label.id = "my-spectrum-Slider-label1";
            label.setAttribute("for","my-spectrum-Slider-input1");
            labelContainer.appendChild(label);
            var inputValue:HTMLDivElement = newElement("div") as HTMLDivElement;
            inputValue.className = "spectrum-Slider-value";
            inputValue.setAttribute("role","textbox");
            inputValue.setAttribute("aria-readonly",true);
            inputValue.setAttribute("aria-labelledby","my-spectrum-Slider-label1");
            labelContainer.appendChild(inputValue);
            elem.appendChild(labelContainer);
            var controls:HTMLDivElement = newElement("div") as HTMLDivElement;
            controls.className = "spectrum-Slider-controls";
            var track:HTMLDivElement = newElement("div") as HTMLDivElement;
            track.className = "spectrum-Slider-track";
            if(_color){
              if(_showingAlpha){
                track.style.backgroundColor = "linear-gradient(to right, rgba(38, 128, 235), rgb(9, 90, 186))";
              }
              else{
                track.style.backgroundColor = "linear-gradient(to right, rgb(38, 128, 235), rgb(9, 90, 186))";
              }
            }
            else{
              track.style.backgroundColor = "black";
            }
            controls.appendChild(track);
            var handle:HTMLDivElement = newElement("div") as HTMLDivElement;
            handle.className = "spectrum-Slider-handle";
            handle.style.left = "40%"
            input = newElement("input") as HTMLInputElement;
            input.className = "spectrum-Slider-input";
            input.id = "my-spectrum-Slider-input1";
            input.type = "range";
            input.value = "14";
            input.min = "10";
            input.max = "20";
            input.step = "2";
            if(_color){
              input.setAttribute("aria-valuetext","#2680eb");
            }
            handle.appendChild(input);
            controls.appendChild(handle);
            elem.appendChild(controls);
            return elem;
        }
        private var _isDisabled:Boolean;

        public function get isDisabled():Boolean
        {
            return _isDisabled;
        }

        public function set isDisabled(value:Boolean):void
        {
            if(value != !!_isDisabled){
                toggle("is-disabled",value);
                COMPILE::JS
                {
                    input.disabled = value;
                }
            }
        	_isDisabled = value;
        }
        
        private var _color:Boolean;
        public function get color():Boolean
        {
            return _color;
        }
        public function set color(value:Boolean):void
        {
            if(value != !!_color){
                toggle(valueToCSS("color"),value);
            }
            _color = value;
        }
        private var _showingAlpha:Boolean;
        public function get showingAlpha():Boolean
        {
            return _showingAlpha;
        }
        public function set showingAlpha(value:Boolean):void
        {
          _showingAlpha = value;
        }
  
        private function valueToCSS(stop:String):String{
            return "spectrum-Slider--" + stop;
        }
  }
}