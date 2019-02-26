package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.events.ValueEvent;
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.UIBase;
    import org.apache.royale.core.CSSClassList;
  }
    
  
  [DefaultProperty("tabs")]
  public class TabBar extends Group
  {
    public function TabBar()
    { 
      super();
    }
    
    override protected function getSelector():String
    {
      return getTabsSelector() + direction; //direction
    }

    override protected function appendSelector(value:String):String{
      return getSelector() + value;
    }
    
    private var _quiet:Boolean;
    private var _compact:Boolean;
    private var _vertical:Boolean;
    private var tabOverflow:TabOverflow; //changed from public //test it
    private var tabWidth:Number;
    private var hasDropdown:Boolean;
    private var direction:String;
    private var _tabs:Array;

    public function get quiet():Boolean
    {
      return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(value != !!_quiet){
        COMPILE::JS
        {
          element.classList.add("spectrum-Tabs--quiet");
        }
        
      }
      _quiet = value;
    }

    public function get compact():Boolean
    {
      return _compact;
    }
    
    public function set compact(value:Boolean):void 
    {
      
      if(value != !!_compact && !quiet){ 
        COMPILE::JS
        {
          element.classList.add("spectrum-Tabs--compact");
          element.classList.add("spectrum-Tabs--quiet");
        }
      }

      if(value != !!_compact && quiet){
        COMPILE::JS
        {
          element.classList.add("spectrum-Tabs--compact");
        }
      }
      _compact = value;
    }
    public function get vertical():Boolean
    {
      return _vertical;
    }

    public function set vertical(value:Boolean):void 
    {
      if(value == true){
        COMPILE::JS
        {
        direction = " spectrum-Tabs--vertical";
        element.classList.remove("spectrum-Tabs--horizontal");
        element.className = appendSelector("");
        }
      }
      _vertical = value;
    }
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    { 
      addElementToWrapper(this,'div');
      direction = " spectrum-Tabs--horizontal";
      element.className = appendSelector("");
      window.addEventListener("resize",resized,false);
      return element;
    }                                                                                                                                                   

    public function removeAllTabs():void
    {
      for(var i:Number= 0;i<tabs.length;i++){
        COMPILE::JS
        {
          element.removeChild(tabs[i].element);
        }
      }
    }
  
    public function collapseTabs():void
    {
      if(hasDropdown){
        return;
      }
      removeAllTabs();
      tabOverflow = new TabOverflow();
      addElement(tabOverflow);
      removeIndicator();
      hasDropdown = true;
      COMPILE::JS{
        tabOverflow.dispatchEvent(new ValueEvent("tabs", tabs));
      }
    }
   
    public function get tabs():Array
    {
      return _tabs;
    }
    private var indicator:TabIndicator;
    public function set tabs(value:Array):void
    {
      _tabs = value;
      for(var i:int=0;i<value.length;i++){
        addElement(value[i] as Tab);
      }
      indicator=new TabIndicator();
      var styleStr:String;
      if(!vertical == true){
        styleStr = "width: 27px; left: 0px;";
      }
      else{
        styleStr = "height: 46px; top: 0px;";
      }
      COMPILE::JS
      {
      indicator.element.setAttribute("style",styleStr);
      }
      addElement(indicator);
    }

    COMPILE::JS
    override protected function computeFinalClassNames():String
    {
      return element.className as String;
    }

    private function reAddTabs():void
    {
      if(hasDropdown){
        removeElement(tabOverflow);
        hasDropdown = false;
        count = 0;

        for(var i:int=0;i<tabs.length;i++){
          addElement(tabs[i]);
          checkForIndicator(tabs[i]);
          if(count == tabs.length){
            addIndicator();
            
          }
        }
      }
    }
  private var count:int = 0;
  private function checkForIndicator(tab:Object):void
  {
    if(!tab.selected){
      count++;
    }
  }
    private function resized():void
    {
      if(!vertical == true){
      var elem:HTMLElement = element as HTMLElement;
      var barWidth:Number = elem.getBoundingClientRect().width;  
      var barPadding:Number = elem.style.padding as Number; //doesnt HAVE padding.
      if(barPadding){
        var barResult:Number = (barWidth - barPadding);
        barWidth = barResult;
      }
      if(isNaN(tabWidth)){
        tabWidth = 0;
        for(var i:Number=0;i<tabs.length;i++){
          var child:HTMLElement = tabs[i].element;
          tabWidth += child.getBoundingClientRect().width; 
          if(child.style.marginLeft && child.style.marginRight){ 
            tabWidth += (child.style.marginLeft as Number);
            tabWidth += (child.style.marginRight as Number);
          }
        }
      }
      if(tabWidth > barWidth){
        collapseTabs();
      } 
        else {
          reAddTabs();
        }
      }
    }



    private function removeIndicator():void
    {
      COMPILE::JS
      {
        var elementsChildren:Object = element.children;
        for (var i:int = 0;i<elementsChildren.length;i++){
          if(elementsChildren[i].classList.contains("spectrum-Tabs-selectionIndicator")){
            elementsChildren[i].remove();
          }
        }
      }
    }

    private function addIndicator():void
    { 
      COMPILE::JS
      {
      var indicator:TabIndicator = new TabIndicator();
      var styleStr:String = "width: 27px; left: 0px;";
      indicator.element.setAttribute("style",styleStr);
      addElement(indicator);
      }
    }

    
  }
}