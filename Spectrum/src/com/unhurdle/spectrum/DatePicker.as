package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.model.DatePickerModel;

  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.events.Event;
  import org.apache.royale.svg.elements.Path;
  import com.unhurdle.spectrum.includes.InputGroupInclude;
  import org.apache.royale.geom.Rectangle;
  import org.apache.royale.utils.DisplayUtils;
  import org.apache.royale.html.elements.Div;

  public class DatePicker extends SpectrumBase
  {
    public function DatePicker()
    {
      super();
      typeNames = getSelector() + " " + InputGroupInclude.getSelector();
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
      addElementToWrapper(this,'div');
      //TODO is this right?
      className = InputGroupInclude.getSelector();
      input = new TextField();
      input.toggle(appendInputGroup("-field"),true);
      // input.readOnly = true;
      button = new FieldButton()
      button.className = appendInputGroup("-button");
      // button.onclick = openDatePicker;
      button.addEventListener("click",toggleButton);

      datePicker = newElement("input") as HTMLInputElement;
      datePicker.type = "hidden";
      
      var svgElement:SVGIcon = new SVGIcon();
      svgElement.setAttribute("focusable",false);
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
      window.addEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
      return element;
    }
    
    protected function handleTopMostEventDispatcherMouseDown(event:MouseEvent):void
		{
      trace(event);
      if(event.target.className != "spectrum-Calendar-date"){
        closePopup();
      }
      
		}
    protected function closePopup():void{
      if(popover && popover.open){
  			popover.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
	  		this.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
		  	popover.topMostEventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
        popover.open = false;
      }
    }

    	protected function handleControlMouseDown(event:MouseEvent):void
		{			
			event.stopImmediatePropagation();
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
        toggle(valueToSelector("quiet"),value);
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
      popover.open = !popover.open;
      button.selected = popover.open;
      if(popover.open){
        var componentBounds:Rectangle = DisplayUtils.getScreenBoundingRect(this);
        popover.y = componentBounds.bottom;
        popover.x = componentBounds.left;
        calendar.startDate = startDate;
        calendar.endDate = endDate;
        calendar.selectRange(startDate,endDate);
      }
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
      popover.open = false;
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
        input.toggle(appendDatePicker("-startField"),true);
        input.placeholder = dateFormat;
        // add dash
        var div:Div = new Div();
        div.className = valueToSelector("rangeDash");
        addElementAt(div,1);
        // add second field
        input2 = new TextField();
        input2.toggle(appendInputGroup("-field"),true);
        input2.toggle(appendDatePicker("-endField"),true);
        input2.placeholder = dateFormat;
        if(invalid){
          input2.invalid = true;
          input.invalid = false;
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
      // var model:IBeadModel = _strand.getBeadByType(IBeadModel) as IBeadModel;
			// IEventDispatcher(model).addEventListener("selectedDateChanged", selectionChangeHandler);
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
  }
}