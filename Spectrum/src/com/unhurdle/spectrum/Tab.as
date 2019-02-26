package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.events.ValueEvent;
    import com.unhurdle.spectrum.const.IconPrefix;
    import com.unhurdle.spectrum.const.IconSize;
    import org.apache.royale.events.Event;
  

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
      addElement(icon); //really its there but the SVGIcon doesnt exist.. 
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
          element.classList.toggle("is-selected",value);
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
          // checkSelected(tabBar);
          setIndicatorSpot(tabBar);
          }
        }
      }
    }

    private function removeIndicator(tabBar:TabBar):void
    {
      COMPILE::JS
      {
        var barElements:Object = tabBar.element.children; 
        for(var i:int = 0;i<barElements.length;i++){
          var elem:Object = barElements[i]; 
          // for (var j:int = 0;j<tab.children.length;j++){
          //   var tabChildren:Object = tab.children[j];
            if(elem.classList.contains("spectrum-Tabs-selectionIndicator")){
              elem.remove();
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
        }
          else{
            styleStr = "width: 27px; left: 0px;";
          }
        newIndicator.element.setAttribute("style",styleStr);
        addElement(newIndicator);
      }
    }



  private function checkSelected(tabBar:TabBar):void
  { 
    COMPILE::JS
    {
      var tabs:Object = tabBar.tabs; 
      //tabBar.tabs = [] of tabs
      for(var i:int = 0;i<tabs.length;i++){
        var tab:Object = tabs[i]; 
        if(tab.selected){
          tab.selected == false;
        }
      for(var j:int = 0;j<tab.element.children.length;j++){
        var tabElem:Object = tab.element.children[j];
        if(tabElem.classList.contains("spectrum-Tabs-selectionIndicator")){
          tabElem.remove();
        }
      }  
        
      }
    }
  }
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    { 
      addElementToWrapper(this,'div');
      element.className = getSelector();
      label = new TextNode("label");
      label.className = appendSelector("Label"); //-- need this //class="spectrum-Tabs-itemLabel"
      element.appendChild(label.element); //addElem
      element.tabIndex = 0;
      return element;
    }


    
  }
}