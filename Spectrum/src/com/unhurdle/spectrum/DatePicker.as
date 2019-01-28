package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.geom.Point;
  import org.apache.royale.utils.PointUtils;
  import org.apache.royale.core.IPopUpHost;
  import org.apache.royale.utils.UIUtils;
	import org.apache.royale.utils.callLater;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.html.accessories.DateFormatMMDDYYYY;
	import org.apache.royale.html.accessories.DateFormatDDMMYYYY;
	//// import org.apache.royale.core.IFormatter;
	import org.apache.royale.events.Event;
	import com.unhurdle.spectrum.models.DatePickerModel;
	import org.apache.royale.utils.loadBeadFromValuesManager;
	// import mx.formatters.IFormatter;

  public class DatePicker extends SpectrumBase
  {
    public function DatePicker()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-InputGroup";
    }

    private var input:HTMLInputElement;
    private var button:HTMLButtonElement;
    private var datePicker:HTMLInputElement;
    
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      //TODO how much of this can be done in Icons and other classes?
      addElementToWrapper(this,'div');
      className = "spectrum-Datepicker";
      input = newElement("input") as HTMLInputElement;
      input.className = appendSelector("-field") + " spectrum-Textfield";
      input.type = "text";
      input.readOnly = true;
      button = newElement("button") as HTMLButtonElement;
      button.className = "spectrum-FieldButton spectrum-InputGroup-button";
      // button.onclick = openDatePicker;
      button.addEventListener("click",toggleButton);

      datePicker = newElement("input") as HTMLInputElement;
      datePicker.type = "hidden";
      
      var iconClass:String = "spectrum-Icon spectrum-Icon--sizeS";
      
      var svgElement:SVGElement = newSVGElement("svg",iconClass);
      svgElement.setAttribute("focusable",false);
      svgElement.setAttribute("viewBox","0 0 36 36");
      svgElement.setAttribute("role","img");
      
      var path:SVGPathElement = newSVGElement("path","") as SVGPathElement;
      path.setAttribute("d","M33 6h-5V3a1 1 0 0 0-1-1h-2a1 1 0 0 0-1 1v3H10V3a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1v3H1a1 1 0 0 0-1 1v26a1 1 0 0 0 1 1h32a1 1 0 0 0 1-1V7a1 1 0 0 0-1-1zm-1 26H2V8h4v1a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1V8h14v1a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1V8h4z");
      svgElement.appendChild(path);

      path = newSVGElement("path","") as SVGPathElement;
      path.setAttribute("d","M6 12h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4zM6 18h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4zM6 24h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4z");
      svgElement.appendChild(path);
      
      button.appendChild(svgElement);
      element.appendChild(input);
      element.appendChild(button);
      element.appendChild(datePicker); 

      popover = new Popover();
      popover.className = appendSelector("-popover");
      popover.position = "bottom";
      // popover.percentWidth = 100;
      popover.style = {"margin-top": "30px","z-index":"1"};
      calendar = new Calendar();
      popover.addElement(calendar);
      addElement(popover);
      // window.addEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);

      return element;
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
        toggle(appendSelector("--quiet"),value);
        if(value){
          input.classList.add("spectrum-Textfield--quiet");
          button.classList.add("spectrum-FieldButton--quiet");
        }
        else{
          input.classList.remove("spectrum-Textfield--quiet");
          button.classList.remove("spectrum-FieldButton--quiet");
        }
      }
      _quiet = value;
    }
    private function toggleButton():void{
      popover.open = !popover.open;
      if(popover.open){
        button.className += " is-selected";
        calendar.startDate = startDate;
        calendar.endDate = endDate;
        calendar.selectRange(startDate,endDate);
      }
      else{
        button.className.slice(button.className.indexOf("is-selected"),11); //why ?
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
     public function get value():String
    {
    	return input.value;
    }

    public function set value(value:String):void
    {
    	input.value = value;
    }
    private var popover:Popover
    // COMPILE::JS
    // private function openDatePicker():void{
    //   popover.open = true;
    // }
    private function handleSelectedDay(ev:*):void{
      popover.open = false;
      // dispatchEvent(new Event("selectedDateChanged"));
      // var date:Date = ev.target.chosenDate;

      // var year:String = date.getFullYear().toString();

      // var month:String = (1 + date.getMonth()).toString();
      // month = month.length > 1 ? month : '0' + month;

      // var day:String = date.getDate().toString();
      // day = day.length > 1 ? day : '0' + day;
  
      // input.value = month + '/' + day + '/' +  year;
    }
    override public function addedToParent():void{
      super.addedToParent();
      // model = calendar.model;
      // (model as DatePickerModel).addEventListener("selectedDateChanged",handleSelectedDay);
			// loadBeadFromValuesManager(IFormatter, "IFormatter", this);

			// var formatter:IFormatter = getBeadByType(IFormatter) as IFormatter;
			// // formatter.addEventListener("formatChanged",handleFormatChanged);
      // // var model:IBeadModel = _strand.getBeadByType(IBeadModel) as IBeadModel;
			// // IEventDispatcher(model).addEventListener("selectedDateChanged", selectionChangeHandler);
    }
		// private function handleFormatChanged(event:Event):void{
		// 	var formatter:IFormatter = event.target as IFormatter;
		// 	// input.value = formatter.formattedString;
		// }

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
}
 // public function set popUpVisible(value:Boolean):void
		// {
		// 	if(value){
		// 		var origin:Point = new Point(0, host.height - 6);
		// 		var relocated:Point = PointUtils.localToGlobal(origin,host);
		// 		_popup.x = relocated.x
		// 		_popup.y = relocated.y;
		// 		_popup.width = host.width;
		// 		// list.selectedIndex = -1;

		// 		var popupHost:IPopUpHost = UIUtils.findPopUpHost(host);
		// 		popupHost.popUpParent.addElement(_popup);
		// 		callLater(openPopup)
		// 		_popup.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
		// 		host.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
		// 		callLater(function():void {
		// 			_popup.topMostEventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
		// 		});
		// 	} else {
		// 		closePopup();
		// 	}
    //   // _popup.open = value;
		// }
    // private function openPopup():void{
		// 	_popup.open = true;
		// }
    // protected function handleTopMostEventDispatcherMouseDown(event:MouseEvent):void
		// {
    //   closePopup();
		// }
    // protected function handleControlMouseDown(event:MouseEvent):void
		// {			
		// 	event.stopImmediatePropagation();
		// }
    // private function closePopup():void{
    //   if(_popup && _popup.open){
  	// 		_popup.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
	  // 		this.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
		//   	_popup.topMostEventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
    //     _popup.open = false;
    //     //  UIUtils.removePopUp(_popup);
    //   }
		// }
  }

