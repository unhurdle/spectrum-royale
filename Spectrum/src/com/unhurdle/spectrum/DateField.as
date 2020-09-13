package com.unhurdle.spectrum
{
  public class DateField extends TextField
  {
    public function DateField()
    {
      super();
      input.type = "date";
      input.step = "1";
    }

    private var _value:Date;

    public function get value():Date
    {
    	return new Date(input.value);
    }

    public function set value(value:Date):void
    {
    	input.value = ""+value;
    }
     public function get min():Date
    {
      return new Date(input.min);
    }

    public function set min(value:Date):void
    {
      input.min = ""+value;
    }
    public function get max():Date
    {
      return new Date(input.max);
    }

    public function set max(value:Date):void
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