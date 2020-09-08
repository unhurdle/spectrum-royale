package com.unhurdle.spectrum
{
  import org.apache.royale.core.IChrome;

//doesnt really exist
	public class TFoot extends Group implements IChrome
	{
		public function TFoot()
		{
			super();

			// typeNames = '';
		}
		
    override protected function getTag():String{
      return "tfoot";
    }
  }
}