package com.unhurdle.spectrum
{
	import org.apache.royale.events.Event;

	public class ExpandSearch extends Search
	{
		public function ExpandSearch()
		{
			super();
			COMPILE::JS
			{
				element.addEventListener("focusin",onFocus);
				element.addEventListener("focusout",onBlur);
				savedPosition = element.style.position;
				savedLeft = element.style.left;
			}
			collapse();
		}

		public var expandedWidth:String;

		private function onFocus(ev:Event):void{
			expand();
		}
		private function onBlur(ev:Event):void{
			collapse();
		}
		override public function get placeholder():String{
			if(savedPlacehold){
				return savedPlacehold;
			}
			return input.placeholder;
		}
		
		override public function set placeholder(value:String):void{
			savedPlacehold = value;
			if(!collapsed){
				input.placeholder = value;
			}
		}
		override public function set text(value:String):void{
			if(collapsed){
				savedValue = text;
			} else {
				super.text = value;
			}
		}
		override public function get text():String{
			if(collapsed){
				return savedValue;
			}
			return super.text;
		}

		private var savedPlacehold:String;
		private var collapsed:Boolean;
		private var savedWidth:Object;
		private var savedPosition:String;
		private var savedLeft:String;
		private var savedValue:String;
		private function collapse():void{
			collapsed = true;
			if(!savedPlacehold){
				savedPlacehold = input.placeholder;
			}
			input.placeholder = "";
			savedValue = input.text;
			input.text = "";
			button.visible = false;
			COMPILE::JS
			{
				savedWidth = element.style.width;
				element.style.position = savedPosition;
				element.style.left = savedLeft;
				element.style.width = "32px";
				element.style.zIndex = "";
				input.setStyle("min-width",0);
				input.input.style.padding = 0;
				input.input.style.borderStyle = "none";
				input.input.style.backgroundColor = "transparent";
				input.iconElement.setStyle("left","8px");
			}
		}
/**
 *   background-color: rgb(255, 255, 255);
  border: 1px solid;

 * 
 */
		private function expand():void{
			collapsed = false;
			input.placeholder = savedPlacehold;
			button.visible = true;
			input.text = savedValue ? savedValue : "";
			var left:Number = this.x;
			COMPILE::JS
			{
				savedPosition = element.style.position;
				savedLeft = element.style.left;
				element.style.position = "absolute";
				element.style.left = left + "px";
				element.style.width = expandedWidth ? expandedWidth : savedWidth;
				element.style.zIndex = 5;
				input.setStyle("min-width","");
				input.input.style.padding = "";
				input.input.style.borderStyle = "";
				input.input.style.backgroundColor = "";
				input.iconElement.setStyle("left","");
			}

		}
		override protected function handleSubmit(ev:Event):Boolean{
			COMPILE::JS
			{
				input.input.blur();
			}
			return super.handleSubmit(ev);
		}


	}
}