package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.const.IconPrefix;  
  import org.apache.royale.html.util.getLabelFromData;
  import com.unhurdle.spectrum.const.IconType;
  import org.apache.royale.collections.IArrayList;
  import com.unhurdle.spectrum.data.MenuItem;

  public class SplitButton extends SpectrumBase
  {
    public function SplitButton()
    {
      super();
      type = "primary";
    }
    override protected function getSelector():String{
      return "spectrum-SplitButton";
    }


    private var actionButton:Button;
    private var triggerButton:Button;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,"div");
      actionButton = new Button();
      actionButton.className = appendSelector("-action");
      actionButton.addEventListener("click",toggleDropdown);
      triggerButton = new Button();
      triggerButton.className = appendSelector("-trigger");
      triggerButton.addEventListener("click",toggleDropdown);
      var type:String = IconType.CHEVRON_DOWN_MEDIUM;
      triggerButton.icon = Icon.getCSSTypeSelector(type);
      triggerButton.iconType = type;
      triggerButton.iconClass = appendSelector("-icon");
      addElement(actionButton);
      addElement(triggerButton);
      popover = new Popover();
      // popover.className = appendSelector("-popover");
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
    private var _type:String;

    public function get type():String
    {
      return _type;
    }
    
    [Inspectable(category="General", enumeration="cta,primary,secondary", defaultValue="primary")]
    public function set type(value:String):void
    {
      if(value != _type){
        switch (value){
        // check that values are valid
          case "cta":
          case "primary":
          case "secondary":
            break;
          default:
              throw new Error("Invalid type: " + value);
        }
        actionButton.flavor = value;
        triggerButton.flavor = value;
        _type = value;
      }
    }
   
    private var _left:Boolean;

    public function get left():Boolean
    {
    	return _left;
    }

    public function set left(value:Boolean):void
    {
      if(value != !!_left){
        toggle(valueToSelector("left"),value);
        COMPILE::JS{
        if(value){
          removeElement(actionButton);
          addElement(actionButton);
        }
        }
      }
    	_left = value;
    }
    private var _text:String;

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
    	_text = value || "";
      actionButton.text = _text;
    }
    private var menu:Menu;
    private var popover:Popover;
 private function toggleDropdown():void{
      popover.open = !popover.open;
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
    public function handleListChange():void{
      popover.open = false;
    }
  }
}