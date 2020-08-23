package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }

  import com.unhurdle.spectrum.const.IconType;
  import org.apache.royale.html.util.getLabelFromData;
  import org.apache.royale.collections.IArrayList;
  import com.unhurdle.spectrum.data.MenuItem;
  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.events.Event;
  import org.apache.royale.geom.Rectangle;
  import org.apache.royale.utils.DisplayUtils;
  import org.apache.royale.utils.callLater;
	// import com.unhurdle.spectrum.data.IMenuItem;
	import com.unhurdle.spectrum.const.IconPrefix;
	import com.unhurdle.spectrum.data.IMenuItem;
  /**
   * TODO maybe add flexible with styling of min-width: 0;width:auto;
   */
	[Event(name="change", type="org.apache.royale.events.Event")]
	[Event(name="showMenu", type="org.apache.royale.events.Event")]
  public class Dropdown extends SpectrumBase
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/dropdown/dist.css");
     * document.height.appendSelector(link);
     * </inject_script>
     */
    public function Dropdown()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Dropdown";
    }
    private var button:FieldButton;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      button = new FieldButton();
      button.labelClass = appendSelector("-label");
      button.className = appendSelector("-trigger");
      button.addEventListener("click",toggleDropdown);
      var type:String = IconType.CHEVRON_DOWN_MEDIUM;
      button.icon = Icon.getCSSTypeSelector(type);
      button.iconType = type;
      button.iconClass = appendSelector("-icon");
      button.textNode.element.style.maxWidth = '85%';
      addElement(button);
      popover = new ComboBoxList();
      popover.className = appendSelector("-popover");
      // popover.percentWidth = 100;
      // popover.style = {"z-index":100};//????
      // menu = new Menu();
      // popover.addElement(menu);
      menu.addEventListener("change", handleListChange);
      menu.percentWidth = 100;
      popover.style = {"z-index": "2"};
      return elem;
    }
    public var popover:ComboBoxList;
    private function get menu():Menu{
      return popover.list;
    }

    private function toggleDropdown(ev:*):void{
      var minHeight:Number = _minMenuHeight + 6;
      ev.preventDefault();
      var open:Boolean = !popover.open;
      toggle("is-open",open);
      if(open){
        // Figure out direction and max size
        var appBounds:Rectangle = DisplayUtils.getScreenBoundingRect(Application.current.initialView);
        var componentBounds:Rectangle = DisplayUtils.getScreenBoundingRect(this);
        var spaceToBottom:Number = appBounds.bottom - componentBounds.bottom;
        var spaceToTop:Number = componentBounds.top - appBounds.top;
        var spaceOnBottom:Boolean = spaceToBottom >= spaceToTop;
        var pxStr:String = "px";
        switch(_position)
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
          popover.setStyle("right",rightSpace + "px");
          popover.setStyle("left",null);
        } else {
          popover.setStyle("right",null);
          popover.setStyle("left",leftSpace + "px");
        }
        if(isNaN(_popupWidth)){
          popover.setStyle("minWidth",width + "px");
          // popover.width = width;
        }
        dispatchEvent(new Event("showMenu"));
				callLater(openPopup)
      } else {
        closePopup();
      }
      button.selected = !open;
    }
    private function openPopup():void{
      popover.open = true;
			button.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
      popover.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
			topMostEventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
    }
    private function closePopup():void{
      if(popover && popover.open){
  			popover.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
	  		button.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
		  	topMostEventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
        popover.open = false;
      }

    }
    private function positionPopoverBottom(componentBounds:Rectangle,maxHeight:Number):void{
      maxHeight -= 6;
      var pxStr:String;
      popover.setStyle("bottom","");
      pxStr = componentBounds.bottom + "px";
      popover.setStyle("top",pxStr);
      pxStr = maxHeight + "px";
      popover.setStyle("max-height",pxStr);
      if(popover.position == "top"){
        popover.position = "bottom";
      }
    }
    private function positionPopoverTop(bottom:Number,maxHeight:Number):void{
      maxHeight -= 6;
      var pxStr:String;
      pxStr = bottom + "px";
      popover.setStyle("top","");
      popover.setStyle("bottom",pxStr);
      pxStr = maxHeight + "px";
      popover.setStyle("max-height",pxStr);
      if(popover.position == "bottom"){
        popover.position = "top";
      }
    }
		protected function handleControlMouseDown(event:MouseEvent):void
		{			
			event.stopImmediatePropagation();
		}
		protected function handleTopMostEventDispatcherMouseDown(event:MouseEvent):void
		{
      closePopup();
		}
    public function get dataProvider():Object{
      return menu.dataProvider;
    }
    public function set dataProvider(value:Object):void{
      if(value is Array){
        convertArray(value);
      } else if(value is IArrayList){
        convertArray(value.source);
      }
      menu.dataProvider = value;
    }

    public function get selectedIndex():int
    {
    	return menu.selectedIndex;
    }

    public function set selectedIndex(value:int):void
    {
    	menu.selectedIndex = value;
      setButtonText();
    }

    private function setButtonAsset(index:int,icon:Boolean):void{
      if(button.getElementAt(0) is IAsset){
        button.removeElement(button.getElementAt(0));
      }
      if (icon)
      {
        var iconClone:Icon = new Icon(dataProvider[index].icon);
        button.addElementAt(iconClone, 0);
      } else
      {
        var asset:ImageAsset = new ImageAsset();
        asset.style = "width:18px;margin-right:8px;";      
        asset.src = icon? dataProvider[index].icon: dataProvider[index].imageIcon;
        button.addElementAt(asset,0);
      }
    }
    private function setButtonText():void{
      if(selectedIndex){
        if(selectedIndex < 0 || dataProvider[selectedIndex].isDivider){
          button.text = "";
        }else{
          button.text = dataProvider[selectedIndex].text;
          if(dataProvider[selectedIndex].imageIcon){
            setButtonAsset(selectedIndex,false);
          }else if(dataProvider[selectedIndex].icon){
            setButtonAsset(selectedIndex,true);
          }
        }
      }else if(!selectedItem ||selectedItem.isDivider){
        button.text = "";
      }else{
        button.text = selectedItem.text;
        var i:int = dataProvider.indexOf(selectedItem)
        if(dataProvider[i].imageIcon){
          setButtonAsset(i,false);
        }else if(dataProvider[i].icon){
          setButtonAsset(i,true);
        }
      }

    }

    public function get selectedItem():Object
    {
    	return menu.selectedItem;
    }

    public function set selectedItem(value:Object):void
    {
    	menu.selectedItem = value;
      setButtonText();
    }
    private function convertArray(value:Object):void{
      var newVal:Array;
      newVal = new Array(value.length);
      var len:int = value.length;
      for(var i:int = 0;i<len;i++){
        if(value[i] is IMenuItem){
          continue;
        }
        var item:MenuItem = new MenuItem(getLabelFromData(this,value[i]));
        if(value[i].isDivider){
          item.isDivider = value[i]["isDivider"];
        }
        if(value[i].disabled){
          item.disabled = value[i]["disabled"];
        }
        if(value[i].icon){
          item.icon = value[i]["icon"];
        }
        if(value[i].imageIcon){
          item.imageIcon = value[i]["imageIcon"];
        }
        if(value[i].selected || i == selectedIndex || value[i] == selectedItem){
          item.selected = value[i]["selected"];
          if(item.icon){
            setButtonAsset(i,true);
          }else if(item.imageIcon){
            setButtonAsset(i,false);
          }
        }
        value[i] = item;
      }
    }
    private var _placeholder:String;
    public function get placeholder():String
    {
    	return _placeholder;
    }

    public function set placeholder(value:String):void
    {
      _placeholder = value;
    	button.placeholderText = value;
    }

    public function handleListChange():void{
      closePopup();
      setButtonText();
      toggle("is-open",false);
      dispatchEvent(new Event("change"));
    }
    
    private var _invalid:Boolean;

    public function get invalid():Boolean
    {
    	return _invalid;
    }

    public function set invalid(value:Boolean):void
    {
      if(value != _invalid){
        toggle("is-invalid",value);
        button.invalid = value;
        if(value){
          var invalidIcon:Icon = new Icon(IconPrefix._18 + "Alert");
          button.addElementAt(invalidIcon, button.numElements - 1);
        }else{
          button.removeElement(invalidIcon);
        }
      }
    	_invalid = value;
    }
    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(value != _quiet){
        toggle(valueToSelector("quiet"),value);
        button.quiet = value;
        popover.quiet = value;
      }
    	_quiet = value;
    }

    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      if(value != !!_disabled){
        toggle("is-disabled",value);
        button.disabled = value;
      }
    	_disabled = value;
    }
    private var _popupWidth:Number;

    public function get popupWidth():Number
    {
    	return _popupWidth;
    }

    public function set popupWidth(value:Number):void
    {
    	_popupWidth = value;
      popover.width = value;
    }
    private var _position:String;

    public function get position():String
    {
    	return _position;
    }

    private var _minMenuHeight:Number = 60;

    public function get minMenuHeight():Number
    {
    	return _minMenuHeight;
    }

    public function set minMenuHeight(value:Number):void
    {
    	_minMenuHeight = value;
    }

    public function set position(value:String):void
    {
      switch(value){
        case "bottom":
        // break;
          case "top":
              // (element as HTMLElement).insertBefore((element as HTMLElement).removeChild(popover.element as HTMLElement),button.element as HTMLElement);
            // popover.style = {"bottom":"30px"};
            // break;
          case "right":
          case "left":
            break;
          default:
            throw new Error("invalid position: " + value);
      }
      if(value != !!_position){
        popover.position = value;
      }
    	_position = value;
    }
  }
}