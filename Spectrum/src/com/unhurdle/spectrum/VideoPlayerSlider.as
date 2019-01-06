package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  public class VideoPlayerSlider extends SliderBase
  {
    public function VideoPlayerSlider()
    {
      super();
      typeNames = "spectrum-Slider"
    }
    override protected function getSelector():String{
      return "spectrum-Slider";
    }
    COMPILE::JS
    private var handle:HTMLElement;
    COMPILE::SWF
    private var handle:Object;
    
		COMPILE::JS
		private var leftTrack:HTMLElement;
		COMPILE::SWF
		private var leftTrack:Object;
		COMPILE::JS
  	private var rightTrack:HTMLElement;
		COMPILE::SWF
  	private var rightTrack:Object;
    	COMPILE::JS
		private var leftBuffer:HTMLElement;
		COMPILE::SWF
		private var leftBuffer:Object;
		COMPILE::JS
  	private var rightBuffer:HTMLElement;
		COMPILE::SWF
  	private var rightBuffer:Object;
    
    override protected function createElement():WrappedHTMLElement{
        var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
        controlsContainer = newElement("div","spectrum-Slider-controls");
        //first track
				leftTrack = newElement("div","spectrum-Slider-track");
        controlsContainer.appendChild(leftTrack);
        //first buffer
        leftBuffer = newElement("div","spectrum-Slider-buffer");
        leftBuffer.style.width = "20%";
        leftBuffer.setAttribute("role","progressbar");
        leftBuffer.setAttribute("aria-valuemin","0");
        leftBuffer.setAttribute("aria-valuemax","100");
        leftBuffer.setAttribute("aria-valuenow","50");
        leftBuffer.setAttribute("aria-labelledby","spectrum-Slider-label-16");// need this?
        controlsContainer.appendChild(leftTrack);
        //handle
        handle = newElement("div","spectrum-Slider-handle");
        handle.style.left = "20%";
        input = newElement("input","spectrum-Slider-input") as HTMLInputElement;
        input.type = "range";
				input.step = "1";
        leftBuffer.setAttribute("aria-valuetext","3:48");
        input.onchange = handleChange();
        handle.appendChild(input);
        controlsContainer.appendChild(handle);
        //second buffer
        rightBuffer = newElement("div","spectrum-Slider-buffer");
        rightBuffer.style.left = "20%";
        rightBuffer.style.width = "30%";
        controlsContainer.appendChild(rightBuffer);
        //second track
				rightTrack = newElement("div","spectrum-Slider-track");
        controlsContainer.appendChild(rightTrack);

        elem.appendChild(controlsContainer);
    		element.addEventListener('mousedown', onMouseDown);
        return elem;
    }
    private function handleChange():void{
			if(valueNode){
				valueNode.text = "" + value;
			}
    }
    public function get value():Number
    {
    	return Number(input.value);
    }

    public function set value(value:Number):void
    {
			//TODO why is this a string?
			input.value = "" + value;
			// if(parent){
			// 	positionElements();
			// }
			if(valueNode){
				valueNode.text = "" + value;
			}

    }
  }
}