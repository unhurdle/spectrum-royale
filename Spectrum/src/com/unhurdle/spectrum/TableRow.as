package com.unhurdle.spectrum
{
  public class TableRow extends Group
  {
    public function TableRow()
    {
      super();
      typeNames = 'spectrum-Table-row';
    }

    override protected function getTag():String{
      return "tr";
    }

  }
}