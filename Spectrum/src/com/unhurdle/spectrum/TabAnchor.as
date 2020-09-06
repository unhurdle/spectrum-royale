package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
    import com.unhurdle.spectrum.const.IconPrefix;
    import org.apache.royale.events.Event;
  

  public class TabAnchor extends SpectrumBase
  {
    public function TabAnchor()
    {
      super();
      addEventListener('click',selectedTab);
    }
    override protected function getSelector():String{
      return getTabsSelector() + "-item";
    }
    private var label:TextNode;
    private var icon:Icon;
    private var _iconType:String;
    private var overflowButton:HTMLElement;
    private var overflowIcon:Icon;
    private var _text:String;
    private var _href:String;
    private var anchorElement:HTMLAnchorElement;

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
    	_text = value;
      label.text = _text;
    }

    public function get href():String
    {
    	return _href;
    }

    public function set href(value:String):void
    {
     if(value != _href){
      if(value){
      	_href = value;
      } else {
        _href = "#";
        }
        anchorElement.href = _href;
      }
    }

    private var _selected:Boolean;

    public function get selected():Boolean
    {
    	return _selected;
    }

    public function set selected(value:Boolean):void{ 
      COMPILE::JS
      {
        if(value){
          element.classList.add("is-selected");
          if (parent is TabBar)
          {
            var tabBar:TabBar = parent as TabBar;
            removeIndicator(tabBar);
            setIndicatorSpot(tabBar);
          }
        }
        else{
          element.classList.remove("is-selected");
        }
      _selected = value;   
      }
    }

    private function selectedTab(ev:Event):void
    { 
      COMPILE::JS
      {
        if(ev.currentTarget.parent){//no parent if overflow
          var tabSelected:TabAnchor = ev.currentTarget as TabAnchor;
          var tabBar:TabBar = ev.currentTarget.parent as TabBar; 
          checkSelected(tabBar);
          tabSelected.selected = true;

        if(tabSelected.selected == true){
          removeIndicator(tabBar);
          setIndicatorSpot(tabBar);
          }
        }
      }
    }

    override public function addedToParent():void
    {
      super.addedToParent();
      if (selected)
      {
        removeIndicator(parent as TabBar);
        setIndicatorSpot(parent as TabBar);
      }
    }

    private function removeIndicator(tabBar:TabBar):void
    {
      COMPILE::JS
      {
        var barElements:Object = tabBar.element.children; 
        for(var i:int = 0;i<barElements.length;i++){
          var elem:Object = barElements[i]; 
          //TODO better way to do this?
            if(elem.classList.contains(getTabsSelector() +"-selectionIndicator")){
              elem.remove();
            }
            checkTabs(elem);
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
        }
          else{
            styleStr = "width: 27px; left: 0px;";
          }
        newIndicator.setAttribute("style",styleStr);
        addElement(newIndicator);
      }
    }



  private function checkSelected(tabBar:TabBar):void
  { 
    COMPILE::JS
    {
      var tabs:Object = tabBar.tabs; 
      for(var i:int = 0;i<tabs.length;i++){
        var tab:Object = tabs[i]; 
        if(tab.selected){
          tab.selected = false;
          for(var j:int = 0;j<tab.element.children.length;j++){
            var tabElem:Object = tab.element.children[j];
            if(tabElem.classList.contains(getTabsSelector() + "-selectionIndicator")){
            tabElem.remove();
            }
          }
        }
      }
    }
  }
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    { 
      anchorElement = addElementToWrapper(this,'a') as HTMLAnchorElement;
      label = new TextNode("label");
      label.className = getTabsSelector() + "-itemLabel"; 
      label.element = anchorElement;
      return element;
    }


    

    private function checkTabs(elem:Object):void
    {
      for(var j:int = 0;j<elem.children.length;j++){
        var tabElem:Object = elem.children[j];
        if(tabElem.classList.contains( getTabsSelector() +"-selectionIndicator")){
        tabElem.remove();
        }
      }
    }
  }
}
