package com.unhurdle.spectrum
{

  import org.apache.royale.core.IBead;
  import org.apache.royale.core.IPopUp;
  import org.apache.royale.core.IStrand;
  import org.apache.royale.events.Event;
  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.functional.decorator.debounceLong;
  import org.apache.royale.geom.Rectangle;
  import org.apache.royale.html.beads.DataContainerView;
  import org.apache.royale.utils.DisplayUtils;
  import org.apache.royale.core.IItemRenderer;
  import org.apache.royale.core.IUIBase;

	[Event(name="change", type="org.apache.royale.events.Event")]
  public class ComboBoxList extends Popover implements IPopUp, IBead
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
		private var search:Search;
		private var _searchable:Boolean;

		public function get searchable():Boolean
		{
			return _searchable;
		}

		public function set searchable(value:Boolean):void
		{
			_searchable = value;
			if(!_searchable){
				if(search && search.parent == this){
					removeElement(search);
				}
			} else {
				if(!search){
					search = new Search();
					search.addEventListener("input",debounceLong(handleSearch,150));
					search.addEventListener("search",handleSearch);
					search.tabFocusable = true;
				}
				addElement(search);
			}
		}
		protected function handleSearch():void {
			var dataView:DataContainerView = list.view as DataContainerView;
			var len:int = dataView.numItemRenderers;
			var appliedFilterFunction:Function = _filterFunction != null ? _filterFunction : defaultFilterFunction;
			for (var i:int = 0; i < len; i++) {
				var renderer:IItemRenderer = dataView.getItemRendererAt(i) as IItemRenderer;
				if (!search.text || (appliedFilterFunction(renderer.data, search.text))) {
					(renderer as IUIBase).visible = true;
				}
				else {
					(renderer as IUIBase).visible = false;
				}
			}
		}

		protected function defaultFilterFunction(data:Object, searchText:String):Boolean {
			return data.label && data.label.toLowerCase().includes(searchText.toLowerCase());
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




	private var _filterFunction:Function;
	public function set filterFunction(func:Function):void {
		_filterFunction = func;
	}

	public function get filterFunction():Function
	{
		return _filterFunction;
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

		public function set strand(value:IStrand):void
		{
			// TODO this stub is purely for interface compatibility
		}
  }
}