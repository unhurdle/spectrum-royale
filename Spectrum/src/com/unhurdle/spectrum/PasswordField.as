package com.unhurdle.spectrum
{
  public class PasswordField extends TextField
  {
    public function PasswordField()
    {
      super();
      input.type = "password";
    }

    public function get readonly():Boolean
    {
    	return input.readOnly;
    }

    public function set readonly(value:Boolean):void
    {
      input.readOnly = value;
    }

     public function get minlength():Number
    {
      return Number(input.min);
    }

    public function set minlength(value:Number):void
    {
      input.min = ""+value;
    }
    public function get maxlength():Number
    {
      return Number(input.max);
    }

    public function set maxlength(value:Number):void
    {
      input.max = "" + value;
    }
     public function get size():Number
    {
      return input.size;
    }

    public function set size(value:Number):void
    {
      input.size = value;
    }
  }
}