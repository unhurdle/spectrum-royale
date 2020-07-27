package com.unhurdle.spectrum
{
	COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  public class SplitView extends Group
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
    }
    override protected function getSelector():String{
        return "spectrum-SplitView";
    }
		protected var splitter:HTMLDivElement;
		
		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
			splitter = newElement('div') as HTMLDivElement;
			splitter.className = appendSelector("-splitter");
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
			COMPILE::JS{
				if(element.children && element.children[2]){
					if(direction === "horizontal"){
						element.children[0].style.width = percent + "%";
						splitter.style.left = "0";
						element.children[2].style.left = percent + "%" + splitter.style.width;
						element.children[2].style.width = (100 - percent) + "%";
					}else{
						element.children[0].style.height = percent + "%";
						splitter.style.top = "0";
						element.children[2].style.top = percent + "%" + splitter.style.height;
						element.children[2].style.height = (100 - percent) + "%";
					}
				}
				if(position == 0){
					splitter.classList.add("is-collapsed-");
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
				if(_positionCollapsed == 0){
					oldpositionCollapsed = "is-collapsed-start";
					splitter.classList.remove(oldpositionCollapsed);
				} else if(_positionCollapsed == 100){
					oldpositionCollapsed = "is-collapsed-end";
					splitter.classList.remove(oldpositionCollapsed);
				}
				if(value == 0 || value == 100){
					var newpositionCollapsed:String;
					if(value == 0){
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
				var percent:Number;
				if(direction == "horizontal"){
					var sliderOffsetWidth:Number = element.offsetWidth;
					var sliderOffsetLeft:Number = element.offsetLeft;
					var x:Number = Math.max(Math.min(e.x - sliderOffsetLeft, sliderOffsetWidth), 0);
					percent = (x / sliderOffsetWidth) * 100;
				} else{
					// var sliderOffsetHeight:Number = element.offsetHeight;
					// var sliderOffsetTop:Number = element.offsetTop;
					// trace('sliderOffsetTop');trace(sliderOffsetTop);
					// trace('element.offsetTop');trace(element.offsetTop);
					// trace('e.offsetY');trace(e.offsetY);
					// trace('e.y');trace(e.y);
					// trace('Math.min(e.y - sliderOffsetTop, sliderOffsetHeight)');trace(Math.min(e.y - sliderOffsetTop, sliderOffsetHeight));
					// var y:Number = Math.max(Math.min(e.y - sliderOffsetTop, sliderOffsetHeight), 0);
					// trace('y');trace(y);
					// percent = (y / sliderOffsetHeight) * 100;
					// trace('percent');trace(percent);


					var sliderOffsetHeight:Number = element.offsetHeight;
					var sliderOffsetTop:Number = element.offsetTop;
					if(e.offsetY < 0 || e.offsetY < e.y - sliderOffsetTop){
						return;
					}
					percent = (e.offsetY / sliderOffsetHeight) * 100;

					// trace('e.pageY');trace(e.pageY);
					// trace('e.offsetY');trace(e.offsetY);
					// trace('element.scrollTop');trace(element.scrollTop);
					// trace('window.scrollY');trace(window.scrollY);
					// trace('window.scrollX');trace(window.scrollX);
					// trace('element.offsetTop');trace(element.offsetTop);
					// trace('element.parentElement');trace(element.parentElement);

					// var y:Number = e.pageY - element.offsetTop;
					// percent = (y / sliderOffsetHeight) * 100;
				}
				positionElements(percent);
			}
		}
		COMPILE::JS
		public override function addElement(c:org.apache.royale.core.IChild, dispatchEvent:Boolean = true):void{
			super.addElement(c,dispatchEvent);
			c.element.classList.add(appendSelector("-pane"));
			positionElements(position);
			if(element.children.length == 1){
				element.appendChild(splitter);
			}
			if(this is HSplitView){
				(this as HSplitView).leftVisible = (this as HSplitView).leftVisible;
				(this as HSplitView).rightVisible = (this as HSplitView).rightVisible;
			} else{
				(this as VSplitView).topVisible = (this as VSplitView).topVisible;
				(this as VSplitView).bottomVisible = (this as VSplitView).bottomVisible;
			}
		}
  }
}