package com.unhurdle.spectrum
{
  import org.apache.royale.core.IChild;

  public class ButtonGroup extends Group
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/buttongroup/dist.css">
     * </inject_html>
     * 
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
    private var _compact:Boolean;
    /**
     * compact button groups do not add spacing between buttons
     */
    public function get compact():Boolean
    {
    	return _compact;
    }

    public function set compact(value:Boolean):void
    {
    	_compact = value;
    }

    // button group children need item selectors
    override public function addElement(c:org.apache.royale.core.IChild, dispatchEvent:Boolean = true):void{
      super.addElement(c,dispatchEvent);
      appendItemSelector(c);
    }
    override public function addElementAt(c:org.apache.royale.core.IChild, index:int, dispatchEvent:Boolean = true):void{
      super.addElementAt(c,index,dispatchEvent);
      appendItemSelector(c);
    }
    override public function removeElement(c:org.apache.royale.core.IChild, dispatchEvent:Boolean = true):void{
      super.removeElement(c,dispatchEvent);
      appendItemSelector(c);
    }
    /**
     * @royaleemitcoercion com.unhurdle.spectrum.ISpectrumElement
     */
    private function appendItemSelector(c:org.apache.royale.core.IChild):void{
      if(!compact){
        var spectrumItem:ISpectrumElement = c as ISpectrumElement;
        if(spectrumItem){
          spectrumItem.toggle(appendSelector("-item"),false);
        }
      }
    }
  }
}