package com.unhurdle.spectrum.typography
{

  public class Heading extends Typography
  {
    public function Heading()
    {
      super();
    }
    // override protected function getSuffix():Array{
    //   var suffix:Array = [];
    //   if(size == 1 || size == 2){
    //     if(quiet){
    //       suffix.push("--quiet");
    //     } else if(strong){
    //       suffix.push("--strong");
    //     }
    //     if(display){
    //       suffix.push("--display");
    //     }
    //   }
    //   return suffix;
    // }

    private var _quiet:Boolean;

    /**
     * The quiet varient of Heading1 or Heading2
     */
    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      light = value;
      // if(value != !!_quiet){
      //   _strong = false;
      // 	_quiet = value;
      //   setTypeNames();
      // }
    }
    private var _strong:Boolean;

    /**
     * The strong varient of Heading1 or Heading2
     */
    public function get strong():Boolean
    {
    	return _strong;
    }

    public function set strong(value:Boolean):void
    {
      heavy = value;
      // if(value != !!_strong){
      // 	_strong = value;
      //   _quiet = false;
      //   setTypeNames();
      // }
    }
    // private var _display:Boolean;

    /**
     * The display varient of Heading1 or Heading2
     */
    public function get display():Boolean
    {
    	return size.includes('XXL');
    }

    public function set display(value:Boolean):void
    {
      if(value){
        if(size.includes('L')){
          if(size.split('X').length <= 2){
            size = 'XX'.concat(size);
          }
        }
      }else{
        if(size.includes('XXL')){
          size = size.replace('XX','');
        }
      }
    }
    private var _heavy:Boolean;

    public function get heavy():Boolean
    {
    	return _heavy;
    }

    public function set heavy(value:Boolean):void
    {
      if(value != !!_heavy){
        toggle(valueToSelector("heavy"),value);
      }
      if(value){
        light = false;
      }
      _heavy = value;
    }
    private var _light:Boolean;

    public function get light():Boolean
    {
    	return _light;
    }

    public function set light(value:Boolean):void
    {
      if(value != !!_light){
        toggle(valueToSelector("light"),value);
      }
      if(value){
        heavy = false;
      }
      _light = value;
    }

    override protected function getTypographySelector():String{
      return "spectrum-Heading";
    }

  }
}