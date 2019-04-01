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
  import org.apache.royale.html.SimpleAlert;
  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.events.Event;

	[Event(name="change", type="org.apache.royale.events.Event")]
  public class Dropdown extends SpectrumBase
  {
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
      addElement(button);
      popover = new Popover();
      popover.className = appendSelector("-popover");
      popover.position = "bottom";
      // popover.percentWidth = 100;
      // popover.style = {"z-index":100};//????
      menu = new Menu();
      popover.addElement(menu);
      popover.addEventListener("click", handleListChange);
      popover.style = {"min-width":"100%","z-index": "1"};
      addElement(popover);
      return elem;
    }
    private var popover:Popover;
    private var menu:Menu;

    private function toggleDropdown(ev:*):void{
      ev.preventDefault();
      popover.open = !popover.open;
      button.selected = popover.open;
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
    }

    public function get selectedItem():Object
    {
    	return menu.selectedItem;
    }

    public function set selectedItem(value:Object):void
    {
    	menu.selectedItem = value;
    }
    private function convertArray(value:Object):void{
      var newVal:Array;
      newVal = new Array(value.length);
      var len:int = value.length;
      for(var i:int = 0;i<len;i++){
        var item:MenuItem = new MenuItem(getLabelFromData(this,value[i]));
        if(value[i].selected){
          item.selected = value[i]["selected"];
        }
        if(value[i].isDivider){
          item.isDivider = value[i]["isDivider"];
        }
        if(value[i].disabled){
          item.disabled = value[i]["disabled"];
        }
        if(value[i].icon){
          item.icon = value[i]["icon"];
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
      popover.open = false;
      if(!selectedItem.isDivider && !selectedItem.disabled){
        button.text = selectedItem.text;
      }
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
        //add invalid icon
      }
    	_invalid = value;
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
    private var _position:String;

    public function get position():String
    {
    	return _position;
    }

    public function set position(value:String):void
    {
      switch(value){
        case "bottom":
        break;
          case "top":
              // (element as HTMLElement).insertBefore((element as HTMLElement).removeChild(popover.element as HTMLElement),button.element as HTMLElement);
            popover.style = {"bottom":"30px"};
            break;
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