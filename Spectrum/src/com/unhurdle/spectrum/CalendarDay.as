package com.unhurdle.spectrum
{
  import org.apache.royale.html.elements.Span;
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class CalendarDay extends Span
  {
    public function CalendarDay()
    {
      super();
      typeNames = "spectrum-Calendar-date";
    }
    private var _date:Date;

    public function get date():Date
    {
    	return _date;
    }

    public function set date(value:Date):void
    {
      text = "" + value.getDate();
    	_date = value;
    }
    private var _isToday:Boolean;

    public function get isToday():Boolean
    {
    	return _isToday;
    }

    public function set isToday(value:Boolean):void
    {
      if(value != !!_isToday){
        if(value){
          (element as HTMLElement).classList.add("is-today");
        } else {
          (element as HTMLElement).classList.remove("is-today");
        }
      }
    	_isToday = value;
    }

    private var _selected:Boolean;

    public function get selected():Boolean
    {
    	return _selected;
    }

    public function set selected(value:Boolean):void
    {
      if(value){
        (element as HTMLElement).classList.add("is-selected");
      } else {
        (element as HTMLElement).classList.remove("is-selected");
      }
    	_selected = value;
    }

    public var firstInWeek:Boolean;
    public var lastInWeek:Boolean;

    public function setRange(start:Date,end:Date):void{
      if(!_date || !start || !end)
      {
        return;
      }
      COMPILE::JS
      {
        var atStart:Boolean;
        var atEnd:Boolean;
        var between:Boolean;
        var selectionStart:String = "is-selection-start";
        var selectionEnd:String = "is-selection-end";
        element.classList.remove(selectionStart);
        element.classList.remove(selectionEnd);
        if(_date.toDateString() == start.toDateString()){
          atStart = true;
        } 
        if(_date.toDateString() == end.toDateString()){
          atEnd = true;
        }
        if(!atStart && !atEnd) {
          var time:Number = _date.getTime();
          if(time > start.getTime() && time < end.getTime()){
            between = true;
          }
        }
        var isSelectedClass:String = "is-selected";
        var isRangeClass:String = "is-range-selection";
        if(!atStart && !atEnd && !between){
          toggleWeekStart(false);
          toggleWeekEnd(false);
          element.classList.remove(isSelectedClass);
          element.classList.remove(isRangeClass);
          // not selected
        } else {
          element.classList.add(isSelectedClass);
          toggleWeekStart(true);
          toggleWeekEnd(true);
        }
        if(atStart && atEnd){
          // no range
          element.classList.remove(isRangeClass);
        } else {
          // have a range
          element.classList.add(isRangeClass);
          if(atStart){
            element.classList.add(selectionStart);
          } else if(atEnd){
            element.classList.add(selectionEnd);
          }
        }
      }

    }
    private var _curWeekStart:Boolean = false;
    private function toggleWeekStart(value:Boolean):void{
      if(!firstInWeek){
        return;
      }
      if(value != _curWeekStart){
        _curWeekStart = (element as HTMLElement).classList.toggle("is-range-start");
      }
    }
    private var _curWeekEnd:Boolean = false;
    private function toggleWeekEnd(value:Boolean):void{
      if(!lastInWeek){
        return;
      }
      if(value != _curWeekEnd){
        _curWeekEnd = (element as HTMLElement).classList.toggle("is-range-end");
      }
    }

    COMPILE::JS
    override protected function createElement():org.apache.royale.core.WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      elem.setAttribute("role","presentation");
      // elem.className = "spectrum-Calendar-date";
      
      return elem;
    }
  }
}