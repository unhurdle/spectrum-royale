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
    private function toggleClassName(value:String):void{
      className = className? className:"";
      className += " " + value;
    }
    private var _isToday:Boolean;

    public function get isToday():Boolean
    {
    	return _isToday;
    }

    public function set isToday(value:Boolean):void
    {
      // if(value != !!_isToday){
        if(value){
          toggleClassName(" is-today");
        //   (element as HTMLElement).classList.add("is-today");
        // } else {
        //   (element as HTMLElement).classList.remove("is-today");
        }
      // }
    	_isToday = value;
    }
    private var _isFocused:Boolean;

    public function get isFocused():Boolean
    {
    	return _isFocused;
    }

    public function set isFocused(value:Boolean):void
    {
      // if(value != !!_isFocused){
        if(value){
          className = " is-focused";
        //   (element as HTMLElement).classList.add("is-focused");
        // } else {
        //   (element as HTMLElement).classList.remove("is-focused");
        }
      // }
    	_isFocused = value;
    }
    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      // if(value != !!_disabled){
        if(value){
          className = " is-disabled";
          // (element as HTMLElement).classList.add("is-disabled");
        // } else {
          // if(className.includes(" is-disabled")){
          //   className = className.substr(className.indexOf(" is-disabled"),12);
          // }
          // (element as HTMLElement).classList.remove("is-disabled");
        }
      // }
    	_disabled = value;
    }

    private var _isOutsideMonth:Boolean;

    public function get isOutsideMonth():Boolean
    {
    	return _isOutsideMonth;
    }

    public function set isOutsideMonth(value:Boolean):void
    {
      // if(value != !!_isOutsideMonth){
        if(value){
          className = " is-outsideMonth";
        //   (element as HTMLElement).classList.add("is-outsideMonth");
        // } else {
        //   (element as HTMLElement).classList.remove("is-outsideMonth");
        }
      // }
    	_isOutsideMonth = value;
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
        if(atStart || atEnd || between){          
          // element.classList.add(isSelectedClass);
          toggleClassName(isSelectedClass);
          // className = isSelectedClass;
          toggleWeekStart(true);
          toggleWeekEnd(true);
          // }
          if(atStart && atEnd){
            // no range
            element.classList.remove(isRangeClass);
          } else {
            if(atStart){
              // element.classList.add(selectionStart);
              toggleClassName(selectionStart);
              // className = selectionStart;
            } else if(atEnd){
              // element.classList.add(selectionEnd);
              toggleClassName(selectionEnd);
              // className = selectionEnd;
            }
            // have a range
            // element.classList.add(isRangeClass);
            toggleClassName(isRangeClass);
            // className = isRangeClass;
          }
        } else {
          toggleWeekStart(false);
          toggleWeekEnd(false);
          element.classList.remove(isSelectedClass);
          element.classList.remove(isRangeClass);
          // not selected
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