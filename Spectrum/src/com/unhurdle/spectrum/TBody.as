package com.unhurdle.spectrum
{
    COMPILE::JS
    {
    import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
    }

	public class TBody extends Group
	{
		public function TBody()
		{
			super();

			typeNames = 'spectrum-Table-body';
		}
		
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      return addElementToWrapper(this, 'tbody');
    }
    }
}