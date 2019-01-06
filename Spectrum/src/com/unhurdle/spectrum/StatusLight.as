package com.unhurdle.spectrum
{
  
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  public class StatusLight extends SpectrumBase
  {
    public function StatusLight()
    {
      super();
      typeNames = "spectrum-StatusLight";
    }
    override protected function createElement():WrappedHTMLElement{
        addElementToWrapper(this,'div');
        return element;
    }
    private var _changeStatus:String;

    public function get changeStatus():String
    {
    	return _changeStatus;
    }

    public function set changeStatus(value:String):void
    {
    	if(value != _changeStatus){
                var newColor:String = valueToCSS(value);
                toggle(newColor, true);
                if(_changeStatus){
                    var oldColor:String = valueToCSS(_changeStatus);
                    toggle(oldColor, false);
                }
                _changeStatus = value;
            }
    }
        private function valueToCSS(value:String):String{
            return "spectrum-StatusLight--" + value;
        }
  }
}