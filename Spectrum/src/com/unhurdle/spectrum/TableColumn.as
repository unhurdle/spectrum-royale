package com.unhurdle.spectrum
{
  import org.apache.royale.html.supportClasses.DataGridColumn;

  public class TableColumn extends DataGridColumn
  {
    public function TableColumn()
    {
      super();
    }
		public var columnDividers:Boolean;
		public var sortable:Boolean;
		public var header:String;
		public var multiSelect:Boolean;
	}
}
