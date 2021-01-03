package com.unhurdle.spectrum
{
  public class TabIndicator extends SpectrumBase
  {
    public function TabIndicator()
    {
      super();
      typeNames = getSelector();
    }

    override protected function getSelector():String{
      return getTabsSelector() + "-selectionIndicator";
    }
    
  }
}