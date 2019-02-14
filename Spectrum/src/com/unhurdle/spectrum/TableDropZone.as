package com.unhurdle.spectrum
{
  COMPILE::JS{
  import org.apache.royale.html.util.addElementToWrapper;
  import org.apache.royale.core.WrappedHTMLElement;
  }
  public class TableDropZone extends SpectrumBase
  {
    // <div class="spectrum-Table-body is-drop-target" style="height: 120px" role="rowgroup">
    //       <div class="spectrum-Table-row" style="display: flex" role="row">
    //         <div class="spectrum-Table-cell" style="flex: 1" role="gridcell">Row Item Alpha</div>
    //         <div class="spectrum-Table-cell" style="flex: 1" role="gridcell">Row Item Alpha</div>
    //         <div class="spectrum-Table-cell" style="flex: 1" role="gridcell">Row Item Alpha</div>
    // </div> //whole tbody

    // <div class="spectrum-Table-body" style="height: 120px" role="rowgroup">
    //           <div class="spectrum-Table-row is-drop-target" style="display: flex" role="row">
    //           <div class="spectrum-Table-cell" style="flex: 1" role="gridcell">Row Item Alpha</div>
    //           <div class="spectrum-Table-cell" style="flex: 1" role="gridcell">Row Item Alpha</div>
    //           <div class="spectrum-Table-cell" style="flex: 1" role="gridcell">Row Item Alpha</div>
    // </div> //just the row
    public function TableDropZone() 
    {
      super();
      // typeNames = ''
    }

     override protected function createElement():WrappedHTMLElement{
       return element;
     }
  }
}