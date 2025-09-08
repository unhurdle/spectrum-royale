package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.events.MouseEvent;

  public class MultiTreeItemRenderer extends TreeItemRenderer
  {
    public function MultiTreeItemRenderer()
    {
      super();
    }
    override protected function handleChevronClick(ev:MouseEvent):void {
      // do nothing for multi select trees
    }
  }
}