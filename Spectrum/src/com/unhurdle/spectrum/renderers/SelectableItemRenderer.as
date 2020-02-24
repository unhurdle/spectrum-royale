package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.core.Bead;
  import org.apache.royale.core.ISelectableItemRenderer;

  public class SelectableItemRenderer extends Bead implements ISelectableItemRenderer
  {
    public function SelectableItemRenderer()
    {
      
    }
    protected function get host():DataItemRenderer{
      return _strand as DataItemRenderer;
    }
    private var _hovered:Boolean;
    
    /**
     *  Whether or not the itemRenderer is in a hovered state.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.0
     */
    public function get hovered():Boolean
    {
        return _hovered;
    }
    public function set hovered(value:Boolean):void
    {
      _hovered = value;
    }
    
    private var _selected:Boolean;
    
    /**
     *  Whether or not the itemRenderer is in a selected state.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.0
     */
    public function get selected():Boolean
    {
        return _selected;
    }
    public function set selected(value:Boolean):void
    {
      _selected = value;
      host.toggle("is-selected",value);
    }

    private var _down:Boolean;
    
    /**
     *  Whether or not the itemRenderer is in a down (or pre-selected) state.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.0
     */
    public function get down():Boolean
    {
      return _down;
    }
    public function set down(value:Boolean):void
    {
      _down = value;
    }

  }
}