package com.unhurdle.spectrum
{
  COMPILE::JS
  {
  import org.apache.royale.core.WrappedHTMLElement;
  import org.apache.royale.events.ValueEvent;
  import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.data.DropdownItem;
  import org.apache.royale.events.ValueEvent;
  import com.unhurdle.spectrum.renderers.MenuItemRenderer;
  import com.unhurdle.spectrum.utils.getDataProviderItem;
  

  [Event(name="children", type="org.apache.royale.events.Event")]
  public class TabOverflow extends Group
  {
    public function TabOverflow()
    {
      super();
      COMPILE::JS
      {
        addEventListener("tabs",tabsArray);
      }
      typeNames = getSelector() + " " + valueToSelector("horizontal");

    }
    override protected function getSelector():String
    {
      return getTabsSelector(); 
    }
    private var direction:String;
    private var dropDown:Picker;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement 
    { 
      addElementToWrapper(this,'div');
      //TODO why is this hard coded?
      width = 409;
      // var elemStyle:String = "width: 409px";
      // element.setAttribute("style",elemStyle);
      dropDown = new Picker();
      dropDown.quiet = true;
      addElement(dropDown);
      element.appendChild(dummySpacing());
      addIndicator();
      return element;
    }
    private var _dataProvider:Object;

    public function get dataProvider():Object
    {
    	return _dataProvider;
    }

    public function set dataProvider(value:Object):void{
       if(!value || _selectedIndex > value.length){
          _selectedIndex = -1;
        }
        dropDown.dataProvider = value;
        if(value && value.length){
          dropDown.visible = true;
          if(_selectedIndex > -1){
            selectedItem = getDataProviderItem(value,_selectedIndex);
          } else {
            selectedItem = getDataProviderItem(dropDown.dataProvider,0);
          }
        }
        else{
          dropDown.visible = false;
        }
    }

    private var _selectedIndex:int;

    public function get selectedIndex():int{
    	return _selectedIndex;
    }

    public function set selectedIndex(value:int):void{
      if(value == -1)
        selectedItem = null;
    	_selectedIndex = value;
      if(_selectedIndex > -1 && dataProvider)
      {
        selectedItem = getDataProviderItem(dropDown.dataProvider,0);
      }
    }

    public function get selectedItem():Object{
    	return dropDown.selectedItem;
    }

    public function set selectedItem(value:Object):void{
      if(dropDown.selectedItem != value){        
        dropDown.selectedItem = value;
        dropDown.handleListChange();
      }
    }    
    private function addIndicator():void
    { 
      COMPILE::JS
      {
      var indicator:TabIndicator = new TabIndicator();
      var styleStr:String = "width: 50px; left: 8px;";
      indicator.setAttribute("style",styleStr);
      addElement(indicator);
      }
    }

    private var _compact:Boolean;
    public function get compact():Boolean
    {
      return _compact;
    }
    
    public function set compact(value:Boolean):void 
    {
      if(value != !!_compact){
        COMPILE::JS{
          element.classList.add("spectrum-Tabs--compact");
        }
        _compact = value;
      }
    }

    COMPILE::JS
    private function dummySpacing():HTMLElement //what is this
    {
      var dummySpace:HTMLElement = newElement('div');
      dummySpace.className= "dummy-spacing";
      return dummySpace;
    }

    private var dpArray:Array = [];
    private var tabsForDp:Array = [];
    COMPILE::JS
    private function tabsArray(ev:ValueEvent):void
    {
      for(var i:int = 0;i<ev.value.length;i++){
        tabsForDp.push(ev.value[i]);
        var dpTab:Object = tabsForDp[i];
        placeHolder(dpTab);
        if(!dropDown.placeholder){
          dropDown.placeholder = (tabsForDp[0] as Object ).text;
          checkForDuplicateSelected(tabsForDp); 
          dpTab.selected = true;
        }
        dpTab = new DropdownItem(dpTab.text);
        addEventListener('click',checkForSelected);
        dpArray.push(dpTab); 
      }
      dropDown.dataProvider = dpArray;
    }

    private function placeHolder(tab:Object):void
    { 
      if(tab.selected){
        dropDown.placeholder = tab.text;
      }
    }
    private function checkForSelected(ev:Event):void
    {
      if((ev.target as MenuItemRenderer).selected){

        for(var i:int = 0;i<tabsForDp.length;i++){
          var tab:Object = tabsForDp[i];
          COMPILE::JS
          {
            if(tab.text == (ev.target as MenuItemRenderer).element.textContent){
              checkForDuplicateSelected(tabsForDp); 
              tab.selected = true;
            }
          }
        }
      }
    }
  

    private function checkForDuplicateSelected(tabsArray:Array):void
    {
      for(var i:int=0;i<tabsArray.length;i++){
        if(tabsArray[i].selected){
          tabsArray[i].selected = false;
          dpArray[i].selected = false;
          removeIndicator(tabsArray[i]);
          setIndicatorSpot(tabsArray[i]);
        }
      }
    }

    private function removeIndicator(tab:Tab):void
    {
      COMPILE::JS
      {
        for(var i:int = 0;i<tab.element.children.length;i++){
          if(tab.element.children[i].classList.contains("spectrum-Tabs-selectionIndicator")){
            tab.element.children[i].remove();
          }
        }
      }
    }
    private function setIndicatorSpot(tabBar:TabBar):void
    {
      COMPILE::JS
      {
        var newIndicator:TabIndicator = new TabIndicator();
        var styleStr:String;
        if(tabBar.vertical){
        styleStr = "height: 46px; top: 0px;";
        }else{
            styleStr = "width: 27px; left: 0px;";
        }
        newIndicator.setAttribute("style",styleStr);
        addElement(newIndicator);
      }
    }
  }
}