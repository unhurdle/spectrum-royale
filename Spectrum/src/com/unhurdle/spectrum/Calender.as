package com.unhurdle.spectrum
{
    COMPILE::JS {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  
    }
    import org.apache.royale.core.IStrand;
    import org.apache.royale.core.IBeadModel;
    import org.apache.royale.html.elements.Tbody;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.events.Event;
    

    [Event(name="dayNamesChanged ", type="org.apache.royale.events.Event")]
    [Event(name="monthNames ", type="org.apache.royale.events.Event")]
    [Event(name="displayedYearChanged ", type="org.apache.royale.events.Event")]
    [Event(name="displayedMonthChanged ", type="org.apache.royale.events.Event")]
    [Event(name="firstDayOfWeekChanged ", type="org.apache.royale.events.Event")]
    [Event(name="daysChanged ", type="org.apache.royale.events.Event")]
    [Event(name="selectedDateChanged ", type="org.apache.royale.events.Event")]
    [Event(name="change", type="org.apache.royale.events.Event")]

    
    public class Calender extends SpectrumBase
    {
        public function Calender()
        {
        super();
        }

        override protected function getSelector():String{
        return "spectrum-Calendar";
        }
        
        [Bindable("selectedDateChanged")]
        
        private var title:TextNode;
        private var _text:String;
        private var _monthNames:Array = ["January","February","March","April","May","June","July","August","September","October","November","December"];
        private var _days:Array;
        private var _displayedYear:Number;
        private var _displayedMonth:Number;
        private var _firstDayOfWeek:Number = 0;
        private var _selectedDate:Date;
        private var _dayNames:Array = ["Sunday","Monday","Tuesday","Wednesday","Thurdsay","Friday","Saturday"];
        private var dText:Array = ["Su","Mo","Tu","We","Th","Fr","Sa"];
        private var prev:HTMLButtonElement;
        private var next:HTMLButtonElement;
        private var _disabled:Boolean;
        private var calenderRow:HTMLElement;
        private var table:HTMLElement;
        private var span:TextNode;
        private var calenderBody:HTMLElement;
        


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
            return _dayNames;
        }

        
           
        public function set dayNames(value:Array):void
        {
            _dayNames = value;
            dispatchEvent( new Event("dayNamesChanged") );
        }

        public function get monthNames():Array
        {
            return _monthNames;
        }

        
        public function set monthNames(value:Array):void
        {
            _monthNames = value;
            dispatchEvent( new Event("monthNames") );
        }

        public function get displayedYear():Number
        {
            return _displayedYear;
        }

        
        public function set displayedYear(value:Number):void
        {
            if (value != _displayedYear){
                _displayedYear = value;
                updateCalendar();
                dispatchEvent( new Event("displayedYearChanged") );
            }
        }

        public function get displayedMonth():Number
        {
            return _displayedMonth;
        }
        
        
        public function set displayedMonth(value:Number):void
        {
            if (_displayedMonth != value) {
                _displayedMonth = value;
                updateCalendar();
                dispatchEvent( new Event("displayedMonthChanged") );
            }
        }

        public function get firstDayOfWeek():Number
        {
            return _firstDayOfWeek;
        }
        
        public function set firstDayOfWeek(value:Number):void
        {
            if (value != _firstDayOfWeek) {
                _firstDayOfWeek = value;
                dispatchEvent( new Event("firstDayOfWeekChanged") );
            }
        }
        
        public function get days():Array
        {
            return _days;
        }
        
        public function set days(value:Array):void
        {
            if (value != _days) {
                _days = value;
                dispatchEvent( new Event("daysChanged") );
            }
        }
        
        public function get selectedDate():Date
        {
            return _selectedDate;
        }
        
        public function set selectedDate(value:Date):void
        {
            if (value != _selectedDate) {
                _selectedDate = value;
                if (value != null) {
                    var needsUpdate:Boolean = false;
                    if (value.getMonth() != _displayedMonth) {
                        needsUpdate = true;
                        _displayedMonth = value.getMonth();
                    }
                    if (value.getFullYear() != _displayedYear) {
                        needsUpdate = true;
                        _displayedYear  = value.getFullYear();
                    }
                    if (needsUpdate) {
                        updateCalendar();
                    }
                }
                dispatchEvent(new Event("selectedDateChanged"));
            }
        }
        
        
        private function updateCalendar():void
        {   
            var numDays:Number = numberOfDaysInMonth(displayedMonth, displayedYear);   
            var firstDay:Date = new Date(displayedYear,displayedMonth,1);
            _days = new Array(42);
            var i:int = firstDay.getDay();
            var dayNumber:int = 1;
            while(dayNumber <= numDays){
                _days[i++] = new Date(displayedYear, displayedMonth, dayNumber++);
            }
        
        }

        private function numberOfDaysInMonth(month:Number, year:Number):Number
        {
            var n:int;
            if (month == 1) 
            {
                if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) // leap year
                    n = 29;
                else
                    n = 28;
            }
                
            else if (month == 3 || month == 5 || month == 8 || month == 10)
                n = 30;
                
            else
                n = 31;
            
            return n;
        }  

        
        public function getIndexForSelectedDate():Number
        {
            if (!_selectedDate) return -1;

            var str:String = _selectedDate.toDateString();

            for(var i:int=0; i < _days.length; i++) {
                var test:Date = _days[i] as Date;
                
                if (test && test.toDateString() == str)
                    return i;

            }
            return -1;
        }
        
        private function updateDisplay():void
        {
            title.text = monthNames[displayedMonth] + " " +
            String(displayedYear);
            setDates();
        }



        /**
         * @private
         */
        
        
        private function selectionChangeHandler():void
        {
            
            updateDisplay();
            dispatchEvent(new Event("selectedDateChanged"));
            dispatchEvent( new Event("change") );
        }

        /**
         * @private
         */
        
        
        private function handleModelChange(event:Event):void
        {   
          updateDisplay();
        }

        public function selectedRange():void //right now is called in nextMonthClickHandler waiting for datePicker
        {   
            var today:Date = new Date();
            var isSelectedClass:String = "is-selected";
            var isRangeClass:String = "is-range-selection";
            var selectedStart:String = "5"; //needs to be set to the date of the datePicker 
            var selectedEnd:String =  "10"; //needs to be set to the date of the datePicker 
            var selectionStarted:Boolean = false;
            for each (var row:HTMLTableRowElement in calenderBody.children){
                for each(var c:HTMLTableCellElement in row.children){
                    if(!c.children){
                        continue;
                    }
                    var s:HTMLSpanElement = c.children[0];
                        if(s.textContent == selectedStart){
                            s.classList.add(isSelectedClass);
                            s.classList.add(isRangeClass);
                            s.classList.add("is-selection-start");
                            selectionStarted = true;
                        }
                        else if(s.textContent == selectedEnd){
                           s.classList.add(isSelectedClass);
                           s.classList.add(isRangeClass);
                           s.classList.add("is-selection-end");
                            return;
                        }
                        else if(selectionStarted){
                            s.classList.add(isSelectedClass);
                            s.classList.add(isRangeClass);
                        }
                        else if(s.textContent == (today.getDate() as String)){
                            s.classList.add(isSelectedClass);
                            s.classList.add(isRangeClass);
                            s.classList.add("is-today");
                        }
                        if(c == row.children[0] || c == row.children[7] ||  c == row.children[14] ||  c == row.children[21] ||  c == row.children[28] ){
                        s.classList.add("is-range-start");
                        }
                        if(c == row.children[6] || c == row.children[12] ||  c == row.children[18] ||  c == row.children[24] ||  c == row.children[30] ){
                         s.classList.add("is-range-end");
                        }
                     }
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
            selectedRange(); //right now is called here but needs DatePicker
        }
        
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            selectedDate = new Date();
            updateCalendar();
            addElementToWrapper(this,'div');

            var header:HTMLElement = newElement('div');
            header.className = "spectrum-Calendar-header";
            
            title = new TextNode('div');   
            title.className = "spectrum-Calendar-title";
            title.element.setAttribute("role","heading");
            header.appendChild(title.element);
    
            prev = newElement('button') as HTMLButtonElement;
            prev.className = "spectrum-ActionButton spectrum-ActionButton--quiet spectrum-Calendar-prevMonth";
            prev.addEventListener("click",prevMonthClickHandler);
            

            var prevIcon:Icon = new Icon("#spectrum-css-icon-ChevronLeftLarge");
            prevIcon.className = "spectrum-Icon spectrum-UIIcon-ChevronLeftLarge";
            prev.appendChild(prevIcon.element);
            prevIcon.addedToParent();
            header.appendChild(prev);

            next = newElement('button') as HTMLButtonElement;
            next.className = "spectrum-ActionButton spectrum-ActionButton--quiet spectrum-Calendar-nextMonth";
            next.addEventListener("click",nextMonthClickHandler);
           
            var nextIcon:Icon = new Icon("#spectrum-css-icon-ChevronRightLarge");
            nextIcon.className = "spectrum-Icon spectrum-UIIcon-ChevronRightLarge";
            next.appendChild(nextIcon.element);
            nextIcon.addedToParent();
            header.appendChild(next);
            element.appendChild(header);

            var body:HTMLElement = newElement('div');
            body.className = "spectrum-Calendar-body";
            body.setAttribute("role","grid");
            body.tabIndex = 0;

            table = newElement('table');
            table.className = "spectrum-Calendar-table";
            table.setAttribute("role","presentation");

            var daysOfTheWeekHeader:HTMLElement = newElement('thead');
            daysOfTheWeekHeader.setAttribute("role","presentation");

            var daysOfTheWeek:HTMLElement = newElement('tr');
            daysOfTheWeek.setAttribute("role","row");

            for(var i:int = 0 ; i <7; i++){
                var dayOfWeek:HTMLElement = newElement('th'); 
                dayOfWeek.className = "spectrum-Calendar-tableCell"; 
                dayOfWeek.setAttribute("role","columnheader");
                dayOfWeek.setAttribute("scope","col");

                var d:TextNode = new TextNode('abbr');  
                d.className = "spectrum-Calendar-dayOfWeek";
                d.text = dText[i]; 
                d.element.title = dayNames[i];
                dayOfWeek.appendChild(d.element); 
                daysOfTheWeek.appendChild(dayOfWeek); 
            }

            
            setDates();
            daysOfTheWeekHeader.appendChild(daysOfTheWeek); 
            table.appendChild(daysOfTheWeekHeader);
            body.appendChild(table);
            element.appendChild(body);
            addEventListener("displayedMonthChanged",handleModelChange);
            selectionChangeHandler();
            updateCalendar();
            return element
        }
        
        private function setDates():void{
            if(table.children.length){
                table.removeChild(calenderBody);
            }
            calenderBody = newElement('tbody');
            calenderBody.setAttribute("role","presentation");
            var l:int = 0;
            for (var k:int = 0; k<6;k++,l--){
                calenderRow = newElement('tr'); 
                calenderRow.setAttribute("role","row");
               for(var j:int = 0; j<7; j++,l++){
                    var cell:TextNode = new TextNode('td');  
                    cell.element.setAttribute("role", "gridcell");
                    cell.className = "spectrum-Calendar-tableCell";
                    cell.element.tabIndex = -1;
                    span = new TextNode('span');
                    span.element.setAttribute("role","presentation");
                    span.className = "spectrum-Calendar-date";
                    if(_days[k+l]){
                        cell.element.title = days[k+l].getDate();
                        span.text = days[k+l].getDate(); //here
                        span.element.onclick = handleSelectedDay;
                    }
                    cell.element.appendChild(span.element);
                    calenderRow.appendChild(cell.element); 
                }
                calenderBody.appendChild(calenderRow); 
            }
            table.appendChild(calenderBody); 
        }

        private function handleSelectedDay(ev:*):void{
            var empty:int =0;
            for(var i:int =0 ;i<days.length;i++)
            {
                if(days[i]){
                    break;
                }
                empty++;
            }
            selectedDate = days[Number(ev.target.textContent) + empty - 1];
        }

        // add is-today is-selected is-focused!!
    }
}