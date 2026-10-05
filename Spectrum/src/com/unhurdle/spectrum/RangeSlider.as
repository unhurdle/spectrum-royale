package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.utils.PointerDrag;
  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.events.Event;
  import org.apache.royale.utils.number.pinValue;
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
    private var pointerDrag:PointerDrag;

    public function get value():Number
    {
      return Number(input.value);
    }

    public function set value(newValue:Number):void
    {
      input.value = "" + pinValue(newValue, min, Math.min(max, secondValue));
      positionElements();
    }

    public function get secondValue():Number
    {
      return Number(secondInput.value);
    }

    public function set secondValue(newValue:Number):void
    {
      secondInput.value = "" + pinValue(newValue, Math.max(secondMin, value), secondMax);
      positionElements();
    }

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
      COMPILE::JS
      {
        pointerDrag.enabled = !value;
      }
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
        input.value = "20";
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
        secondInput.value = "60";
        rightHandle.appendChild(secondInput);
        controlsContainer.appendChild(rightHandle);
        //third track
				rightTrack = newElement("div","spectrum-Slider-track");
        rightTrack.style.width = "40%";
        controlsContainer.appendChild(rightTrack);

        elem.appendChild(controlsContainer);
      input.addEventListener("input", handleNativeInput);
      secondInput.addEventListener("input", handleNativeInput);
      pointerDrag = new PointerDrag(element, handlePointerStart, handlePointerMove, handlePointerEnd, "pan-y");
        return elem;
    }
    override public function addedToParent():void{
			super.addedToParent();
			positionElements();
    }
     override protected function getValue():String{
			return "" + value + " - " + secondValue;
		}    
    override protected function positionElements():void{
      var startPercent:Number = getValuePercent(value, min, max);
      var endPercent:Number = getValuePercent(secondValue, secondMin, secondMax);
      leftHandle.style.left = startPercent + "%";
      rightHandle.style.left = endPercent + "%";
      leftTrack.style.width = startPercent + '%';
      middleTrack.style.left = startPercent + '%';
      middleTrack.style.right = (100 - endPercent) + '%';
      rightTrack.style.width = (100 - endPercent) + '%';
			if(valueNode){
				valueNode.text = getValue();
			}
		}

    private function getValuePercent(currentValue:Number, rangeMin:Number, rangeMax:Number):Number{
      if(rangeMax == rangeMin){
        return 0;
      }
      return pinValue((currentValue - rangeMin) / (rangeMax - rangeMin) * 100, 0, 100);
    }

    COMPILE::JS
    private function handlePointerStart(event:PointerEvent):Boolean{
      if(event.target === input || event.target === secondInput){
        return false;
      }
      if(leftHandle.contains(event.target as Node)){
        handle = leftHandle;
      } else if(rightHandle.contains(event.target as Node)){
        handle = rightHandle;
      } else {
        var bounds:ClientRect = element.getBoundingClientRect();
        if(bounds.width == 0){
          return false;
        }
        var percent:Number = (event.clientX - bounds.left) / bounds.width * 100;
        handle = Math.abs(percent - parseFloat(leftHandle.style.left)) <= Math.abs(percent - parseFloat(rightHandle.style.left)) ? leftHandle : rightHandle;
      }
      pointerDragManaged = true;
      onMouseDown(event as MouseEvent);
      return true;
    }

    COMPILE::JS
    private function handlePointerEnd():void{
      onMouseUp();
      pointerDragManaged = false;
    }

    COMPILE::JS
    override protected function onMouseDown(event:MouseEvent):void{
      super.onMouseDown(event);
    }

    override protected function onMouseUp():void{
      super.onMouseUp();
      handle = null;
    }

    COMPILE::JS
    private function handlePointerMove(event:PointerEvent):void{
      onMouseMove(event as MouseEvent);
    }

    COMPILE::JS
    override protected function onMouseMove(event:MouseEvent):void{
      if(disabled || !handle){
        return;
      }
      var bounds:ClientRect = element.getBoundingClientRect();
      if(bounds.width == 0){
        return;
      }
      var x:Number = pinValue(event.clientX - bounds.left, 0, bounds.width);
      var changed:Boolean;
		  if(handle === leftHandle){
        changed = setInputFromPosition(input, x / bounds.width, min, max, secondValue);
      } else {
        changed = setInputFromPosition(secondInput, x / bounds.width, secondMin, secondMax, value);
      }
      if(changed){
        positionElements();
        dispatchEvent(new Event("change"));
      }
    }

    COMPILE::JS
    private function setInputFromPosition(target:HTMLInputElement, ratio:Number, inputMin:Number, inputMax:Number, boundary:Number):Boolean{
      var newValue:Number = inputMin + (inputMax - inputMin) * ratio;
      var inputStep:Number = Number(target.step);
      if(inputStep > 0){
        newValue = inputMin + Math.round((newValue - inputMin) / inputStep) * inputStep;
      }
      newValue = target === input ? pinValue(newValue, inputMin, Math.min(inputMax, boundary)) : pinValue(newValue, Math.max(inputMin, boundary), inputMax);
      if(Number(target.value) == newValue){
        return false;
      }
      target.value = "" + newValue;
      return true;
    }

    COMPILE::JS
    private function handleNativeInput(event:InputEvent):void{
      if(event.target === input && value > secondValue){
        input.value = secondInput.value;
      } else if(event.target === secondInput && secondValue < value){
        secondInput.value = input.value;
      }
      positionElements();
      dispatchEvent(new Event("change"));
    }
  }
}
