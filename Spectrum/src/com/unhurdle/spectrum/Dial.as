package com.unhurdle.spectrum
{
    
    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }

    public class Dial extends SpectrumBase
    {
        public function Dial()
        {
            super();
        }

        override protected function getSelector():String{
            return "spectrum-Dial";
        }
        COMPILE::JS
        private var elem:WrappedHTMLElement;

        COMPILE::SWF
        private var elem:Object;
        COMPILE::JS
        private var input:HTMLInputElement;
        COMPILE::SWF
        private var input:Object;
        COMPILE::JS
        private var handle:HTMLDivElement;
        COMPILE::SWF
        private var handle:Object;
        COMPILE::JS
        private var labelContainer:HTMLElement;
        COMPILE::SWF
        private var labelContainer:Object;
        COMPILE::JS
        private var label:TextNode;
        COMPILE::SWF
        private var label:Object;
        COMPILE::JS
        private var div:TextNode;
        COMPILE::SWF
        private var div:Object;

        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            elem = addElementToWrapper(this,'div');
            // if(_withLabel){
            //     labelContainer = newElement("div","spectrum-Dial-labelContainer");
            //     label = newElement("label") as HTMLLabelElement;
            //     label.className = "spectrum-Dial-label";
            //     label.id = "dialLabel";
            //     label.setAttribute("for","labeledDial");
            //     labelContainer.appendChild(label);
            //     div.element = newElement("div") as HTMLDivElement;
            //     div.element.className = "spectrum-Slider-value";
            //     div.element.setAttribute("role","textbox");
            //     div.element.setAttribute("aria-readonly",true);
            //     div.element.setAttribute("aria-labelledby","dialLabel");
            //     labelContainer.appendChild(div.element);
            //     elem.appendChild(labelContainer);
            // }
            var controls:HTMLDivElement = newElement("div") as HTMLDivElement;
            controls.className = "spectrum-Dial-controls";
            handle = newElement("div") as HTMLDivElement;
            handle.className = "spectrum-Dial-handle";
            handle.tabIndex = 0;
            // handle.setAttribute("tabindex",0);
            input = newElement("input") as HTMLInputElement;
            input.className = "spectrum-Dial-input";
            // if(_withLabel){
            //     input.id = "labeledDial";//when label
            // }
            input.type = "range";
            value = 0;
            // input.value = "0";
            min = 0;
            max = 100;
            handle.appendChild(input);
            controls.appendChild(handle);
            elem.appendChild(controls);
    		// element.addEventListener('mousedown', onMouseDown);
    		element.addEventListener('mouseup', onMouseUp);
    		element.addEventListener('mousemove', onMouseMove);
        return elem;
    }
    public function get min():Number
    {
    	return Number(input.min);
    }

    public function set min(val:Number):void
    {
        //TODO why is this a string?
        input.min = "" + val;
    }
    
    public function get max():Number
    {
    	return Number(input.max);
    }

    public function set max(val:Number):void
    {
        //TODO why is this a string?
        input.max = "" + val;
    }
		// Element interaction
		
        private var _size:String;

        public function get size():String
        {
            return _size;
        }

        public function set size(val:String):void
        {
            if(val != _size){
                switch (val){
                case "small":
                case "large":
                    break;
                default:
                    throw new Error("Invalid size: " + val);
                }
                var oldSize:String = valueToSelector(_size);
                var newSize:String = valueToSelector(val);
                toggle(newSize, true);
                toggle(oldSize, false);
                _size = val;
            }
        }private var _withLabel:Boolean;

        public function get withLabel():Boolean
        {
            return _withLabel;
        }

        public function set withLabel(val:Boolean):void
        {    
            if(val){
                addedToParent();
            }
            _withLabel = val;
        }
        private var _isDisabled:Boolean;

        public function get isDisabled():Boolean
        {
            return _isDisabled;
        }

        public function set isDisabled(val:Boolean):void
        {
            if(val != !!_isDisabled){
                toggle("is-disabled",val);
                // toggle(valueToSelector("is-disabled"),value);
            }
            _isDisabled = val;
        }
        protected function positionElements():void{
			COMPILE::JS
			{
				// var percent:Number = this.value / (max - min) * 100;
				// handle.tabIndex = percent;
				handle.tabIndex = value;
				// handle.style.left = percent + "%";
				// Set initial track position
				// leftTrack.style.width = percent + '%';
				// rightTrack.style.width = (100 - percent) + '%';
			}
		}
        
        COMPILE::JS
        override public function addedToParent():void{
			super.addedToParent();
            if(_withLabel){
                // input.id = "labeledDial";//when label
			    labelContainer = newElement("div","spectrum-Dial-labelContainer");
                label = new TextNode("");
                label.element = newElement("label") as HTMLLabelElement;
                label.element.className = "spectrum-Dial-label";
                // label.id = "dialLabel";
                // label.setAttribute("for","labeledDial");
                label.text = "label";
                labelContainer.appendChild(label.element);
                div = new TextNode("");
                div.element = newElement("div") as HTMLDivElement;
                div.element.className = "spectrum-dial-value";
                div.element.setAttribute("role","textbox");
                // div.element.setAttribute("aria-readonly",true);
                // div.element.setAttribute("aria-labelledby","dialLabel");
                div.element.innerText = value ? value : min;
                labelContainer.appendChild(div.element);
                elem.appendChild(labelContainer);
            }
    }

public function get value():Number
    {
        if(div){
    	    return Number(div.text);
        }
    	return Number(input.value);
    }

    public function set value(val:Number):void
    {
			//TODO why is this a string?
			input.value = "" + val;
			if(parent){
				positionElements();
			}
			if(div){
				div.text = "" + val;
			}

    }
        COMPILE::JS
         private function onMouseDown(e:MouseEvent):void {
            trace("private function onMouseDown(e:MouseEvent):void {");
            window.addEventListener('mouseup', onMouseUp);
            window.addEventListener('mousemove', onMouseMove);
        }
        COMPILE::JS
        private function onMouseUp(e:MouseEvent):void {
            trace("private function onMouseUp(e:MouseEvent):void {");
            window.removeEventListener('mouseup', onMouseUp);
            window.removeEventListener('mousemove', onMouseMove);
        }
        COMPILE::JS
        private function onMouseMove(e:MouseEvent) :void{
            trace("private function onMouseMove(e:MouseEvent) :void{");
             var dialOffsetWidth:Number = element.offsetWidth;
            var dialOffsetLeft:Number = element.offsetLeft + (element.offsetParent as HTMLElement).offsetLeft;
            var x:Number = Math.max(Math.min(e.x - dialOffsetLeft, dialOffsetWidth), 0);
            var percent:Number = (x / dialOffsetWidth) * 100;
            var deg:Number = percent * 0.01 * (max - min) + min;
            handle.style.transform = 'rotate('+ deg + 'deg'+')';
            var val:Number = (max-min) / (100/percent);
			// var stepVal:Number = step;
			// var rem:Number = val % stepVal;
			// val = val - rem;
			// if (rem > (stepVal/2)){
		    // val += stepVal;
			// }
			value = deg;
			// value = val;
        // }

        if (_isDisabled) {
            elem.addEventListener('mousedown', onMouseDown);
        }
        }
    }
}