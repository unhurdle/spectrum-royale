package com.unhurdle.spectrum
{
  import org.apache.royale.core.View;
  import org.apache.royale.html.beads.layouts.NoLayout;
  import org.apache.royale.binding.ViewDataBinding;

  public class View extends org.apache.royale.core.View
  {
    public function View()
    {
      super();
      addBead(new NoLayout());
      addBead(new ViewDataBinding());
    }
  }
}