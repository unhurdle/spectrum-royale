package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.events.ValueEvent;
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.textLayout.edit.ElementMark;
  }

  [DefaultProperty("tabs")]
  public class TabBar extends Group
  {
    public function TabBar()
    {
      super();
    }

    override protected function getSelector():String{
      return "spectrum-Tabs" ;
    }
    private var _quiet:Boolean;
    private var _compact:Boolean;
    private var _vertical:Boolean;
    private var indicator:HTMLElement;
    public var tabArray:Array = [];
    
    public var tabOverflow:TabOverflow;
    public function get quiet():Boolean
    {
      return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(value != !!_quiet){
        toggle(valueToSelector("quiet"),value);
        _quiet = value;
        }
    }
    public function get compact():Boolean
    {
      return _compact;
    }
    
    COMPILE::JS
    public function set compact(value:Boolean):void //how can we tell the user thats its nx allowed unless they are using the quiet attribute?
    {
      if(value != !!_compact && quiet){ //compact can only be set if tabs are quiet
      element.classList.add("spectrum-Tabs--compact");
      _compact = value;
        }
    }
    public function get vertical():Boolean
    {
      return _vertical;
    }
    COMPILE::JS
    public function set vertical(value:Boolean):void 
    {
      _vertical = value;
      if(value != !!_vertical){
        element.classList.replace("spectrum-Tabs--horizontal","spectrum-Tabs--vertical");
        _vertical = value;
      }
    }


    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      addElementToWrapper(this,'div');
      element.classList.add("spectrum-Tabs--horizontal"); 
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
      hasDropdown = true;
      COMPILE::JS{
       tabOverflow.dispatchEvent(new ValueEvent("tabs", tabs));
      }
      
     

    }
   
    private var _tabs:Array;

    public function get tabs():Array
    {
      return _tabs;
    }

    public function set tabs(value:Array):void
    {
   
      _tabs = value;
      for(var i:int=0;i<value.length;i++){
        COMPILE::JS{
          element.appendChild(value[i].element); 
        }
        
        
        }
        indicator = newElement('div');
        indicator.className = "spectrum-Tabs-selectionIndicator";
        var styleStr:String = "width: 27px; left: 0px;";
        indicator.setAttribute("style",styleStr);
        COMPILE::JS{
          element.appendChild(indicator); 
        }
      }

    private var tabWidth:Number;
    private var hasDropdown:Boolean;

    private function reAddTabs():void{
      if(hasDropdown){
        removeElement(tabOverflow);
        hasDropdown = false;
        for(var i:int=0;i<tabs.length;i++){
          addElement(tabs[i]);
        }
      }
    }

    private function resized():void
    {
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
      } else {
        reAddTabs();
      }
    }
  }
}



























