package com.unhurdle.spectrum
{
  import org.apache.royale.core.IChrome;

    COMPILE::JS
    {
    import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
    }

	public class THead extends Group implements IChrome
	{
		
		public function THead()
		{
			super();
			typeNames = 'spectrum-Table-head';
		}
		
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
			return addElementToWrapper(this, 'thead');
        }
    }
}