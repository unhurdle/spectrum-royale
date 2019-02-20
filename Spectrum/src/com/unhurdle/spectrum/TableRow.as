package com.unhurdle.spectrum
{
  COMPILE::JS
	{
		import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
		
	}
  public class TableRow extends Group
  {
    public function TableRow()
    {
      super();
      typeNames = 'spectrum-Table-row';
    }

    COMPILE::JS
		override protected function createElement():WrappedHTMLElement
		{
			return addElementToWrapper(this, 'tr');
		}
  }
}