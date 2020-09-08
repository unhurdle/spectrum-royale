package com.unhurdle.spectrum
{

    COMPILE::JS
    {
    import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
		import org.apache.royale.core.WrappedHTMLElement;
    }

	// public class THead extends Group implements IChrome
	public class THead extends Group
	{
		
		public function THead()
		{
			super();
			typeNames = 'spectrum-Table-head';
		}

    override protected function getTag():String{
      return "thead";
    }
  }
}