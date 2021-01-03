package com.unhurdle.spectrum
{

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