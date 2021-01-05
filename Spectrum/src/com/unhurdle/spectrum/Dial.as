package com.unhurdle.spectrum
{
    
	COMPILE::JS{
		import org.apache.royale.core.WrappedHTMLElement;
	}
	import org.apache.royale.events.Event;
	import com.unhurdle.spectrum.includes.SliderInclude;
	import org.apache.royale.utils.number.pinValue;
	import org.apache.royale.utils.number.getPercent;

	[Event(name="change", type="org.apache.royale.events.Event")]
	public class Dial extends SpectrumBase
	{
		public function Dial()
		{
				super();
		}

		override protected function getSelector():String{
				return SliderInclude.getDialSelector();
		}

		private var input:HTMLInputElement;
		private var handle:HTMLDivElement;
		private var labelContainer:HTMLElement;
		private var controlsContainer:HTMLElement;
		protected var labelNode:TextNode;
		protected var valueNode:TextNode;

		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = super.createElement();
			controlsContainer = newElement("div",appendSelector("-controls"));
			handle = newElement("div") as HTMLDivElement;
			handle.className = appendSelector("-handle");
			handle.tabIndex = 0;
			input = newElement("input") as HTMLInputElement;
			input.className = appendSelector("-input");
			input.type = "range";
			value = 0;
			min = 0;
			max = 100;
			handle.appendChild(input);
			controlsContainer.appendChild(handle);
			elem.appendChild(controlsContainer);
			// element.addEventListener('mousedown', onMouseDown);
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

		[Inspectable(category="General", enumeration="small,large,normal", defaultValue="normal")]
		public function set size(val:String):void
		{
			if(val != _size){
				switch (val){
					case "small":
					case "large":
					case "normal":
							break;
					default:
							throw new Error("Invalid size: " + val);
				}
				var oldSize:String = valueToSelector(_size);
				if(val != "normal"){
					var newSize:String = valueToSelector(val);
					toggle(newSize, true);
				}
				toggle(oldSize, false);
				_size = val;
			}
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
				if(_label && !labelContainer){
					labelContainer = newElement("div",appendSelector("-labelContainer"));
					element.insertBefore(labelContainer,controlsContainer);
				}
				if(_label && !labelNode){
					labelNode = new TextNode("label");
					labelNode.className = appendSelector("-label");
					labelContainer.insertBefore(labelNode.element,labelContainer.childNodes[0] || null);
				}
				if(_displayValue && !valueNode){
					valueNode = new TextNode("div");
					valueNode.className = appendSelector("-value");
					labelContainer.appendChild(valueNode.element);
				}
			}
			if(labelNode){
					labelNode.text = _label;
			}
			if(valueNode){
					valueNode.text = "" + Math.round(value);
			}
		}

		private var _disabled:Boolean;

		public function get disabled():Boolean
		{
			return _disabled;
		}

		public function set disabled(val:Boolean):void
		{
			if(val != !!_disabled){
				toggle("is-disabled",val);
			}
			_disabled = val;
		}
		protected function positionElements():void{
			var percent:Number = this.value / (max - min) * 100;
			handle.tabIndex = Number(percent + "%");
			setLabel();
			var deg:Number = percent * 0.01 * (260) - 40;
			handle.style.transform = 'rotate('+ deg + 'deg'+')';
		}
		
		override public function addedToParent():void{
			super.addedToParent();
			if(!disabled){
					addEventListener('mousedown', onMouseDown);
			}

		}

		public function get value():Number
		{
			return Number(input.value);
		}

		public function set value(val:Number):void
		{
			//TODO why is this a string?
			// if(_disabled){
			// 	input.value = "-40";
			// 	return;
			// } 
			input.value = "" + val;
			positionElements();
				
		}

		private function onMouseDown(e:MouseEvent):void {
			window.addEventListener('mouseup', onMouseUp);
			window.addEventListener('mousemove', onMouseMove);
		}

		private function onMouseUp(e:MouseEvent):void {
			window.removeEventListener('mouseup', onMouseUp);
			window.removeEventListener('mousemove', onMouseMove);
		}

		private function onMouseMove(e:MouseEvent) :void{
			var elem:HTMLElement = element as HTMLElement;
			var dialOffsetWidth:Number = elem.offsetWidth;
			var dialOffsetLeft:Number = elem.offsetLeft + (elem.offsetParent as HTMLElement).offsetLeft;
			var x:Number = pinValue(e.x - dialOffsetLeft,0,dialOffsetWidth);
			var percent:Number = getPercent(x,dialOffsetWidth);
			var val:Number = (max-min) / (100/percent);
			value = val;
			dispatchEvent(new Event("change"));
		}
	}
}