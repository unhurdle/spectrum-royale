package com.unhurdle.spectrum
{
  import org.apache.royale.binding.ContainerDataBinding;

  public class Container extends Group
  {
    public function Container()
    {
      super();
			addBead(new ContainerDataBinding());
    }
  }
}