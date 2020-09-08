package com.unhurdle.spectrum
{
	COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.core.IChild;

	[Event(name="resizeStart", type="org.apache.royale.events.Event")]
  [Event(name="resizeFinish", type="org.apache.royale.events.Event")]
  public class SplitView extends Group
  {

		public static const RESIZE_START:String = "resizeStart";
		public static const RESIZE_FINISH:String = "resizeFinish";

    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/splitview/dist.css">
     * </inject_html>
     * 
     */
    public function SplitView()
    {
      super();
			direction = "horizontal"
    }
    override protected function getSelector():String{
        return "spectrum-SplitView";
    }
		private var _splitter:HTMLDivElement;
		protected function get splitter():HTMLDivElement{
			if(!_splitter){
				_splitter = newElement('div') as HTMLDivElement;
				_splitter.className = appendSelector("-splitter");
			}
			return _splitter;
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
							splitter.addEventListener("mousedown",onMouseDown);
						}
					}
					if(!_isDraggable){
						if(!!splitter.children.length){
							splitter.removeChild(splitter.children[0]);
						}
							splitter.removeEventListener("mousedown",onMouseDown);
					}
				}
		}
		protected function positionElements(val:Number):void{
			positionCollapsed = val;
			var percent:Number = val;
			COMPILE::JS{
				if(element.children && element.children[2]){
					if(direction === "horizontal"){
						element.children[0].style.width = percent + "%";
						splitter.style.left = "0";
						element.children[2].style.width = (100 - percent) + "%";
					}else{
						element.children[0].style.height = percent + "%";
						splitter.style.top = "0";
						element.children[2].style.height = (100 - percent) + "%";
					}
				}
			}
		}
		private var _position:Number;

		public function get position():Number
		{
			return _position;
		}

		public function set position(value:Number):void
		{
			if(!isNaN(value)){
				_position = value;
				positionElements(value);
				positionCollapsed = value;
			}
		}

		private var _positionCollapsed:Number;
		private function get positionCollapsed():Number
		{
			return _positionCollapsed;
		}
		private function set positionCollapsed(value:Number):void
		{
			if(value != _positionCollapsed){
				var oldpositionCollapsed:String;
				if(_positionCollapsed < 1){
					oldpositionCollapsed = "is-collapsed-start";
					splitter.classList.remove(oldpositionCollapsed);
				} else if(_positionCollapsed > 99){
					oldpositionCollapsed = "is-collapsed-end";
					splitter.classList.remove(oldpositionCollapsed);
				}
				if(value < 1 || value > 99){
					var newpositionCollapsed:String;
					if(value < 1){
						newpositionCollapsed = "is-collapsed-start";
					} else{
						newpositionCollapsed = "is-collapsed-end";
					}
					splitter.classList.add(newpositionCollapsed);
					_positionCollapsed = value;
				}
			}
		}

		private var _direction:String;
		protected function get direction():String
		{
			return _direction;
		}
    [Inspectable(category="General", enumeration="horizontal,vertical", defaultValue="horizontal")]
		protected function set direction(value:String):void
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
				dispatchEvent(new Event("resizeStart"));
				e.preventDefault();
				e.stopImmediatePropagation();
    		window.addEventListener('mouseup', onMouseUp);
    		element.addEventListener('mousemove', onMouseMove);	
			}
		}
		private function onMouseUp(e: MouseEvent):void{
			COMPILE::JS{
				dispatchEvent(new Event("resizeFinish"));
				window.removeEventListener('mouseup', onMouseUp);
				element.removeEventListener('mousemove', onMouseMove);		
			}
		}
		private function onMouseMove(e: MouseEvent):void{
			COMPILE::JS{
				var percent:Number;
				var clientRect:ClientRect = element.getBoundingClientRect();
				if(direction == "horizontal"){
					var sliderLeft:Number = clientRect.left;
					var sliderWidth:Number = clientRect.width;
					var x:Number = Math.max(Math.min(e.clientX - sliderLeft, sliderWidth), 0);
					percent = (x / sliderWidth) * 100;
				} else{
					var sliderTop:Number = clientRect.top;
					var sliderHeight:Number = clientRect.height;
					var y:Number = Math.max(Math.min(e.clientY - sliderTop, sliderHeight), 0);
					percent = (y / sliderHeight) * 100;
				}
				_position = percent;
				positionElements(percent);
			}
		}
		
		public override function addElement(c:IChild, dispatchEvent:Boolean = true):void{
			super.addElement(c,dispatchEvent);
			c.element.classList.add(appendSelector("-pane"));
			positionElements(position);
			if(element.children.length == 1){
				element.appendChild(splitter);
			}
		}
  }
}