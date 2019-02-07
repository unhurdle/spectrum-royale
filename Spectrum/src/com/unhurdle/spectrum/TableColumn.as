package com.unhurdle.spectrum
{
  import org.apache.royale.html.supportClasses.DataGridColumn;

  public class TableColumn extends DataGridColumn
  {
    public function TableColumn()
    {
      super();
    }

    private var _align:String = ""

		public function get align():String
		{
			return _align;
		}

		public function set align(value:String):void
		{
			_align = value;
		}

		private var _columnLabelAlign:String = ""
	
		public function get columnLabelAlign():String
		{
			return _columnLabelAlign;
		}

		public function set columnLabelAlign(value:String):void
		{
			_columnLabelAlign = value;
		}
	}
}
