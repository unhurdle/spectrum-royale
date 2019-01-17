package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.List;
  import com.unhurdle.spectrum.const.IconPrefix;
  import com.unhurdle.spectrum.const.IconSize;
  import org.apache.royale.events.MouseEvent;
  import com.unhurdle.spectrum.data.MenuItem;
  import org.apache.royale.html.util.getLabelFromData;
  import org.apache.royale.collections.IArrayList;

  public class ActionMenu extends SpectrumBase
  {
    public function ActionMenu()
    {
      super();
    }
    private var button:ActionButton;
    private var popover:Popover;
    private var menu:Menu;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      button = new ActionButton();
      button.className = //??
      button.icon = IconPrefix._18 + "More";
      button.iconSize = IconSize.S;
      button.addEventListener(MouseEvent.MOUSE_DOWN,toggleMenu);
      addElement(button);

      popover = new Popover();
      popover.position = "bottom";

      menu = new Menu();
      popover.addElement(menu);
      addElement(popover);
      return elem;
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
    private function convertArray(value:Object):void{
      var newVal:Array;
      newVal = new Array(value.length);
      var len:int = value.length;
      for(var i:int = 0;i<len;i++){
        var item:MenuItem = new MenuItem(getLabelFromData(this,value[i]));
        value[i] = item;
      }
    }

    public function get text():String
    {
    	return button.text;
    }

    public function set text(value:String):void
    {
      button.text = value;
    }
    private function toggleMenu():void{
      popover.open = !popover.open;
      button.selected = popover.open;
    }
  }
}