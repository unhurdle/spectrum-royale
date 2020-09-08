package com.unhurdle.spectrum
{
   COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  //TODO vertical is div while horizonatl is hr (hr styling is different)
  // Create VDivider and HDivider
  public class Divider extends SpectrumBase
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/divider/dist.css">
     * </inject_html>
     * 
     */
    public function Divider()
    {
      super();
      size = "medium";
    }
    override protected function getSelector():String{
      return "spectrum-Divider";
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      return addElementToWrapper(this,"hr");;
    }
    private var _vertical:Boolean;

    public function get vertical():Boolean
    {
    	return _vertical;
    }

    public function set vertical(value:Boolean):void
    {
      if(value != !!_vertical){
        toggle(valueToSelector("vertical"),value);
      }
    	_vertical = value;
    }
    
        private var _size:String;

        public function get size():String
        {
            return _size;
        }
        public function set size(value:String):void
        {
            if(value != _size){
                switch (value){
                  case "small":
                  case "medium":
                  case "large":
                      break;
                  default:
                      throw new Error("Invalid size: " + value);
                }
                if(_size){
                  toggle(valueToSelector(_size), false);
                }
                toggle(valueToSelector(value), true);
                _size = value;
            }
        }
  }
}