package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.model.DatePickerModel;

  import org.apache.royale.events.Event;
  import org.apache.royale.svg.elements.Path;
  import com.unhurdle.spectrum.includes.InputGroupInclude;
  import org.apache.royale.geom.Rectangle;
  import org.apache.royale.utils.DisplayUtils;
  import org.apache.royale.html.elements.Div;
  import org.apache.royale.events.MouseEvent;

  public class DatePicker extends SpectrumBase
  {
    public function DatePicker()
    {
      super();
      typeNames = getSelector();
    }
    override protected function getSelector():String{
      return "spectrum-Datepicker";
    }
    private function appendDatePicker(value:String):String{
      return getSelector() + value;
    }

    private function appendInputGroup(value:String):String{
      return InputGroupInclude.getSelector() + value;
    }

    private var input:TextField;
    private var input2:TextField;
    private var button:FieldButton;
    private var datePicker:HTMLInputElement;
    
    public var dateFormat:String = "mm/dd/yyyy";
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      //TODO how much of this can be done in Icons and other classes?
      super.createElement();
      //TODO is this right?
      className = InputGroupInclude.getSelector();
      input = new TextField();
      input.tabFocusable = false;
      input.toggle(appendInputGroup("-textfield"),true);
      input.input.classList.add(appendInputGroup('-input'));
      // input.readOnly = true;
      button = new FieldButton()
      button.className = appendInputGroup("-button");
      // button.onclick = openDatePicker;
      button.addEventListener("click",toggleButton);

      datePicker = newElement("input") as HTMLInputElement;
      datePicker.type = "hidden";
      
      var svgElement:SVGIcon = new SVGIcon();
      svgElement.setAttribute("viewBox","0 0 36 36");
      svgElement.setAttribute("role","img");
      
      var path:Path = new Path();
      path.d = "M33 6h-5V3a1 1 0 0 0-1-1h-2a1 1 0 0 0-1 1v3H10V3a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1v3H1a1 1 0 0 0-1 1v26a1 1 0 0 0 1 1h32a1 1 0 0 0 1-1V7a1 1 0 0 0-1-1zm-1 26H2V8h4v1a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1V8h14v1a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1V8h4z";
      svgElement.addElement(path);

      path = new Path();
      path.d = "M6 12h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4zM6 18h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4zM6 24h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4z";
      svgElement.addElement(path);
      button.iconElement = svgElement;
      addElement(input);
      addElement(button);
      element.appendChild(datePicker); 

      popover = new Popover();
      popover.floating = true;
      // popover.className = appendSelector("-popover");
      popover.position = "bottom";
      // popover.percentWidth = 100;
      calendar = new Calendar();
      popover.addElement(calendar);

      return element;
    }
    protected function handleControlMouseDown(event:MouseEvent):void
		{			
			event.stopImmediatePropagation();
		}
    private function handleTopMostEventDispatcherMouseDown():void
    {
      closePopover();
    }
    private var calendar:Calendar;
    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
    	if(_quiet != !!value){
        toggle(appendInputGroup("--quiet"),value);
        input.quiet = value;
        button.quiet = value;
        if(input2){
          input2.quiet = value;
        }
      }
      _quiet = value;
    }
    private var _invalid:Boolean;

    public function get invalid():Boolean
    {
    	return _invalid;
    }

    public function set invalid(value:Boolean):void
    {
      if(value != !!_invalid){
        toggle("is-invalid",value);
        if(input2){
          input2.invalid = value;
        } else {
          input.invalid = value;
        }
        button.invalid = value;
      }
    	_invalid = value;
    }
    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      if(value != !!_disabled){
        toggle("is-disabled",value);
        input.disabled = value;
        button.disabled = value;
        if(input2){
          input2.disabled = value;
        }
      }
    	_disabled = value;
    }
    private function toggleButton():void{
      if(!popover.open){
        openPopover()
      } else{
        closePopover();
      }
      
    }
    private function openPopover():void
    {
      button.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
      popover.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
      topMostEventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
      popover.open = true;
      button.selected = true;
      var componentBounds:Rectangle = DisplayUtils.getScreenBoundingRect(this);
      popover.y = componentBounds.bottom;
      popover.x = componentBounds.left;
      calendar.startDate = startDate;
      calendar.endDate = endDate;
      calendar.selectRange(startDate,endDate);
    }
    private function closePopover():void
    {
      button.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
      popover.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
      topMostEventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
      popover.open = false;
      button.selected = false;
    }
    public function get placeHolder():String
    {
    	return input.placeholder;
    }

    public function set placeHolder(value:String):void
    {
    	input.placeholder = value;
    }
     public function get text():String
    {
    	return input.text;
    }

    public function set text(value:String):void
    {
    	input.text = value;
    }
    public var popover:Popover
    // COMPILE::JS
    // private function openDatePicker():void{
    //   popover.open = true;
    // }
    private function handleSelectedDay(ev:*):void{
      closePopover();
      dispatchEvent(new Event("selectedDateChanged"));
      var date:Date = ev.target.selectedDate;

      var year:String = date.getFullYear().toString();

      var month:String = (1 + date.getMonth()).toString();
      month = month.length > 1 ? month : '0' + month;

      var day:String = date.getDate().toString();
      day = day.length > 1 ? day : '0' + day;
      //TODO international formatting
      input.text = month + '/' + day + '/' +  year;
    }
    override public function addedToParent():void{
      super.addedToParent();
      model = calendar.model;
      (model as DatePickerModel).addEventListener("selectedDateChanged",handleSelectedDay);
      if(range){
        input.input.classList.add(appendDatePicker("-startField"),true);
        input.placeholder = dateFormat;
        // add dash
        var div:Div = new Div();
        div.className = appendSelector("-rangeDash");
        addElementAt(div,1);
        // add second field
        input2 = new TextField();
        input2.toggle(appendInputGroup("-textfield"),true);
        input2.input.classList.add(appendInputGroup('-input'));
        input2.input.classList.add(appendDatePicker("-endField"));
        input2.placeholder = dateFormat;
        if(datetimeRange){
          input.placeholder +=" hh:mm a";
          input2.placeholder +=" hh:mm a";
        }
        if(invalid){
          input2.invalid = true;
          input.invalid = false;
          input.toggle("is-invalid",true);
        }
        input2.quiet = quiet;
        input2.disabled = disabled;
        addElementAt(input2,2);
        var focusRing:Div = new Div();
        focusRing.className = appendDatePicker("-focusRing");
        focusRing.setAttribute("role","presentation");
        addElement(focusRing);
      }

			// loadBeadFromValuesManager(IFormatter, "IFormatter", this);
			// var formatter:IFormatter = getBeadByType(IFormatter) as IFormatter;
			// formatter.addEventListener("formatChanged",handleFormatChanged);
    }
		private function handleFormatChanged(event:Event):void{


			// var formatter:IFormatter = event.target as IFormatter;
			// input.value = formatter.formattedString;
		}

    private function formatDate(date:Date):String{
      // var a:DateFormatDDMMYYYY;
      // a.formattedString
      return "";
    }
    private var _startDate:Date;

    public function get startDate():Date
    {
    	return _startDate;
    }

    public function set startDate(value:Date):void
    {
      calendar.startDate = value;
    	_startDate = value;
    }
    private var _endDate:Date;

    public function get endDate():Date
    {
    	return _endDate;
    }

    public function set endDate(value:Date):void
    {
      calendar.endDate = value;
    	_endDate = value;
    }
    private var _range:Boolean;

    public function get range():Boolean
    {
    	return _range;
    }

    public function set range(value:Boolean):void
    {
      if(value != _range){
        toggle(valueToSelector("range"),value);
      }
    	_range = value;
    }
    private var _datetimeRange:Boolean;

    public function get datetimeRange():Boolean
    {
    	return _datetimeRange;
    }
    public function set datetimeRange(value:Boolean):void
    {
      if(range){        
        if(_datetimeRange != !!value){
          toggle(valueToSelector("datetimeRange"),value);
          if(value){            
            input.placeholder = dateFormat + " hh:mm a";
            if(input2){
              input2.placeholder = dateFormat + " hh:mm a";
            }
          }else{
            input.placeholder = dateFormat;
            if(input2){
              input2.placeholder = dateFormat;
            }
          }
        }
        _datetimeRange = value;
      }else{
        _datetimeRange = false;
      }
    }
  }
}