package com.unhurdle.spectrum
{
     COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.events.MouseEvent;
        import org.apache.royale.utils.PointUtils;
        import org.apache.royale.geom.Point;
    }
  public class RangeSlider extends SliderBase
  {
    public function RangeSlider()
    {
      super();
      typeNames = getSelector() + " "+ valueToSelector("range");
    }
    override protected function getSelector():String{
      return "spectrum-Slider";
    }
    private var leftHandle:HTMLElement;
    private var rightHandle:HTMLElement;
		private var leftTrack:HTMLElement;
  	private var rightTrack:HTMLElement;
  	private var middleTrack:HTMLElement;
  	private var secondInput:HTMLInputElement;
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
    
		override protected function enableDisableInput(value:Boolean):void{
			input.disabled = value;
      secondInput.disabled = value;
		}

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
        var elem:WrappedHTMLElement = super.createElement();
        elem.setAttribute("role","group");  // need this?
        controlsContainer = newElement("div",appendSelector("-controls"));
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
        max = 100;
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
        secondMax = 100;
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
     override protected function getValue():String{
			// override in subclass
      var startPercent:Number = parseFloat(leftHandle.style.left);
      var endPercent:Number = parseFloat(rightHandle.style.left);
			return "" + startPercent + " - " + endPercent;
		}    
    override protected function positionElements():void{
      displayValue = true;
				// var leftPercent:Number = this.leftValue / (max - min) * 100;
				// leftHandle.style.left = leftPercent + "%";
        
				// var rightPercent:Number = this.rightValue / (secondMax - secondMin) * 100;
				// rightHandle.style.left = rightPercent + "%";
      var startPercent:Number = parseFloat(leftHandle.style.left);
      var endPercent:Number = parseFloat(rightHandle.style.left);
      leftTrack.style.width = startPercent + '%';
      middleTrack.style.left = startPercent + '%';
      middleTrack.style.right = (100 - endPercent) + '%';
      rightTrack.style.width = (100 - endPercent) + '%';
		}
    private var handle:Object;

    COMPILE::JS
    override protected function onMouseDown(e:MouseEvent):void{
      super.onMouseDown(e);
      handle = e.target;
    }
    
    override protected function onMouseUp():void{
      super.onMouseUp();
      handle = null;
    }

    COMPILE::JS
    override protected function onMouseMove(e:MouseEvent):void{
      if(disabled){
          return;
      }
      var sliderOffsetWidth:Number = element.offsetWidth;
      
      var localX:Number = PointUtils.globalToLocal(new Point(e.clientX,e.clientY),this).x;
			var x:Number = Math.max(Math.min(localX, sliderOffsetWidth), 0);

			var percent:Number = (x / sliderOffsetWidth) * 100;
		  if (handle === leftHandle) {
          if (percent < parseFloat(rightHandle.style.left)) {
            handle.style.left = percent + '%';
            leftTrack.style.width = percent + '%';
          }
        }
        else if (handle === rightHandle){
          if (percent > parseFloat(leftHandle.style.left)) {
            handle.style.left = percent + '%';
            rightTrack.style.width = (100 - percent) + '%';
          }
        }
        middleTrack.style.left = leftHandle.style.left;
        middleTrack.style.right = (100 - parseFloat(rightHandle.style.left)) + '%';
        input.value = middleTrack.style.left;
        secondInput.value = middleTrack.style.right;
        if(parent){
          positionElements();
        }
        if(valueNode){
          valueNode.text = getValue();
        }
    }
  }
}
