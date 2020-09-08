package com.unhurdle.spectrum
{

	public class TBody extends Group
	{
		public function TBody()
		{
			super();

			typeNames = 'spectrum-Table-body';
		}
		
    override protected function getTag():String{
      return "tbody";
    }
  }
}