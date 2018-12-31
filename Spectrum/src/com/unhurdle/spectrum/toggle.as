package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.HTMLElementWrapper;
  }

  /**
   * Using Object and bracket notation to prevent warnings in the Flash output
   */
  COMPILE::SWF
  public function toggle(component:Object,selector:String,value:Boolean):void{
    component["element"]["classList"]["toggle"](selector, value);
  }
  COMPILE::JS
  public function toggle(component:HTMLElementWrapper,selector:String,value:Boolean):void{
    component.element.classList.toggle(selector, value);
  }
  
}