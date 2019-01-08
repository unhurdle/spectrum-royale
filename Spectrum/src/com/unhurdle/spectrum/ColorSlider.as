package com.unhurdle.spectrum
{
   COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
  public class ColorSlider extends SliderBase
  {
    public function ColorSlider()
    {
      super();
      typeNames = valueToSelector("color");
    }
    
    override protected function getSelector():String{
      return "spectrum-Slider";
    }
    COMPILE::JS
    private var handle:HTMLElement;
    COMPILE::SWF
    private var handle:Object;
    COMPILE::JS
		private var track:HTMLElement;
		COMPILE::SWF
		private var track:Object;
           override protected function createElement():WrappedHTMLElement{
      /* 
        <div class="spectrum-Slider spectrum-Slider--color">
          <div class="spectrum-Slider-labelContainer">
            <label class="spectrum-Slider-label" id="spectrum-Slider--color-label-0" for="spectrum-Slider--color-input-0">Color</label>
            <div class="spectrum-Slider-value" role="textbox" aria-readonly="true" aria-labelledby="spectrum-Slider--color-label-0">#2680eb</div>
          </div>
          <div class="spectrum-Slider-controls">
            <div class="spectrum-Slider-track" style="background: linear-gradient(to right, rgb(38, 128, 235), rgb(9, 90, 186))"></div>
            <div class="spectrum-Slider-handle" style="left: 40%;">
              <input type="range" class="spectrum-Slider-input" value="14" aria-valuetext="#2680eb" step="2" min="10" max="20" id="spectrum-Slider--color-input-0">
            </div>
          </div>
        </div>
      */
        var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
        controlsContainer = newElement("div",appendSelector("-controls"));
        track = newElement("div",appendSelector("-track"));
        track.style.background = "linear-gradient(to right, rgb(38, 128, 235), rgb(9, 90, 186))";
        handle = newElement("div",appendSelector("-handle"));
        handle.style.left = "40%"
        input = newElement("input",appendSelector("-input")) as HTMLInputElement;
        input.type = "range";
        input.step = "2";
        input.setAttribute("aria-valuetext","#2680eb");
        input.onchange = handleChange();
        handle.appendChild(input);
        track.appendChild(handle);
        controlsContainer.appendChild(track);
        elem.appendChild(controlsContainer);
        return elem;
    }
     private function handleChange():void{
      displayValue = true;
			// if(valueNode){
			// 	valueNode.text = "" + value;
			// }
    }
    private var _color:Boolean;
    public function get color():Boolean
    {
        return _color;
    }
    public function set color(value:Boolean):void
    {
        if(value != !!_color){
            toggle(valueToSelector("color"),value);
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
  }
}