package com.unhurdle.spectrum
{COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.events.ValueEvent;
  }
  //internal children - but needs the royale wrapper
  //getElementAt
  //override childrenAdded - call super.  create indicator there 

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

  override public function childrenAdded():void   
    {
      // super.childrenAdded();
        indicator = newElement('div');
        indicator.className = "spectrum-Tabs-selectionIndicator";
        var styleStr:String = "width: 27px; left: 0px;";
        indicator.setAttribute("style",styleStr);
        COMPILE::JS{
          element.appendChild(indicator); //not displaying although is there
        }
        window.addEventListener("resize",resized); //really -- should do this OR append indicator waste of time if doing both
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      addElementToWrapper(this,'div');
      element.classList.add("spectrum-Tabs--horizontal"); //there is a vertical option
      element.addEventListener("childrenAdded", childrenAdded); //maybe can go straight into resized cuz nx overriding anyway..

      return element;
    }

    public function overflow():void{
    // tabOverflow = new TabOverflow()
    }

    public function resized():void
    {
    // window.addEventListener("resize",resized);
    // if(sum+MLR  > wTG){
    // overflow()
    // }
    
    }









  }
}