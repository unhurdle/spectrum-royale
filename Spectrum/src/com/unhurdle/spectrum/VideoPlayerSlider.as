package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.utils.PointUtils;
  import org.apache.royale.geom.Point;
  import org.apache.royale.events.MouseEvent;
  public class VideoPlayerSlider extends SliderBase
  {
    public function VideoPlayerSlider()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Slider";
    }

    private var handle:HTMLElement;
 		private var leftTrack:HTMLElement;
   	private var rightTrack:HTMLElement;
		private var leftBuffer:HTMLElement;
  	private var rightBuffer:HTMLElement;
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      controlsContainer = newElement("div",appendSelector("-controls"));
      //first track
      leftTrack = newElement("div",appendSelector("-track"));
      controlsContainer.appendChild(leftTrack);
      //first buffer
      leftBuffer = newElement("div",appendSelector("-buffer"));
      // need this?
      // leftBuffer.setAttribute("role","progressbar");
      // leftBuffer.setAttribute("aria-valuemin","0");
      // leftBuffer.setAttribute("aria-valuemax","100");
      // leftBuffer.setAttribute("aria-valuenow","50");
      controlsContainer.appendChild(leftBuffer);
      //handle
      handle = newElement("div",appendSelector("-handle"));
      input = newElement("input",appendSelector("-input")) as HTMLInputElement;
      input.type = "range";
      input.step = "1";
      // leftBuffer.setAttribute("aria-valuetext","3:48");
      max = 100;
      handle.appendChild(input);
      controlsContainer.appendChild(handle);
      //second buffer
      rightBuffer = newElement("div",appendSelector("-buffer"));
      controlsContainer.appendChild(rightBuffer);
      //second track
      rightTrack = newElement("div",appendSelector("-track"));
      controlsContainer.appendChild(rightTrack);

      elem.appendChild(controlsContainer);
      element.addEventListener('mousedown', onMouseDown);
      return elem;
    }
    public function get value():Number
    {
    	return Number(input.value);
    }

    public function set value(value:Number):void
    {
			//TODO why is this a string?
			input.value = "" + value;
			if(parent){
				positionElements();
			}
			if(valueNode){
				valueNode.text = "" + value;
			}
    }
    override protected function getValue():String{
			return input.value;
		}
    override protected function positionElements():void{
        var percent:Number = this.value / (max - min) * 100;
        handle.style.left = percent + "%";
      if (leftTrack && rightTrack) {
        leftTrack.style.width = percent + '%';
        rightTrack.style.width = (100 - percent) + '%';
      }
    }
    COMPILE::JS
    override protected function onMouseMove(e:MouseEvent):void {
      var sliderOffsetWidth:Number = element.offsetWidth;
      var localX:Number = PointUtils.globalToLocal(new Point(e.clientX,e.clientY),this).x;
      var x:Number = Math.max(Math.min(localX, sliderOffsetWidth), 0);
      var percent:Number = (x / sliderOffsetWidth) * 100;
      var val:Number = (max-min) / (100/percent) + min;
      var stepVal:Number = step;
      var rem:Number = val % stepVal;
      val = val - rem;
      if (rem > (stepVal/2)){
        val += stepVal;
      }
      var bufferedAmount:Number = 50; //need to be buffers long...

      if (percent >= bufferedAmount) {
        // Don't show right buffer bar
        rightBuffer.style.width = 0;
        rightBuffer.style.left = bufferedAmount +'%';
        leftBuffer.style.width = bufferedAmount + '%';
      }
      else if (percent < bufferedAmount){
        leftBuffer.style.width = percent + '%';
        rightBuffer.style.width = bufferedAmount -percent +'%';
        rightBuffer.style.left = percent + '%';
        rightBuffer.style.right = (100 - bufferedAmount) + '%';
      }
      value = val;
      handle.style.left = leftBuffer.style.width + '';
    }
  }
}
