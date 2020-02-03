package com.unhurdle.spectrum
{
	COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
    import org.apache.royale.events.Event;
    import org.apache.royale.utils.PointUtils;
    import org.apache.royale.events.MouseEvent;
    import org.apache.royale.geom.Point;
    
	[Event(name="change", type="org.apache.royale.events.Event")]

  public class Slider extends SliderBase
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

    override public function set min(value:Number):void
    {
        super.min = value;
        if(showTickValues){
            calculateTickValues();
        }
    }

    override public function set max(value:Number):void
    {
        super.max = value;
        if(showTickValues){
            calculateTickValues();
        }
    }

    override protected function positionElements():void{ 
        displayValue = true;
        var percent:Number = (this.value - min) / (max - min) * 100;
        handle.style.left = percent + "%";
        // Set initial track position
        leftTrack.style.width = percent + '%';
        rightTrack.style.width = (100 - percent) + '%';
        if(filledOffset){
            setFillTrack();
        }
    }
		override protected function enableDisableInput(value:Boolean):void{
			input.disabled = value;
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
			if(label && valueNode){
				valueNode.text = "" + value;
			}
    }



		override protected function getValue():String{
			// override in subclass
			return input.value;
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

    private var _filledOffset:Number;

    public function get filledOffset():Number
    {
    	return _filledOffset;
    }

    public function set filledOffset(value:Number):void
    {
    	_filledOffset = value;
        if(value){
            if(!fillTrack){
                fillTrack = newElement("div",appendSelector("-fill"));
            }
            setFillTrack();
            controlsContainer.appendChild(fillTrack);
        }else{
            if(controlsContainer.contains(fillTrack)){
                fillTrack = null
                controlsContainer.removeChild(fillTrack);
            }
        }
    }
    private function setFillTrack():void{
        var len:String = handle.style.left.slice(0,handle.style.left.indexOf("%"));
        var l:Number = int(len) - filledOffset;
        if(l>0){
            if(fillTrack.classList.contains(appendSelector("-right"))){
                fillTrack.classList.remove(appendSelector("-right"));                
            }
            fillTrack.style.left = filledOffset + "%";
            l -= 3;
        }else{
            if(!fillTrack.classList.contains(appendSelector("-right"))){
                fillTrack.classList.add(appendSelector("-right"));                
            }
            fillTrack.style.left = (filledOffset+l) + "%";
            l *= (-1);
        }
        fillTrack.style.width = l + "%";
    }
    private var _ticks:int;

    public function get ticks():int
    {
    	return _ticks;
    }

    public function set ticks(value:int):void
    {
        if(value != _ticks){
            toggle(valueToSelector("tick"),!!value);
            if(!!value){
                leftTrack.style.visibility = rightTrack.style.visibility = "hidden"
            }else{
                leftTrack.style.visibility = rightTrack.style.visibility = "visible"                
            }
            var base:String = getSelector();
        	_ticks = value;
            if(!tickContainer){
                tickContainer = newElement("div", base + "-ticks");
                controlsContainer.insertBefore(tickContainer,handle);
            } else {
                tickContainer.innerHTML = "";
            }
            tickArray = [];
            for(var i:int=0;i<value;i++){
                var tick:HTMLElement = newElement("div",base + "-tick");
                var node:TextNode = new TextNode("div");
                node.className = base + "-tickLabel";
                tick.appendChild(node.element);
                tickArray.push(node);
                tickContainer.appendChild(tick);
            }
            if(_showTickValues){
                calculateTickValues();
            }

        }

    }

    private var tickArray:Array;

    private var _showTickValues:Boolean;

    public function get showTickValues():Boolean
    {
    	return _showTickValues;
    }

    public function set showTickValues(value:Boolean):void
    {
    	_showTickValues = value;
        calculateTickValues();
    }
    private function calculateTickValues():void{
        if(!tickArray || !tickArray.length){
            return;
        }
        if(_showTickValues){
            toggle(valueToSelector("tick"),false);
            // don't bother figuring this out if we're not showing them
            var numTicks:Number = tickArray.length;
            var minVal:Number = min;
            var maxVal:Number = max;
            var span:Number = maxVal - minVal;
            var increment:Number = span/(numTicks - 1);
        }
        for(var i:int=0;i<numTicks;i++){
            if(_showTickValues){
                tickArray[i].text = "" + minVal;
                minVal = Math.round((minVal + increment) * 100)/100;
            } else {
                tickArray[i].text = "";
            }
        }
    }

    private var tickContainer:HTMLElement;
    private var handle:HTMLElement;
    private var fillTrack:HTMLElement;
	private var leftTrack:HTMLElement;
  	private var rightTrack:HTMLElement;
		
	COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
        var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
        controlsContainer = newElement("div",appendSelector("-controls"));
        //first track
		leftTrack = newElement("div",appendSelector("-track"));
        controlsContainer.appendChild(leftTrack);
        
        //handle
        handle = newElement("div",appendSelector("-handle"));
        input = newElement("input",appendSelector("-input")) as HTMLInputElement;
        input.type = "range";
		input.step = "1";
        handle.appendChild(input);
        controlsContainer.appendChild(handle);

        //second track
		rightTrack = newElement("div",appendSelector("-track"));
        controlsContainer.appendChild(rightTrack);

        elem.appendChild(controlsContainer);
        element.addEventListener('mousedown', onMouseDown);
        return elem;
    }
		// Element interaction
		override protected function onMouseMove(e:MouseEvent):void {
            if(disabled){
                return;
            }
            var elem:HTMLElement = element as HTMLElement;
			var sliderOffsetWidth:Number = elem.offsetWidth;
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
			value = val;
            positionElements();
            dispatchEvent(new Event("change"));
			// value = Math.round(val * 10000)/10000;
    }
  }
}
