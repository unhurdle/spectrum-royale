package com.unhurdle.spectrum
{
  
  COMPILE::JS
  {}
  public class StatusLight extends TextBase
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/statuslight/dist.css");
     * document.head.appendChild(link);
     * </inject_script>
     */

    public function StatusLight()
    {
      super();
    }
    override protected function getSelector():String{
        return "spectrum-StatusLight";
    }
    
    /**
     * The status can be either a <code>StatusColor</code> or <code>Status</code> specifier.
     * Default is <code>Status.NEUTRAL</code>.
     */
    private var _status:String;

    public function get status():String
    {
    	return _status;
    }

    public function set status(value:String):void
    {
      if(value != _status){
        if(_status){
          toggle(valueToSelector(_status), false);
        }
        if(!value){
          value = "neutral";
        }
        toggle(valueToSelector(value), true);

      	_status = value;
        
      }
    }
    private var _disabled:String;

    public function get disabled():String
    {
    	return _disabled;
    }

    public function set disabled(value:String):void
    {
      if(value != _disabled){
          toggle("is-disabled", value);
      }
      _disabled = value;
    }
  }
}
