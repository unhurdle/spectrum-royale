package com.unhurdle.spectrum
{
  import org.apache.royale.core.View;
  import org.apache.royale.html.beads.layouts.VerticalFlexLayout;

  public class View extends org.apache.royale.core.View
  {
    public function View()
    {
      super();
      addBead(new VerticalFlexLayout());
    }
  }
}