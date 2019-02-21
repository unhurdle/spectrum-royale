package com.unhurdle.spectrum
{
  import org.apache.royale.core.IChrome;
  COMPILE::JS
    {
    import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
    }

//doesnt really exist
	public class TFoot extends Group implements IChrome
	{
		public function TFoot()
		{
			super();

			// typeNames = '';
		}
		
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      return addElementToWrapper(this, 'tfoot');
    }
    }
}