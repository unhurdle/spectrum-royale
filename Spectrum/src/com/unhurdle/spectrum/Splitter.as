package com.unhurdle.spectrum
{
	public class Splitter extends SpectrumBase
	{
		public function Splitter()
		{
			super();
		}
    override protected function getSelector():String{
        return "spectrum-SplitView-splitter";
    }

		private var _draggable:Boolean;

		public function get draggable():Boolean
		{
			return _draggable;
		}

		private var _cursor:String;

		public function get cursor():String
		{
			return _cursor;
		}

		public function set cursor(value:String):void
		{
			_cursor = value;
			if(draggable){
				setStyle("cursor",value);
			}
		}
		public var gripper:HTMLDivElement;
		public function set draggable(value:Boolean):void
		{
			_draggable = value;
			COMPILE::JS
			{
				if(value){
					if(_cursor){
						setStyle("cursor",_cursor);
					}
					if(!element.children.length){
							gripper = newElement("div","spectrum-SplitView-gripper") as HTMLDivElement;
							element.appendChild(gripper);
					}
				} else {
					setStyle("cursor","");
					if(element.children.length){
							element.removeChild(element.children[0]);
					}
				}
			}
		}
	}
}