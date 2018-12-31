package com.unhurdle.spectrum
{
  /**
   * Using Object and bracket notation to prevent warnings in the Flash output
   */
  public function toggle(component:Object,selector:String,value:Boolean):void{
    component["element"]["classList"]["toggle"](selector, value);
  }
}