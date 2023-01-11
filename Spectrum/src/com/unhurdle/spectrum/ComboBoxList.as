package com.unhurdle.spectrum
{
  import org.apache.royale.core.IPopUp;
  import org.apache.royale.events.Event;
  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.geom.Rectangle;
  import org.apache.royale.utils.DisplayUtils;

	[Event(name="change", type="org.apache.royale.events.Event")]
  public class ComboBoxList extends Popover implements IPopUp
  {
    public function ComboBoxList()
    {
      _list = new Menu();
      floating = true;
      tabFocusable = false;
      _list.addEventListener("change", handleListChange);
    }
    private var _list:Menu;

    public function get list():Menu
    {
    	return _list;
    }

    override public function addedToParent():void{
      super.addedToParent();
      addElement(_list);
    }

    public function set list(value:Menu):void
    {
    	_list = value;
    }
    override public function set tabFocusable(value:Boolean):void
    {
    	_tabFocusable = value;
      if(value){
        setAttribute("tabindex",0);
      } else {
        setAttribute("tabindex",-1);
      }
    }
    override public function set open(value:Boolean):void{
      super.open = value;
      if(value){
        _list.focus();
        addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
        topMostEventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
      } else {
        _list.blur();
				removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
				topMostEventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
      }
    }
    public function handleListChange():void{
			open = false;
			dispatchEvent(new Event("change"));
		}
    protected function handleControlMouseDown(event:MouseEvent):void{			
			event.stopImmediatePropagation();
		}
    protected function handleTopMostEventDispatcherMouseDown(event:MouseEvent):void{
			open = false;
		}
    private var _minMenuHeight:Number = 60;

		public function get minMenuHeight():Number{
			return _minMenuHeight;
		}

		public function set minMenuHeight(value:Number):void{
			_minMenuHeight = value;
		}
    public function positionPopup(componentBounds:Rectangle,preferredWidth:Number = NaN):void{
			var minHeight:Number = _minMenuHeight + 6;
			// Figure out direction and max size
			var appBounds:Rectangle = DisplayUtils.getScreenBoundingRect(Application.current.initialView);
			var spaceToBottom:Number = appBounds.bottom - componentBounds.bottom;
			var spaceToTop:Number = componentBounds.top - appBounds.top;
			var spaceOnBottom:Boolean = spaceToBottom >= spaceToTop;
			var pxStr:String = "px";
			switch(position)
			{
				case "top":
					if(spaceToTop >= minHeight || !spaceOnBottom){
						positionPopoverTop(appBounds.bottom - componentBounds.top,spaceToTop);
					} else {
						positionPopoverBottom(componentBounds,spaceToBottom);

					}
					break;
				default:
					if(spaceToBottom >= minHeight || spaceOnBottom){
						positionPopoverBottom(componentBounds,spaceToBottom);
					} else {
						positionPopoverTop(appBounds.bottom - componentBounds.top,spaceToTop);
					}
					break;
			}
			var leftSpace:Number = componentBounds.x;
			var rightSpace:Number = appBounds.width - (componentBounds.x + componentBounds.width);
			if(rightSpace < leftSpace){
				setStyle("right",rightSpace + "px");
				setStyle("left",null);
			} else {
				setStyle("right",null);
				setStyle("left",leftSpace + "px");
			}
			if(isNaN(explicitWidth) && !isNaN(preferredWidth)){
				setStyle("minWidth",preferredWidth + "px");
				// popover.width = width;
			}
		}
		private function positionPopoverBottom(componentBounds:Rectangle,maxHeight:Number):void{
			maxHeight -= 6;
			var pxStr:String;
			setStyle("bottom","");
			pxStr = componentBounds.bottom + "px";
			setStyle("top",pxStr);
			pxStr = maxHeight + "px";
			setStyle("max-height",pxStr);
			if(position == "top"){
				position = "bottom";
			}
		}
		private function positionPopoverTop(bottom:Number,maxHeight:Number):void{
			maxHeight -= 6;
			var pxStr:String;
			pxStr = bottom + "px";
			setStyle("top","");
			setStyle("bottom",pxStr);
			pxStr = maxHeight + "px";
			setStyle("max-height",pxStr);
			if(position == "bottom"){
				position = "top";
			}
		}
  }
}