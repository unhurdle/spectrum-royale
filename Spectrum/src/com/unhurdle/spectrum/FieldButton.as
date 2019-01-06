package com.unhurdle.spectrum
{

  public class FieldButton extends Button
  {
    public function FieldButton()
    {
      super();
    }
    override public function set flavor(value:String):void{
      // no flavors. do nothing...
    }

    override protected function getSelector():String{
      return "spectrum-FieldButton";
    }

  }
}