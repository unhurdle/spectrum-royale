package com.unhurdle.spectrum
{
  public class ButtonGroup extends Group
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/buttongroup/dist.css");
     * document.head.appendChild(link);
     * </inject_script>
     */

    public function ButtonGroup()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-ButtonGroup";
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
  }
}