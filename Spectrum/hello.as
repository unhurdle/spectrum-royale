
    public function get selectedDate():Date
		{
			return _modelSelectedDate;
		}
		public function set selectedDate(value:Date):void //of type Date
		{
			_modelSelectedDate = value;
		}
    public function get dayNames():Array //returns day names []
		{
			return _dayNames;
		}
		public function set dayNames(value:Array):void
		{
			_dayNames = value;
			dispatchEvent( new Event("dayNamesChanged") );
		}

    public function get monthNames():Array //returns month names []
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
			if (value != _displayedYear) {
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

    
    public function get modelSelectedDate():Date
		{
			return _modelSelectedDate;
		}
		public function set modelSelectedDate(value:Date):void
		{
			if (value != _modelSelectedDate) {
				_modelSelectedDate = value;
				
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
                    if (needsUpdate) updateCalendar();
                }
                
                dispatchEvent( new Event("selectedDateChanged") );
            }
        }
    private function updateCalendar():void
        {       
            var firstDay:Date = new Date(displayedYear,displayedMonth,1);
            
            _days = new Array(42);
            
            // skip to the first day and renumber to the last day of the month
			var i:int = firstDay.getDay();
            var dayNumber:int = 1;
            var numDays:Number = numberOfDaysInMonth(displayedMonth, displayedYear);
            
            while(dayNumber <= numDays) {
                _days[i++] = new Date(displayedYear, displayedMonth, dayNumber++);
            }
            
        }

    private function numberOfDaysInMonth(month:Number, year:Number):Number
        {
            var n:int;
            
            if (month == 1) // Feb
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
            if (!_modelSelectedDate) return -1;

            var str:String = _modelSelectedDate.toDateString();

            for(var i:int=0; i < _days.length; i++) {
                var test:Date = _days[i] as Date;
				
				if (test && test.toDateString() == str)
					return i;

            }
            return -1;
		}
	      
    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
    	_text = value;
      title.text = value;
    }
    
	private function updateDisplay():void
    {
        title.text = model.monthNames[model.displayedMonth] + " " +
            String(model.displayedYear);

        //    tbody.dataProvider = days;

        //     tbody.selectedIndex = model.getIndexForSelectedDate();
        
    }

    /**
     * @private
     */
    private function selectionChangeHandler(event:Event):void
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