package com.unhurdle.spectrum
{
     COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
  public class RangeSlider extends SliderBase
  {
    public function RangeSlider()
    {
      super();
      typeNames =valueToSelector("range");
    }
    override protected function getSelector():String{
      return "spectrum-Slider";
    }
    COMPILE::JS
    private var leftHandle:HTMLElement;
    COMPILE::SWF
    private var leftHandle:Object;
    COMPILE::JS
    private var rightHandle:HTMLElement;
    COMPILE::SWF
    private var rightHandle:Object;
		COMPILE::JS
		private var leftTrack:HTMLElement;
		COMPILE::SWF
		private var leftTrack:Object;
		COMPILE::JS
  	private var rightTrack:HTMLElement;
		COMPILE::SWF
  	private var rightTrack:Object;
    COMPILE::JS
  	private var middleTrack:HTMLElement;
		COMPILE::SWF
  	private var middleTrack:Object;
 COMPILE::JS
  	private var secondInput:HTMLInputElement;
		COMPILE::SWF
  	private var secondInput:Object;
    public function get secondStep():Number
    {
    	return Number(secondInput.step);
    }

    public function set secondStep(value:Number):void
    {
			//TODO why is this a string?
			secondInput.step = "" + value;
    }
    
    public function get secondMin():Number
    {
    	return Number(secondInput.min);
    }

    public function set secondMin(value:Number):void
    {
        //TODO why is this a string?
        secondInput.min = "" + value;
    }
    
    public function get secondMax():Number
    {
    	return Number(secondInput.max);
    }

    public function set secondMax(value:Number):void
    {
        //TODO why is this a string?
        secondInput.max = "" + value;
    }
    override protected function createElement():WrappedHTMLElement{
        var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
        elem.setAttribute("role","group");
        elem.setAttribute("aria-labelledby","spectrum-Slider-label-4");  // need this?
        controlsContainer = newElement("div","spectrum-Slider-controls");
        controlsContainer.setAttribute("role","presentation");
        //first track
				leftTrack = newElement("div","spectrum-Slider-track");
        leftTrack.style.width = "20%";
        controlsContainer.appendChild(leftTrack);        
        //first handle
        leftHandle = newElement("div","spectrum-Slider-handle");
        leftHandle.setAttribute("role","presentation");
        leftHandle.style.left = "20%";
        input = newElement("input","spectrum-Slider-input") as HTMLInputElement;
        input.type = "range";
				input.step = "2";
        input.onchange = handleChange();
        leftHandle.appendChild(input);
        controlsContainer.appendChild(leftHandle);
        //second track
				middleTrack = newElement("div","spectrum-Slider-track");
        middleTrack.style.left = "20%";
        middleTrack.style.right = "40%";
        controlsContainer.appendChild(middleTrack);
        //second handle
        rightHandle = newElement("div","spectrum-Slider-handle");
        rightHandle.setAttribute("role","presentation");
        rightHandle.style.left = "60%";
        secondInput = newElement("input","spectrum-Slider-input") as HTMLInputElement;
        secondInput.type = "range";
				secondInput.step = "2";
        secondInput.onchange = handleChange();
        rightHandle.appendChild(secondInput);
        controlsContainer.appendChild(rightHandle);
        //third track
				rightTrack = newElement("div","spectrum-Slider-track");
        rightTrack.style.width = "40%";
        controlsContainer.appendChild(rightTrack);

        elem.appendChild(controlsContainer);
    		element.addEventListener('mousedown', onMouseDown);
            return elem;
    }
    override public function addedToParent():void{
			super.addedToParent();
			positionElements();
    }

    override protected function positionElements():void{
COMPILE::JS
			{
				// var percent:Number = this.value / (max - min) * 100;
				// handle.style.left = percent + "%";
			}
		}
    private function handleChange():void{
      displayValue = true;
			// if(valueNode){
			// 	valueNode.text = "" + value;
			// }
    }
    public function get rightValue():Number
    {
    	return Number(input.value);
    }

    public function set rightValue(value:Number):void
    {
			//TODO why is this a string?
			input.value = "" + value;
			// if(parent){
			// 	positionElements();
			// }
			// if(valueNode){
			// 	valueNode.text = "" + value;
			// }
    }
    public function get leftValue():Number
    {
    	return Number(secondInput.value);
    }

    public function set leftValue(value:Number):void
    {
			//TODO why is this a string?
			secondInput.value = "" + value;
			// if(parent){
			// 	positionElements();
			// }
			// if(valueNode){
			// 	valueNode.text = "" + value;
			// }
    }
    // public function get value():String
    // {
    //   if(valueNode){
		// 		return valueNode.text;
		// 	}
    // 	return "";
    // }

    // public function set value(value:String):void
    // {
		// 	//TODO why is this a string?
		// 	input.value = "" + value;
		// 	if(parent){
		// 		positionElements();
		// 	}
		// 	if(valueNode){
		// 		valueNode.text = "" + value;
		// 	}
    // }
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
        if (handle === leftHandle) {
              if (percent < parseFloat(rightHandle.style.left)) {
                handle.style.left = percent + '%';
                leftTrack.style.width = percent + '%';
              }
            }
            else {
              if (percent > parseFloat(leftHandle.style.left)) {
                handle.style.left = percent + '%';
                rightTrack.style.width = (100 - percent) + '%';
              }
            }
            middleTrack.style.left = leftHandle.style.left;
            middleTrack.style.right = (100 - parseFloat(rightHandle.style.left)) + '%';
  // }

       var startPercent:Number = parseFloat(leftHandle.style.left);
      var endPercent:Number = parseFloat(rightHandle.style.left);
      leftTrack.style.width = startPercent + '%';
      middleTrack.style.left = startPercent + '%';
      middleTrack.style.right = (100 - endPercent) + '%';
      rightTrack.style.width = (100 - endPercent) + '%';

  // if (!element.classList.contains('is-disabled')) {
  //   element.addEventListener('mousedown', onMouseDown);
  // }
  //  if (leftTrack && rightTrack && !isColor) {
//       leftTrack.style.width = percent + '%';
//       rightTrack.style.width = (100 - percent) + '%';
//     }
//     handle.style.left = percent + '%';

//     if (buffers.length) {
//       if (percent >= bufferedAmount) {
//         // Don't show right buffer bar
//         rightBuffer.style.width = 0;
//         rightBuffer.style.left = 'auto';
//         rightBuffer.style.right = 'auto';
//         leftBuffer.style.width = bufferedAmount + '%';
//       }
//       else {
//         leftBuffer.style.width = percent + '%';
//         rightBuffer.style.width = 'auto';
//         rightBuffer.style.left = percent + '%';
//         rightBuffer.style.right = (100 - bufferedAmount) + '%';
//       }
//     }
    }
                                                                                                                            //     function onMouseMove(e, sliderHandle) {
                                                                                                                            //     if (!handle) {
                                                                                                                            //       return;
                                                                                                                            //     }

                                                                                                                            //     var sliderOffsetWidth = slider.offsetWidth;
                                                                                                                            //     var sliderOffsetLeft = slider.offsetLeft + slider.offsetParent.offsetLeft;

                                                                                                                            //     var x = Math.max(Math.min(e.x-sliderOffsetLeft, sliderOffsetWidth), 0);
                                                                                                                            //     var percent = (x / sliderOffsetWidth) * 100;

//     if (handle === leftHandle) {
//       if (percent < parseFloat(rightHandle.style.left)) {
//         handle.style.left = percent + '%';
//         leftTrack.style.width = percent + '%';
//       }
//     }
//     else {
//       if (percent > parseFloat(leftHandle.style.left)) {
//         handle.style.left = percent + '%';
//         rightTrack.style.width = (100 - percent) + '%';
//       }
//     }
//     middleTrack.style.left = leftHandle.style.left;
//     middleTrack.style.right = (100 - parseFloat(rightHandle.style.left)) + '%';
//   }

//   // Set initial track position
//   var startPercent = parseFloat(leftHandle.style.left);
//   var endPercent = parseFloat(rightHandle.style.left);
//   leftTrack.style.width = startPercent + '%';
//   middleTrack.style.left = startPercent + '%';
//   middleTrack.style.right = (100 - endPercent) + '%';
//   rightTrack.style.width = (100 - endPercent) + '%';

//   if (!slider.classList.contains('is-disabled')) {
//     slider.addEventListener('mousedown', onMouseDown);
//   }
// }
//  var sliderOffsetWidth = slider.offsetWidth;
//     var sliderOffsetLeft = slider.offsetLeft + slider.offsetParent.offsetLeft;

//     var x = Math.max(Math.min(e.x-sliderOffsetLeft, sliderOffsetWidth), 0);
//     var percent = (x / sliderOffsetWidth) * 100;
//     if (leftTrack && rightTrack && !isColor) {
//       leftTrack.style.width = percent + '%';
//       rightTrack.style.width = (100 - percent) + '%';
//     }
//     handle.style.left = percent + '%';

//     if (buffers.length) {
//       if (percent >= bufferedAmount) {
//         // Don't show right buffer bar
//         rightBuffer.style.width = 0;
//         rightBuffer.style.left = 'auto';
//         rightBuffer.style.right = 'auto';
//         leftBuffer.style.width = bufferedAmount + '%';
//       }
//       else {
//         leftBuffer.style.width = percent + '%';
//         rightBuffer.style.width = 'auto';
//         rightBuffer.style.left = percent + '%';
//         rightBuffer.style.right = (100 - bufferedAmount) + '%';
//       }
//     }
  }
}