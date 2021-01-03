package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class CalendarDay extends SpectrumBase
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
      span.text = "" + value.getDate();
    	_date = value;
    }
    private var _isToday:Boolean;

    public function get isToday():Boolean
    {
    	return _isToday;
    }

    public function set isToday(value:Boolean):void
    {
      // if(value != !!_isToday){
        // if(value){
          toggle("is-today",value);
        //   (element as HTMLElement).classList.add("is-today");
        // } else {
        //   (element as HTMLElement).classList.remove("is-today");
        // }
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
        // if(value){
          toggle("is-focused",value);
        //   (element as HTMLElement).classList.add("is-focused");
        // } else {
        //   (element as HTMLElement).classList.remove("is-focused");
        // }
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
        // if(value){
          toggle("is-disabled",value);
          // (element as HTMLElement).classList.add("is-disabled");
        // } else {
          // if(className.includes(" is-disabled")){
          //   className = className.substr(className.indexOf(" is-disabled"),12);
          // }
          // (element as HTMLElement).classList.remove("is-disabled");
        // }
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
        // if(value){
          toggle("is-outsideMonth",value);
        //   (element as HTMLElement).classList.add("is-outsideMonth");
        // } else {
        //   (element as HTMLElement).classList.remove("is-outsideMonth");
        // }
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
      toggle("is-selected",value);
      // if(value){
      //   (element as HTMLElement).classList.add("is-selected");
      // } else {
      //   (element as HTMLElement).classList.remove("is-selected");
      // }
    	_selected = value;
    }

    public var firstInWeek:Boolean;
    public var lastInWeek:Boolean;
    public var firstInMonth:Boolean;
    public var lastInMonth:Boolean;
    private var atStart:Boolean;
    private var atEnd:Boolean;

    public function setRange(start:Date,end:Date):void{
      if(!_date || !start || !end)
      {
        return;
      }
      COMPILE::JS
      {
        atStart = false;
        atEnd = false;
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
          toggle(isSelectedClass,true);
          // className = isSelectedClass;
          toggleWeekStart(true);
          toggleWeekEnd(true);
          // }
          if(atStart && atEnd){
            // no range
            element.classList.remove(isRangeClass);
          } else {
            toggle(selectionStart,atStart);
            toggle(selectionEnd,atEnd);
            
            toggle(isRangeClass,true);
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
      if(!firstInWeek && !firstInMonth){
        return;
      }
      if(atStart){
        value = false;
      }
      _curWeekStart = value;
      toggle("is-range-start",value);
    }
    private var _curWeekEnd:Boolean = false;
    private function toggleWeekEnd(value:Boolean):void{
      if(!lastInWeek && !lastInMonth){
        return;
      }
      if(atEnd){
        value = false;
      }
      _curWeekEnd = value;
      toggle("is-range-end",value);
    }
    private var span:TextNode;

    override protected function getTag():String{
      return "span";
    }
    
    COMPILE::JS
    override protected function createElement():org.apache.royale.core.WrappedHTMLElement{
      super.createElement();
      element.setAttribute("role","presentation");
      span = new TextNode("");
      span.element = element;
      return element;
    }
  }
}