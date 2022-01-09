package com.unhurdle.spectrum
{
  /**
   * An HDivider is a styled hr element.
   * By default there's 0.5 em of space above and below.
   * If you want to collapse that space, set compact to true
   */
  public class HDivider extends Divider
  {
    public function HDivider()
    {
      super();
    }

    private var _compact:Boolean;

    /**
     * By default there's 0.5 em of space above and below.
     * If you want to collapse that space, set compact to true
     */
    public function get compact():Boolean
    {
    	return !!_compact;
    }

    public function set compact(value:Boolean):void
    {
      if(!!_compact != value){
        var val:* = value ? 0 : "";
        setStyle("marginTop",val);
        setStyle("marginBottom",val);
        _compact = value;
      }
    }
    override protected function getTag():String{
      return "hr";
    }
  }
}