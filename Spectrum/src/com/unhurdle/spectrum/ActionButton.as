package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.utils.Timer;
  import org.apache.royale.utils.UIUtils;
  import org.apache.royale.core.IPopUpHost;
  import org.apache.royale.geom.Point;
  import org.apache.royale.utils.PointUtils;

  public class ActionButton extends Button
  {
    public function ActionButton()
    {
      super()
      toggle(valueToSelector("primary"),false);

    }
    override protected function getSelector():String{
      return "spectrum-ActionButton";
    }

    override public function set flavor(value:String):void{
      // do nothing
    }


    private var flyOutIconHolder:Icon;

    private function createFlyoutIcon():void{
      if(!flyOutIconHolder){
        flyOutIconHolder = new Icon("#spectrum-css-icon-CornerTriangle");
        flyOutIconHolder.className = "spectrum-Icon spectrum-UIIcon-CornerTriangle spectrum-ActionButton-hold";
        COMPILE::JS
        {
          element.appendChild(flyOutIconHolder.getElement());
          element.onmousedown = handleMouseDown;
        }
        timer = new Timer(1000,1);
        timer.addEventListener(Timer.TIMER,onTimer);

      }
    }

    private var _selectable:Boolean;

    public function get selectable():Boolean
    {
    	return _selectable;
    }

    public function set selectable(value:Boolean):void
    {
    	_selectable = value;
    }

    override public function addedToParent():void{
      super.addedToParent();
      COMPILE::JS
      {
        if(selectable){
          element.onclick = elementClicked;
        }
        if(dataProvider){
          createFlyoutIcon();
        }

      }
    }

    private var _selected:Boolean = false;

    public function get selected():Boolean
    {
    	return _selected;
    }

    public function set selected(value:Boolean):void
    {
      if(!!value != _selected){
      	_selected = value;
        toggle("is-selected",value);
      }
    }

    private function elementClicked(ev:*):void{
      selected = !selected;
    }

    private var _selectedIndex:int;

    public function get selectedIndex():int
    {
      if(menu){
        return menu.selectedIndex;
      }
    	return _selectedIndex;
    }

    public function set selectedIndex(value:int):void
    {
      if(menu){
        menu.selectedIndex = value;
      }
    	_selectedIndex = value;
    }
    private var _selectedItem:Object;

    public function get selectedItem():Object
    {
      if(menu){
        return menu.selectedItem;
      }
      if(_selectedIndex >=0 && dataProvider && _selectedIndex < dataProvider["length"]){
        if(dataProvider is Array){
          return dataProvider[_selectedIndex];
        }
        return dataProvider["source"][_selectedIndex];
      }
    	return null;
    }

    public function set selectedItem(value:Object):void
    {
      if(menu){
        menu.selectedItem = value;
      }
      if(dataProvider is Array){
        _selectedIndex = (dataProvider as Array).indexOf(value);
      }
      if(dataProvider.hasOwnProperty("source")){
        _selectedIndex = dataProvider["source"]["indexOf"](value);
      }
    	_selectedIndex = -1;
    }

    private var _dataProvider:Object;

    public function get dataProvider():Object
    {
    	return _dataProvider;
    }

    public function set dataProvider(value:Object):void
    {
    	_dataProvider = value;
      createFlyoutIcon();
      if(menu){
        menu.dataProvider = value;
      }
    }

    private function handleMouseDown(ev:*):void{
      COMPILE::JS
      {
  			window.addEventListener('mouseup', handleMouseUp);
      }
      timer.start();
    }

    private function handleMouseUp(ev:*):void{
      COMPILE::JS
      {
  			window.removeEventListener('mouseup', handleMouseUp);
      }
      if(timer){
        timer.reset();
      }
    }

    private var timer:Timer;

    private function onTimer(ev:*):void{
      timer.reset();
      showMenu();
    }
    public function showMenu():void{
      // construct if necessary and show the menu.
      if(!popup){
        popup = new ComboBoxList();
        menu = popup.list;
        menu.dataProvider = dataProvider;
      }
      var origin:Point = new Point(0, this.y+this.height);
      var relocated:Point = PointUtils.localToGlobal(origin,this);
      popup.x = relocated.x
      popup.y = relocated.y;

			var popupHost:IPopUpHost = UIUtils.findPopUpHost(this);
			popupHost.popUpParent.addElement(popup);
      popup.open = true;
    }
    private var menu:Menu;
    private var popup:ComboBoxList;

  }
}