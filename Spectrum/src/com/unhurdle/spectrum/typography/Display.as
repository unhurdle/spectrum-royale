package com.unhurdle.spectrum.typography
{

  public class Display extends Heading
  {
    public function Display()
    {
      super();
      _size = 1;
    }

    override protected function getSelector():String{
      return getTypographySelector() + size + "--display " + getTypographySelector();
    }
    override public function set size(value:Number):void{
      if(value != _size){
        value = Math.min(value,2);
        value = Math.max(value,1);
        value = Math.round(value);
      	_size = value;
        setTypeNames();
      }
    }
  }
}