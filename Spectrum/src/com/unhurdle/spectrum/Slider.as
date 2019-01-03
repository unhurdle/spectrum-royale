package com.unhurdle.spectrum
{
	COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
	[Event(name="change", type="org.apache.royale.events.Event")]

  public class Slider extends SpectrumBase
  {
    public function Slider()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Slider";
    }
    override public function addedToParent():void{
			super.addedToParent();
			positionElements();
    }

		private function positionElements():void{
			COMPILE::JS
			{
				var percent:Number = this.value / (max - min) * 100;
				handle.style.left = percent + "%";
				// Set initial track position
				leftTrack.style.width = percent + '%';
				rightTrack.style.width = (100 - percent) + '%';
			}
		}
    private function handleChange():void{
			// if(valueNode){
			// 	valueNode.text = "" + value;
			// }
    }

    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
			return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
			if(value != !!_disabled){
				toggle("is-disabled",value);
				input.disabled = value;
				COMPILE::JS
				{
					if(value){
						element.addEventListener('mousedown', onMouseDown);
					} else {
						element.removeEventListener('mousedown', onMouseDown);
					}
				}
			}
			_disabled = value;
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

    public function get step():Number
    {
    	return Number(input.step);
    }

    public function set step(value:Number):void
    {
        //TODO why is this a string?
        input.step = "" + value;
    }
    
    public function get min():Number
    {
    	return Number(input.min);
    }

    public function set min(value:Number):void
    {
        //TODO why is this a string?
        input.min = "" + value;
    }
    
    public function get max():Number
    {
    	return Number(input.max);
    }

    public function set max(value:Number):void
    {
        //TODO why is this a string?
        input.max = "" + value;
    }

    private var _displayValue:Boolean;

    public function get displayValue():Boolean
    {
    	return _displayValue;
    }

    public function set displayValue(value:Boolean):void
    {
        if(value != !!_displayValue){
        	_displayValue = value;
            setLabel();
        }
    }
    private var _label:String;

    public function get label():String
    {
    	return _label;
    }

    public function set label(value:String):void
    {
    	_label = value;
        setLabel();
    }

    private function setLabel():void{
			COMPILE::JS
			{
        if(!labelContainer){
            labelContainer = newElement("div","spectrum-Slider-labelContainer");
						element.insertBefore(labelContainer,controlsContainer);
        }
        if(_label && !labelNode){
            labelNode = new TextNode("label");
            labelNode.className = "spectrum-Slider-label";
            labelContainer.insertBefore(labelNode.element,labelContainer.childNodes[0] || null);
        }
        if(_displayValue && !valueNode){
            valueNode = new TextNode("div");
            valueNode.className = "spectrum-Slider-value";
            labelContainer.appendChild(valueNode.element);
        }
			}
        if(labelNode){
            labelNode.text = _label;
        }
        if(valueNode){
            valueNode.text = "" + value;
        }
    }
    
    private var _filled:Boolean;

    public function get filled():Boolean
    {
    	return _filled;
    }

    public function set filled(value:Boolean):void
    {
    	_filled = value;
        toggle(valueToSelector("filled"),value);
    }

    COMPILE::JS
    private var input:HTMLInputElement;
    COMPILE::SWF
    private var input:Object;

    COMPILE::JS
    private var labelContainer:HTMLElement;
    COMPILE::JS
    private var controlsContainer:HTMLElement;
    
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

    private var labelNode:TextNode;
    private var valueNode:TextNode;
		
		COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
        /**
         <div class="spectrum-Slider-controls">
            <div class="spectrum-Slider-track"></div>
            <div class="spectrum-Slider-handle" style="left: 40%;">
            <input type="range" class="spectrum-Slider-input" value="14" step="2" min="10" max="20">
            </div>
            <div class="spectrum-Slider-track"></div>
        </div>
        */
        var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
        controlsContainer = newElement("div","spectrum-Slider-controls");
        //first track
				leftTrack = newElement("div","spectrum-Slider-track");
        controlsContainer.appendChild(leftTrack);
        
        //handle
        handle = newElement("div","spectrum-Slider-handle");
        input = newElement("input","spectrum-Slider-input") as HTMLInputElement;
        input.type = "range";
				input.step = "1";
        input.onchange = handleChange();
        handle.appendChild(input);
        controlsContainer.appendChild(handle);

        //second track
				rightTrack = newElement("div","spectrum-Slider-track");
        controlsContainer.appendChild(rightTrack);

        elem.appendChild(controlsContainer);
    		element.addEventListener('mousedown', onMouseDown);
        return elem;
    }
		// Element interaction
		COMPILE::JS
		private function onMouseDown(e:MouseEvent):void {
			onMouseMove(e);
			window.addEventListener('mouseup', onMouseUp);
			window.addEventListener('mousemove', onMouseMove);
		}
		COMPILE::JS
		private function onMouseUp():void {
			window.removeEventListener('mouseup', onMouseUp);
			window.removeEventListener('mousemove', onMouseMove);
		}
		COMPILE::JS
		private function onMouseMove(e:MouseEvent):void {
			var sliderOffsetWidth:Number = element.offsetWidth;
			var sliderOffsetLeft:Number = element.offsetLeft + (element.offsetParent as HTMLElement).offsetLeft;

			var x:Number = Math.max(Math.min(e.x-sliderOffsetLeft, sliderOffsetWidth), 0);
			var percent:Number = (x / sliderOffsetWidth) * 100;
			var val:Number = (max-min) / (100/percent);
			var stepVal:Number = step;
			var rem:Number = val % stepVal;
			val = val - rem;
			if (rem > (stepVal/2)){
		    val += stepVal;
			}
			value = val;
			// value = Math.round(val * 10000)/10000;
    }
// This should probably be a separate component
    // private var _color:Boolean;
    // public function get color():Boolean
    // {
    //     return _color;
    // }
    // public function set color(value:Boolean):void
    // {
    //     if(value != !!_color){
    //         toggle(valueToSelector("color"),value);
    //     }
    //     _color = value;
    // }

    // private var _showingAlpha:Boolean;
    // public function get showingAlpha():Boolean
    // {
    //     return _showingAlpha;
    // }
    // public function set showingAlpha(value:Boolean):void
    // {
    //     _showingAlpha = value;
    // }

/**
TODO
For video player there are additional buffer elements. It probably makes sense to add a separate component for that...
<div class="spectrum-Slider">
  <div class="spectrum-Slider-labelContainer">
    <label class="spectrum-Slider-label" id="spectrum-Slider-label-16" for="spectrum-Slider-input-16">My Video</label>
    <div class="spectrum-Slider-value">3:48</div>
  </div>
  <div class="spectrum-Slider-controls">
    <div class="spectrum-Slider-track"></div>
    <div class="spectrum-Slider-buffer" style="width: 20%;" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="50" aria-labelledby="spectrum-Slider-label-16"></div>
    <div class="spectrum-Slider-handle" style="left: 20%;">
      <input type="range" class="spectrum-Slider-input" aria-valuetext="3:48" value="228" min="0" max="760" id="spectrum-Slider-input-16">
    </div>
    <div class="spectrum-Slider-buffer" style="left: 20%; width: 30%;"></div>
    <div class="spectrum-Slider-track"></div>
  </div>
</div>

 */
  }
}