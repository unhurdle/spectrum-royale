package com.unhurdle.spectrum
{
   COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
	[Event(name="change", type="org.apache.royale.events.Event")]

  public class ColorSlider extends SliderBase
  {
    public function ColorSlider()
    {
      super();
      typeNames = getSelector() + " " + valueToSelector("color");
    }
    
    override protected function getSelector():String{
      return "spectrum-Slider";
    }
    private var handle:HTMLElement;
		private var track:HTMLElement;
    COMPILE::JS

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
        var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
        controlsContainer = newElement("div",appendSelector("-controls"));
        track = newElement("div",appendSelector("-track"));
        controlsContainer.appendChild(track);
        handle = newElement("div",appendSelector("-handle"));
        handle.style.left = "40%"
        input = newElement("input",appendSelector("-input")) as HTMLInputElement;
        input.type = "range";
        input.step = "2";
        max = 100;
        input.setAttribute("aria-valuetext","#2680eb");
        handle.appendChild(input);
        controlsContainer.appendChild(handle);
        elem.appendChild(controlsContainer);
        element.addEventListener('mousedown', onMouseDown);
        return elem;
    }
    override protected function onMouseMove(e:MouseEvent):void {
      var elem:HTMLElement = element as HTMLElement;
			var sliderOffsetWidth:Number = elem.offsetWidth;
			var sliderOffsetLeft:Number = elem.offsetLeft + (elem.offsetParent as HTMLElement).offsetLeft;

			var x:Number = Math.max(Math.min(e.x-sliderOffsetLeft, sliderOffsetWidth), 0);
			var percent:Number = (x / sliderOffsetWidth) * 100;
			value = getValue();
      handle.style.left = percent + "%";
    }
    public function get value():String
    {
    	return String(input.value);
    }
     override public function addedToParent():void{
			super.addedToParent();
			positionElements();
    }

    override protected function positionElements():void{
      super.positionElements();
      displayValue = true;
    }
    public function set value(value:String):void
    {
			//TODO why is this a string?
			input.value = value;
			if(parent){
				positionElements();
			}
			if(valueNode){
				valueNode.text = value;
			}
    }
     override protected function getValue():String{
			return input.getAttribute("aria-valuetext");
		}
    private function changeBackgroundColor():void{
      if(!!color){
        if(!!showingAlpha){
          track.style.backgroundImage = "linear-gradient(to right, rgba(38, 128, 235, .5), rgb(9, 90, 186))";
        }
        else{
          track.style.backgroundImage = "linear-gradient(to right, rgb(38, 128, 235), rgb(9, 90, 186))";
        }
      }
      else{
        if(!!showingAlpha){
          track.style.backgroundImage = "linear-gradient(to right, rgba(128,128,128, .5), rgb(255, 255, 255))";
        }
        else{
          track.style.backgroundImage = "linear-gradient(to right, rgb(128,128,128), rgb(255, 255, 255))";
        }
      }
      positionElements();
    }
    private var _color:Boolean = true;
    public function get color():Boolean
    {
        return _color;
    }
    public function set color(val:Boolean):void
    {
        if(val != !!_color){
            toggle(valueToSelector("color"),val);
        }
        _color = val;
        changeBackgroundColor();
    }

    private var _showingAlpha:Boolean;
    public function get showingAlpha():Boolean
    {
        return _showingAlpha;
    }
    public function set showingAlpha(val:Boolean):void
    {
        _showingAlpha = val;
        changeBackgroundColor();
    }
  }
}
