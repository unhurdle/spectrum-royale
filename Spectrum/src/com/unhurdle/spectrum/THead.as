package com.unhurdle.spectrum
{
  import org.apache.royale.core.IChrome;

    COMPILE::JS
    {
    import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
		import org.apache.royale.core.WrappedHTMLElement;
    }

	public class THead extends Group implements IChrome
	{
		
		public function THead()
		{
			super();
			typeNames = 'spectrum-Table-head';
		}

    
    

    COMPILE::JS
    private var elem:WrappedHTMLElement;
    COMPILE::SWF
		private var elem:Object;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      elem = addElementToWrapper(this,'thead');
      return elem;
    }
    }
}