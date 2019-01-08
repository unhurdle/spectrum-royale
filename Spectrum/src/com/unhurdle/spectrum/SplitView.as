package com.unhurdle.spectrum
{
COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  public class SplitView extends SpectrumBase
  {
    public function SplitView()
    {
      super();
    }
    override protected function getSelector():String{
        return "spectrum-SplitView";
    }
		private var left:HTMLDivElement;
		private var splitter:HTMLDivElement;
		private var right:HTMLDivElement;

		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
			elem.style.height = "200px";
			left = newElement('div') as HTMLDivElement;
			left.className = appendSelector("-pane");
			elem.appendChild(left);
			splitter = newElement('div') as HTMLDivElement;
			splitter.className = appendSelector("-splitter");
			if(_isDraggable){
						splitter.appendChild(newElement("div",appendSelector("-gripper")));
			}
			elem.appendChild(splitter);
			right = newElement('div') as HTMLDivElement;
			right.className = appendSelector("-pane");
			elem.appendChild(right);
			return elem;
		}
		private var _rightSide:Boolean;

		public function get rightSide():Boolean
		{
			return _rightSide;
		}

		public function set rightSide(value:Boolean):void
		{
			_rightSide = value;
		}

		private var _isDraggable:Boolean;

		public function get isDraggable():Boolean
		{
			return _isDraggable;
		}

		public function set isDraggable(value:Boolean):void
		{
			if(value != !! _isDraggable){
				value ? splitter.classList.add("is-draggable") : splitter.classList.remove("is-draggable");
			}
			_isDraggable = value;
		}
		private var _isCollapsed:String;

		public function get isCollapsed():String
		{
			return _isCollapsed;
		}

		public function set isCollapsed(value:String):void
		{
			if(value != _isCollapsed){
				switch (value){
					case "top":left.style.height = "0";
						directionCollapsed = "start";
						break;
					case "left":left.style.width = "0";
						directionCollapsed = "start";
						break;
					case "right":right.style.width = "0";
						directionCollapsed = "start";
						break;
					case "bottom":right.style.height = "0";
						directionCollapsed = "start";
						break;
					case "Resizable":
						if(direction == "horizontal"){
								left.style.width = "304px";
						} else{
								left.style.width = "50px";
						}  
						directionCollapsed = "Resizable";
						break;
					default:
						throw new Error("Invalid Collapsed: " + value);
				}
				_isCollapsed = value;
			}
		}
		
		private var _directionCollapsed:String;
		public function get directionCollapsed():String
		{
			return _directionCollapsed;
		}
		public function set directionCollapsed(value:String):void
		{
			if(value != _directionCollapsed){
				switch (value){
					case "Resizable":
					case "start":right.style.flex = "1";
						break;
					case "end":left.style.flex = "1";
						break;
					default:
						throw new Error("Invalid directioncollapsed: " + value);
				}
				if(_directionCollapsed){
					var oldDirectionCollapsed:String = "is-collapsed-"+_directionCollapsed;
					splitter.classList.remove(oldDirectionCollapsed);
				}
				if(value != "Resizable"){
					var newDirectionCollapsed:String = "is-collapsed-"+value;
					splitter.classList.add(newDirectionCollapsed);
					_directionCollapsed = value;
				}
				else{
					_directionCollapsed = null;
				}
			}
		}

		private var _direction:String;
		public function get direction():String
		{
				return _direction;
		}
		public function set direction(value:String):void
		{
			if(value != _direction){
				switch (value){
					case "vertical":
					case "horizontal":
						break;
					default:
						throw new Error("Invalid direction: " + value);
				}
				if(_direction){
					toggle(valueToSelector(_direction), false);
				}
				
				toggle(valueToSelector(value), true);
				_direction = value;
			}
		}
  }
}