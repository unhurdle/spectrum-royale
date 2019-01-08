package com.unhurdle.spectrum
{
  public class NumberField extends TextField
  {
    public function NumberField()
    {
      super();
    }

    private var _value:Number;

    public function get value():Number
    {
    	return Number(input.text);
    }

    public function set value(value:Number):void
    {
    	input.text = ""+value;
    }
     public function get min():Number
    {
      return Number(input.min);
    }

    public function set min(value:Number):void
    {
      input.min = ""+value;
    }
    public function get max():Number
    {
      return Number(input.max);
    }

    public function set max(value:Number):void
    {
      input.max = "" + value;
    }
     public function get step():Number
    {
      return Number(input.step);
    }

    public function set step(value:Number):void
    {
      input.step = "" + value;
    }
  }
}