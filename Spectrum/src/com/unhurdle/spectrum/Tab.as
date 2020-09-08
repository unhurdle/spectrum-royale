package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
    import com.unhurdle.spectrum.const.IconPrefix;
    import org.apache.royale.events.Event;
    import com.unhurdle.spectrum.const.IconSize;
  

  public class Tab extends SpectrumBase
  {
    public function Tab()
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

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
    	_text = value;
      label.text = _text;
    }

    public function get iconType():String
    {
    	return _iconType;
    }

    public function set iconType(value:String):void
    {
      if(value){
        switch(value){
          case "Folder":
          case "Image":
          case "Filter":
          case "Comment":
            break;
          default:
            throw new Error("Invalid icon: " + value);
        }
      icon = new Icon(IconPrefix._18 + value); //allow the user to specify an icon..
      icon.size = IconSize.S;
      COMPILE::JS{
        element.insertBefore(icon.element, element.childNodes[0] || null);
      }
      icon.addedToParent(); 
      }
      _iconType = value;
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
          var tabSelected:Tab = ev.currentTarget as Tab;
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
            if(icon && text){
              styleStr = "width: 45px; left: 0px;";              
            }else{
              styleStr = "width: 27px; left: 0px;";
            }
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
      super.createElement();
      label = new TextNode("label");
      label.className = getTabsSelector() + "-itemLabel"; 
      element.appendChild(label.element); //addElem
      element.tabIndex = 0;
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
