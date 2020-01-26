package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import org.apache.royale.events.ValueEvent;
    
  
  [DefaultProperty("tabs")]
  public class TabBar extends Group
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/tabs/dist.css">
     * </inject_html>
     * 
     */
    public function TabBar()
    { 
      super();
    }

    private var _quiet:Boolean;
    private var _compact:Boolean;
    private var _vertical:Boolean = false;
    private var tabOverflow:TabOverflow; 
    private var tabWidth:Number;
    private var hasDropdown:Boolean;
    private var _tabs:Array;
    private var indicator:TabIndicator;
    private var count:int = 0;

    override protected function getSelector():String
    {
      return getTabsSelector(); 
    }

    override protected function appendSelector(value:String):String{
      return getSelector() + value;
    }

    // COMPILE::JS
    // override protected function computeFinalClassNames():String
    // {
    //   return element.className as String;
    // }
    
    public function get quiet():Boolean
    {
      return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(value != !!_quiet){
        toggle(valueToSelector("quiet"),value);
      }
      _quiet = value;
    }

    public function get compact():Boolean
    {
      return _compact;
    }
    
    public function set compact(value:Boolean):void 
    {
      
      if(value != !!_compact){
        toggle(valueToSelector("compact"),value);
      }
      _compact = value;
    }
    public function get vertical():Boolean
    {
      return _vertical;
    }

    public function set vertical(value:Boolean):void 
    {
      if(value != _vertical){
        toggle(valueToSelector("horizontal"),!value);
        toggle(valueToSelector("vertical"),value);
      }
      _vertical = value;
    }
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    { 
      addElementToWrapper(this,'div');
      window.addEventListener("resize",resized,false);
      return element;
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

  override public function addedToParent():void
  {
      super.addedToParent();
      toggle(valueToSelector("horizontal"),!_vertical);
      toggle(valueToSelector("vertical"),_vertical);
  }

    public function removeAllTabs():void
    {
      for(var i:Number= 0;i<tabs.length;i++){
        //TODO better way?
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
      tabOverflow.dispatchEvent(new ValueEvent("tabs", tabs));
    }
   
    public function get tabs():Array
    {
      return _tabs;
    }
    
    public function set tabs(value:Array):void
    {
      _tabs = value;
      for(var i:int=0;i<value.length;i++){
        addElement(value[i] as Tab);
      }
    }

    

    private function reAddTabs():void
    {
      if(hasDropdown){
        removeElement(tabOverflow);
        hasDropdown = false;
      for(var i:int=0;i<tabs.length;i++){
        addElement(tabs[i]);
      }
    }
  }
 
  private function checkForIndicator(tab:Tab):void
  {
    if(!tab.selected){
      count++;
    }
    else{
      if(tab.selected){
        //TODO so many places?
        indicator = new TabIndicator();
        var styleStr:String = "width: 27px; left: 0px;";
        indicator.setAttribute("style",styleStr);
        tab.addElement(indicator);
         
      }
    }
  }

  

    private function removeIndicator():void
    {
      COMPILE::JS
      {
        var elementsChildren:Object = element.children;
        for (var i:int = 0;i<elementsChildren.length;i++){
          //TODO better way to do this?
          if(elementsChildren[i].classList.contains("spectrum-Tabs-selectionIndicator")){
            elementsChildren[i].remove();
          }
        }
      }
    }

    private function addIndicator():void
    { 
      var indicator:TabIndicator = new TabIndicator();
      //TODO why is this hard coded?
      var styleStr:String = "width: 27px; left: 0px;";
      indicator.setAttribute("style",styleStr);
      addElement(indicator);
    
    }

  }
}
