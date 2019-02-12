package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.core.HTMLElementWrapper;
  import org.apache.royale.collections.IArrayList;
  import org.apache.royale.events.Event;
      import org.apache.royale.html.List;

  [Event(name="itemClicked", type="org.apache.royale.events.ValueEvent")]
  // [Event(name="overflow ", type="org.apache.royale.events.Event")]
  public class Tabs extends org.apache.royale.html.List
  {
   public function Tabs()
    {
      super();
      typeNames = getSelector();
    }

    public function getSelector():String{
      return "spectrum-Tabs";
    }

  private var _quiet:Boolean;
  private var _compact:Boolean;
  private var _vertical:Boolean;
  private var indicator:HTMLElement;
  public var tabArray:Array = [];
  
  public function get quiet():Boolean
  {
  	return _quiet;
  }
  COMPILE::JS
  public function set quiet(value:Boolean):void
  {
  	if(value != !!_quiet){
      element.classList.add("spectrum-Tabs--quiet");
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
  public function set vertical(value:Boolean):void //not necc smart....
  {
  	_vertical = value;
    if(value != !!_vertical){
      element.classList.replace("spectrum-Tabs--horizontal","spectrum-Tabs--vertical");
      _vertical = value;
    }
  }
   override public function set dataProvider(value:Object):void{
    super.dataProvider = value;
    tabArray = value as Array;
    // if(tabArray.length > 5 ){
    //   dispatchEvent( new Event("overflow") ); needs CJS?!
    // }
  }

  // public function get dataProvider():Object{
  //     return dataProvider;
  //   }
    
  // public function set dataProvider(value:Object):void{
  //     if(value is Array){
  //       convertArray(value);
  //     } else if(value is IArrayList){
  //       convertArray(value.source);
  //     }
  //     dataProvider = value;
  //   }
    // public native function getLabelFromData(obj:Object, data:Object):String
    
    // private function convertArray(value:Object):void{
    //   var newVal:Array;
    //   newVal = new Array(value.length);
    //   var len:int = value.length;
    //   for(var i:int = 0;i<len;i++){
    //     if(value[i] is TabsItem){
    //       continue;
    //     } else {
    //       var item:TabsItem = new TabsItem(getLabelFromData(this,value[i]));
          // if(value[i].hasOwnProperty("selected")){
          //   item.selected = value[i]["selected"];
          // }
          // if(value[i].hasOwnProperty("isDivider")){
          //   item.isDivider = value[i]["isDivider"];
          // }
          // if(value[i].hasOwnProperty("disabled")){
          //   item.disabled = value[i]["disabled"];
          // }
          // if(value[i].hasOwnProperty("isHeading")){
          //   item.isHeading = value[i]["isHeading"];
          // }
          // if(value[i].hasOwnProperty("icon")){
          //   item.icon = value[i]["icon"];
          // }
          // if(value[i].hasOwnProperty("subMenu")){
          //   item.subMenu = value[i]["subMenu"];
          // }
      //     value[i] = item;
      //   }
      // }
      // tabArray = value as Array;
    // if(tabArray.length > 5 ){
    //   dispatchEvent("overflow");
    // }
    // }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement //didnt yet set the too many attribute. needs a big func.
    {
      addElementToWrapper(this,'div');
      element.classList.add("spectrum-Tabs--horizontal");
      

      // indicator = newElement('div');
      // var styleStr:String = "height: 46px; top: 0px;"
      // indicator.setAttribute("style",styleStr);
      // element.appendChild(indicator);
    
      return element;
    }
  }
}