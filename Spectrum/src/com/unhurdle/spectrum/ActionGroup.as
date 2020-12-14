package com.unhurdle.spectrum
{
  import org.apache.royale.core.IChild;
  import com.unhurdle.spectrum.const.IconType;
  import com.unhurdle.spectrum.includes.ActionButtonInclude;

  public class ActionGroup extends Group
  {
    
    public function ActionGroup()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-ActionGroup";
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

    private var _horizontal:Boolean;

    public function get horizontal():Boolean
    {
    	return _horizontal;
    }

    public function set horizontal(value:Boolean):void
    {
      if(value != !!_horizontal){
        toggle(valueToSelector("horizontal"),value);
      }
    	_horizontal = value;
    }

    private var _justified:Boolean;

    public function get justified():Boolean
    {
    	return _justified;
    }

    public function set justified(value:Boolean):void
    {
      if(value != !!_justified){
        toggle(valueToSelector("justified"),value);
      }
    	_justified = value;
    }

    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(_quiet != value){
        toggle(valueToSelector("quiet"),value);
      }
    	_quiet = value;
    }

    private var _compact:Boolean;

    public function get compact():Boolean
    {
    	return _compact;
    }

    public function set compact(value:Boolean):void
    {
      if(value != !!_compact){
        toggle(valueToSelector("compact"),value);
      }
    	_compact = value;
    }
    
    // button group children need item selectors
    override public function addElement(c:org.apache.royale.core.IChild, dispatchEvent:Boolean = true):void{
      super.addElement(c,dispatchEvent);
      appendItemSelector(c,true);
    }
    override public function addElementAt(c:org.apache.royale.core.IChild, index:int, dispatchEvent:Boolean = true):void{
      super.addElementAt(c,index,dispatchEvent);
      appendItemSelector(c,true);
    }
    override public function removeElement(c:org.apache.royale.core.IChild, dispatchEvent:Boolean = true):void{
      super.removeElement(c,dispatchEvent);
      appendItemSelector(c,false);
    }
    /**
     * @royaleemitcoercion com.unhurdle.spectrum.ISpectrumElement
     */
    private function appendItemSelector(c:org.apache.royale.core.IChild,add:Boolean):void{
      var spectrumItem:ISpectrumElement = c as ISpectrumElement;
      if(spectrumItem){
        spectrumItem.toggle(appendSelector("-item"),add);
        if(quiet){
          if(add){
            spectrumItem.toggle(ActionButtonInclude.getSelector() + "--quiet",add);
          } else {
            if((!spectrumItem is ActionButton) || !(spectrumItem as ActionButton).quiet){
              spectrumItem.toggle(ActionButtonInclude.getSelector() + "--quiet",add);
            }
          }
        }
      }
    }
  }
}