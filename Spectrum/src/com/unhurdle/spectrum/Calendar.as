package com.unhurdle.spectrum
{
    COMPILE::JS {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  
    }
    import com.unhurdle.spectrum.model.DatePickerModel;

    import org.apache.royale.events.Event;
    import org.apache.royale.events.MouseEvent;
  
    import org.apache.royale.html.elements.Td;
    import org.apache.royale.html.elements.Tr;
    import org.apache.royale.html.elements.Table;
    import org.apache.royale.html.elements.Tbody;
    import org.apache.royale.html.elements.Div;
 

    [Event(name="dayNamesChanged ", type="org.apache.royale.events.Event")]
    [Event(name="monthNames ", type="org.apache.royale.events.Event")]
    [Event(name="displayedYearChanged ", type="org.apache.royale.events.Event")]
    [Event(name="displayedMonthChanged ", type="org.apache.royale.events.Event")]
    [Event(name="firstDayOfWeekChanged ", type="org.apache.royale.events.Event")]
    [Event(name="daysChanged ", type="org.apache.royale.events.Event")]
    [Event(name="selectedDateChanged ", type="org.apache.royale.events.Event")]
    [Event(name="change", type="org.apache.royale.events.Event")]

    
    public class Calendar extends SpectrumBase
    {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/calendar/dist.css");
     * document.head.appendChild(link);
     * </inject_script>
     */

        public function Calendar()
        {
            super();
            model = datePickerModel = new DatePickerModel();
        }

        override protected function getSelector():String{
        return "spectrum-Calendar";
        }
        
        private var datePickerModel:DatePickerModel;

        [Bindable("selectedDateChanged")]
        
        private var title:TextNode;
        private var _text:String;
        private var prev:ActionButton;
        private var next:ActionButton;
        private var _disabled:Boolean;
        private var table:org.apache.royale.html.elements.Table;
        private var calenderBody:org.apache.royale.html.elements.Tbody;
        private var _startDate:Date;
        private var _endDate:Date;
        private var displayedDates:Vector.<CalendarDay>;

        public function get disabled():Boolean
        {
            return _disabled;
        }
        
        public function set disabled(value:Boolean):void
        {
            _disabled = value;
            prev.disabled = value;
            next.disabled = value;
        }

        public function get dayNames():Array
        {
            return datePickerModel.dayNames;
        }
           
        public function set dayNames(value:Array):void
        {
            datePickerModel.dayNames = value;
        }

        public function get monthNames():Array
        {
            return datePickerModel.monthNames;
        }
        
        public function set monthNames(value:Array):void
        {
            datePickerModel.monthNames = value;
        }

        public function get displayedYear():Number
        {
            return datePickerModel.displayedYear;
        }
        
        public function set displayedYear(value:Number):void
        {
            datePickerModel.displayedYear = value;
        }

        public function get displayedMonth():Number
        {
            return datePickerModel.displayedMonth;
        }
        
        
        public function set displayedMonth(value:Number):void
        {
            datePickerModel.displayedMonth = value;
        }

        public function get firstDayOfWeek():Number
        {
            return datePickerModel.firstDayOfWeek;
        }
        
        public function set firstDayOfWeek(value:Number):void
        {
            datePickerModel.firstDayOfWeek = value;
        }
        
        public function get days():Array
        {
            return datePickerModel.days;
        }
        
        public function set days(value:Array):void
        {
            datePickerModel.days = value;
        }

        private var _today:Date;

        public function get today():Date
        {
            if(!_today){
                _today = new Date();
            }
        	return _today;
        }

        public function set today(value:Date):void
        {
        	_today = value;
        }
        
        public function get selectedDate():Date
        {
            return datePickerModel.selectedDate;
        }
        
        public function set selectedDate(value:Date):void
        {
            datePickerModel.selectedDate = value;
        }

        public function get startDate():Date
        {
        	return _startDate;
        }

        public function set startDate(value:Date):void
        {
        	_startDate = value;
            updateDisplay();
        }

        public function get endDate():Date
        {
        	return _endDate;
        }

        public function set endDate(value:Date):void
        {
        	_endDate = value;
            updateDisplay();
        }
        private function updateCalendar():void
        {   
            datePickerModel.updateCalendar();
            updateDisplay();
        }
        
        public function getIndexForSelectedDate():Number
        {
            return datePickerModel.getIndexForSelectedDate();
        }
        
        private function updateDisplay():void
        {
            title.text = monthNames[displayedMonth] + " " + String(displayedYear);
            setDates();
        }
        
        private function handleModelChange(event:Event):void{   
          updateDisplay();
        }

        public function selectRange(start:Date,end:Date):void{   
            for each(var day:CalendarDay in displayedDates){
                day.setRange(start,end);
            }
        }

        private function prevMonthClickHandler(event:MouseEvent):void
        {
            event.preventDefault();
            var month:Number = displayedMonth - 1;
            var year:Number  = displayedYear;
            if (month < 0) {
                month = 11;
                year--;
            }
            displayedMonth = month;
            displayedYear = year;
            updateDisplay();
        }

        
        private function nextMonthClickHandler(event:MouseEvent):void
        {
            event.preventDefault();
            var month:Number = displayedMonth + 1;
            var year:Number  = displayedYear;
            if (month >= 12) {
                month = 0;
                year++;
            }
            displayedMonth = month;
            displayedYear = year;
            updateDisplay();
        }
        COMPILE::JS
        override public function addedToParent():void{
            super.addedToParent();
            if(!displayedYear){
                displayedYear = today.getFullYear();
            }
            if(!displayedMonth){
                displayedMonth = today.getMonth();
            }
            var body:HTMLElement = newElement('div');
            body.className = appendSelector("-body");
            body.setAttribute("role","grid");
            body.tabIndex = 0;

            table = new org.apache.royale.html.elements.Table();
            table.className = appendSelector("-table");
            table.setAttribute("role","presentation");

            var daysOfTheWeekHeader:HTMLElement = newElement('thead');
            daysOfTheWeekHeader.setAttribute("role","presentation");

            var daysOfTheWeek:HTMLElement = newElement('tr');
            daysOfTheWeek.setAttribute("role","row");

            for(var i:int = 0 ; i <7; i++){
                var dayOfWeek:HTMLElement = newElement('th'); 
                dayOfWeek.className = appendSelector("-tableCell"); 
                dayOfWeek.setAttribute("role","columnheader");
                dayOfWeek.setAttribute("scope","col");

                var d:TextNode = new TextNode('abbr');  
                d.className = appendSelector("-dayOfWeek");
                d.text = datePickerModel.shortDayNames[i]; 
                d.element.title = dayNames[i];
                dayOfWeek.appendChild(d.element); 
                daysOfTheWeek.appendChild(dayOfWeek); 
            }
            
            daysOfTheWeekHeader.appendChild(daysOfTheWeek); 
            table.element.appendChild(daysOfTheWeekHeader);
            body.appendChild(table.element);
            table.addedToParent();
            element.appendChild(body);
            
            updateCalendar();
            addEventListener("displayedMonthChanged",handleModelChange);
        }
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            addElementToWrapper(this,'div');
            var styleStr:String = "width:280px;z-index:1;";
            setAttribute("style",styleStr);

            var header:Div = new Div();
            header.className = appendSelector("-header");
            
            title = new TextNode('div');   
            title.className = appendSelector("-title");
            title.setAttribute("role","heading");
            header.element.appendChild(title.element);
    
            prev = new ActionButton();
            prev.quiet = true;
            prev.className = appendSelector("-prevMonth");
            prev.addEventListener("click",prevMonthClickHandler);
            var type:String = "ChevronLeftLarge";
            var prevIcon:Icon = new Icon(Icon.getCSSTypeSelector(type));
            prevIcon.type = type;
            prev.addElement(prevIcon);
            header.addElement(prev);

            next = new ActionButton();
            next.quiet = true;
            next.className = appendSelector("-nextMonth");
            next.addEventListener("click",nextMonthClickHandler);
            type = "ChevronRightLarge";
            var nextIcon:Icon = new Icon(Icon.getCSSTypeSelector(type));
            nextIcon.type = type;
            next.addElement(nextIcon);
            header.addElement(next);
            addElement(header);

            return element
        }

        COMPILE::SWF
        private function setDates():void{}

        COMPILE::JS
        private function setDates():void{
            displayedDates = new Vector.<CalendarDay>();
            if(table.numElements && calenderBody){
                table.removeElement(calenderBody);
            }
            calenderBody = new org.apache.royale.html.elements.Tbody();
            calenderBody.setAttribute("role","presentation");
            var l:int = 0;
            for (var k:int = 0; k<6;k++,l--){
                var calenderRow:Tr = new Tr();
                calenderRow.setAttribute("role","row");
                var addRow:Boolean = true;
               for(var j:int = 0; j<7; j++,l++){
                    var cell:Td = new Td();  
                    cell.setAttribute("role", "gridcell");
                    cell.className = appendSelector("-tableCell");
                    cell.tabIndex = -1;
                    var span:CalendarDay = new CalendarDay();
                    if(j == 0){
                        span.firstInWeek = true;
                    } else if (j == 6){
                        span.lastInWeek = true;
                    }
                    span.disabled = disabled;
                    if(span.firstInWeek && k+l > 7 && !days[k+l]){
                        // only need 5 rows.
                        addRow = false;
                        break;
                    }
                    displayedDates.push(span);
                    if(days[k+l]){
                        span.isToday = days[k+l].toDateString() == today.toDateString();
                        var styleStr:String = "width:40px;height:40px;";
                        cell.setAttribute("style",styleStr);
                        cell.element.title = days[k+l].getDate();
                        span.date = days[k+l] as Date;
                        
                        span.addEventListener(MouseEvent.CLICK,handleSelectedDay);
                    }else{
                        span.isOutsideMonth = true;
                    }
                    cell.addElement(span);
                    calenderRow.addElement(cell); 
                }
                if(addRow){
                    calenderBody.addElement(calenderRow);
                }
            }
            table.addElement(calenderBody);
            var start:Date = selectedDate;
            var end:Date = selectedDate;
            if(startDate){
                start = startDate;
            }
            if(endDate){
                end = endDate;
            }
            selectRange(start,end);
        }

        private function handleSelectedDay(ev:*):void{
            var clickedDay:CalendarDay = ev.target as CalendarDay;
            var date:Date = clickedDay.date;
            var start:Date = date;
            var end:Date = date;
            if(startDate){
                if(!endDate && date>startDate){
                    start = startDate;
                }
                else{
                    return;
                }
            }
            else{
                if(endDate){
                    if(date <endDate){
                        end = endDate;
                    }
                    else{
                        return;
                    }
                }
            }
            selectedDate = date;
            if(elementSelected){//remove selected from last selected element
                elementSelected.selected = false;
            }
            selectRange(start,end);
            elementSelected = clickedDay;
        }
        private var elementSelected:CalendarDay;

        //TODO add is-focused!! we need a lits of event dates
        ///////////////////////////////////////////how to do???
    }
}