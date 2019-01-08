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
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
        var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
        controlsContainer = newElement("div",appendSelector("-controls"));
        //first track
				leftTrack = newElement("div",appendSelector("-track"));
        controlsContainer.appendChild(leftTrack);
        //first buffer
        leftBuffer = newElement("div",appendSelector("-buffer"));
        leftBuffer.style.width = "20%";
        // leftBuffer.setAttribute("role","progressbar");
        // leftBuffer.setAttribute("aria-valuemin","0");
        // leftBuffer.setAttribute("aria-valuemax","100");
        // leftBuffer.setAttribute("aria-valuenow","50");
        // leftBuffer.setAttribute("aria-labelledby","spectrum-Slider-label-16");// need this?
        controlsContainer.appendChild(leftTrack);
        //handle
        handle = newElement("div",appendSelector("-handle"));
        handle.style.left = "20%";
        input = newElement("input",appendSelector("-input")) as HTMLInputElement;
        input.type = "range";
				input.step = "1";
        // leftBuffer.setAttribute("aria-valuetext","3:48");
        input.onchange = handleChange();
        handle.appendChild(input);
        controlsContainer.appendChild(handle);
        //second buffer
        rightBuffer = newElement("div",appendSelector("-buffer"));
        rightBuffer.style.left = "20%";
        rightBuffer.style.width = "30%";
        controlsContainer.appendChild(rightBuffer);
        //second track
				rightTrack = newElement("div",appendSelector("-track"));
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
    COMPILE::JS
    override protected function onMouseMove(e:MouseEvent):void {
			//TODO find the new range...
      var handle:Object = e.target;//to check
      var sliderOffsetWidth:Number = element.offsetWidth;
			var sliderOffsetLeft:Number = element.offsetLeft + (element.offsetParent as HTMLElement).offsetLeft;

			var x:Number = Math.max(Math.min(e.x-sliderOffsetLeft, sliderOffsetWidth), 0);
			var percent:Number = (x / sliderOffsetWidth) * 100;
			// var val:Number = (max-min) / (100/percent);
			// var stepVal:Number = step;
			// var rem:Number = val % stepVal;
			// val = val - rem;
			// if (rem > (stepVal/2)){
		  //   val += stepVal;
			// }
			// value = val;
  //       if (handle === leftHandle) {
  //             if (percent < parseFloat(rightHandle.style.left)) {
  //               handle.style.left = percent + '%';
  //               leftTrack.style.width = percent + '%';
  //             }
  //           }
  //           else {
  //             if (percent > parseFloat(leftHandle.style.left)) {
  //               handle.style.left = percent + '%';
  //               rightTrack.style.width = (100 - percent) + '%';
  //             }
  //           }
  //           middleTrack.style.left = leftHandle.style.left;
  //           middleTrack.style.right = (100 - parseFloat(rightHandle.style.left)) + '%';
  // // }

  //      var startPercent:Number = parseFloat(leftHandle.style.left);
  //     var endPercent:Number = parseFloat(rightHandle.style.left);
  //     leftTrack.style.width = startPercent + '%';
  //     middleTrack.style.left = startPercent + '%';
  //     middleTrack.style.right = (100 - endPercent) + '%';
  //     rightTrack.style.width = (100 - endPercent) + '%';

  // if (!element.classList.contains('is-disabled')) {
  //   element.addEventListener('mousedown', onMouseDown);
  // }
  //  if (leftTrack && rightTrack) {
  //  if (leftTrack && rightTrack && !isColor) {
      leftTrack.style.width = percent + '%';
      rightTrack.style.width = (100 - percent) + '%';
    // }
    handle.style.left = percent + '%';

    var bufferedAmount:int = parseInt(handle.style.left, 10) + parseInt(rightBuffer.style.width, 10);

    // if (buffers.length) {
      if (percent >= bufferedAmount) {
        // Don't show right buffer bar
        rightBuffer.style.width = 0;
        rightBuffer.style.left = 'auto';
        rightBuffer.style.right = 'auto';
        leftBuffer.style.width = bufferedAmount + '%';
      // }
      // else {
        // leftBuffer.style.width = percent + '%';
        // rightBuffer.style.width = 'auto';
        // rightBuffer.style.left = percent + '%';
        // rightBuffer.style.right = (100 - bufferedAmount) + '%';
      // }
    }
    }
  }
}