package com.unhurdle.spectrum
{
	COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  public class SplitView extends SpectrumBase
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/splitview/dist.css">
     * </inject_html>
     * 
     */
    public function SplitView()
    {
      super();
			direction = "vertical";
			isCollapsed = "Resizable";
    }
    override protected function getSelector():String{
        return "spectrum-SplitView";
    }
		private var left:HTMLDivElement;
		private var splitter:HTMLDivElement;
		private var right:HTMLDivElement;
		
		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
			elem.style.height = "200px";
			elem.style.width = "500px";
			left = newElement('div') as HTMLDivElement;
			left.className = appendSelector("-pane");
			elem.appendChild(left);
			splitter = newElement('div') as HTMLDivElement;
			splitter.className = appendSelector("-splitter");
			elem.appendChild(splitter);
			right = newElement('div') as HTMLDivElement;
			right.className = appendSelector("-pane");
			elem.appendChild(right);
			return elem;
		}

		private var _isDraggable:Boolean;

		public function get isDraggable():Boolean
		{
			return _isDraggable;
		}

		public function set isDraggable(value:Boolean):void
		{
			value? splitter.classList.add("is-draggable"): splitter.classList.remove("is-draggable");
			_isDraggable = value;
			COMPILE::JS{
				if(!!_isDraggable){
					if(!splitter.children.length){
						splitter.appendChild(newElement("div",appendSelector("-gripper")));
						element.addEventListener("mousedown",onMouseDown);
					}
					direction == "horizontal"? positionElements(parseFloat(left.style.width)): positionElements(parseFloat(right.style.height));
				}
				if(!_isDraggable){
					if(!!splitter.children.length){
						splitter.removeChild(splitter.children[0]);
					}
						element.removeEventListener("mousedown",onMouseDown);
				}
			}
		}
		protected function positionElements(val:Number):void{
					var percent:Number = val;
					if(direction === "horizontal"){
						left.style.width = percent + "%";
						splitter.style.left = "0";
						right.style.left = percent + "%" + splitter.style.width;
					}else{
						left.style.height = percent + "%";
						splitter.style.top = "0";
						right.style.top = percent + "%" + splitter.style.height;
					}
		}
		private var _isCollapsed:String;

		public function get isCollapsed():String
		{
			return _isCollapsed;
		}

		public function set isCollapsed(value:String):void
		{
			if(value != !!_isCollapsed){
				switch (value){
					case "top":
						direction != "vertical"? direction = "vertical":direction = direction;
						splitter.style.top = "0";
						directionCollapsed = "start";
						break;
					case "left":
						direction != "horizontal"? direction = "horizontal":direction = direction;
						splitter.style.left = "0";
						directionCollapsed = "start";
						break;
					case "right":
						direction != "horizontal"? direction = "horizontal":direction = direction;
						positionElements(100);
						directionCollapsed = "end";
						break;
					case "bottom":
						direction != "vertical"? direction = "vertical":direction = direction;
						positionElements(100);
						directionCollapsed = "end";
						break;
					case "Resizable":
						directionCollapsed = "Resizable";
						break;
					default:
						throw new Error("Invalid Collapsed: " + value);
				}
				_isCollapsed = value;
			}
		}
		
		private var _directionCollapsed:String;
		private function get directionCollapsed():String
		{
			return _directionCollapsed;
		}
		private function set directionCollapsed(value:String):void
		{
			if(value != _directionCollapsed){
				switch (value){
					case "Resizable":
						break;
					case "start":
						left.style.flex = null
						!isDraggable? right.style.flex = "1": right.style.flex = null;
						break;
					case "end":
						right.style.flex = null;
						!isDraggable? left.style.flex = "1": left.style.flex = null;
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
					isDraggable = !!isDraggable;
				}
				else{
					isDraggable = true;
					left.style.flex = "auto";
					right.style.flex = "auto";
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
		private function onMouseDown(e: MouseEvent):void{
			COMPILE::JS{
    		element.addEventListener('mouseup', onMouseUp);
    		element.addEventListener('mousemove', onMouseMove);	
			}
		}
		private function onMouseUp(e: MouseEvent):void{
			COMPILE::JS{
				element.removeEventListener('mouseup', onMouseUp);
				element.removeEventListener('mousemove', onMouseMove);		
			}
		}
		private function onMouseMove(e: MouseEvent):void{
			COMPILE::JS{
				var sliderOffsetWidth:Number = element.offsetWidth;
				var sliderOffsetLeft:Number = element.offsetLeft + (element.offsetParent as HTMLElement).offsetLeft;
				var x:Number = Math.max(Math.min(e.x-sliderOffsetLeft, sliderOffsetWidth), 0);
				var percent:Number = (x / sliderOffsetWidth) * 100;
				positionElements(percent);
			}
		}
  }
}