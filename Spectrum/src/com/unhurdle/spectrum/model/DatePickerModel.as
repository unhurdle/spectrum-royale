package com.unhurdle.spectrum.model
{
  import org.apache.royale.events.EventDispatcher;
  import org.apache.royale.core.IDateChooserModel;
  import org.apache.royale.core.IStrand;
  import org.apache.royale.events.Event;
  import com.unhurdle.spectrum.utils.DateUtil;

  public class DatePickerModel extends EventDispatcher implements IDateChooserModel
	{
		public function DatePickerModel()
		{
			// default displayed year and month to "today"
//			var today:Date = new Date();
//			displayedYear = today.getFullYear();
//			displayedMonth = today.getMonth();
		}
		
		private var _strand:IStrand;
		
		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function set strand(value:IStrand):void
		{
			_strand = value;
		}
		
		private var _dayNames:Array = DateUtil.getLongWeekdays();
		private var _monthNames:Array = DateUtil.getMonths();
    private var _days:Array;
		private var _displayedYear:Number;
		private var _displayedMonth:Number;
		private var _firstDayOfWeek:Number = 0;
		private var _selectedDate:Date;
		
		/**
		 *  An array of strings used to name the days of the week with Sunday being the
		 *  first element of the array.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get dayNames():Array
		{
			return _dayNames;
		}
		public function set dayNames(value:Array):void
		{
			_dayNames = value;
			dispatchEvent( new Event("dayNamesChanged") );
		}
		private var _narrowDayNames:Array = DateUtil.getNarrowWeekdays();

		public function get narrowDayNames():Array
		{
			return _narrowDayNames;
		}
		
		private var _shortDayNames:Array = DateUtil.getShortWeekdays();

		public function get shortDayNames():Array
		{
			return _shortDayNames;
		}
		/**
		 *  An array of strings used to name the months of the year with January being
		 *  the first element of the array.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get monthNames():Array
		{
			return _monthNames;
		}
		public function set monthNames(value:Array):void
		{
			_monthNames = value;
			dispatchEvent( new Event("monthNames") );
		}
		
		/**
		 *  The year currently displayed by the DateChooser.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
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
		
		/**
		 *  The month currently displayed by the DateChooser.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
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
		
		/**
		 *  The index of the first day of the week, Sunday = 0.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
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

		/**
		 *  The currently selected date or null if no date has been selected.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
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
                    if (needsUpdate) updateCalendar();
                }
                
                dispatchEvent( new Event("selectedDateChanged") );
            }
        }
        
        // Utilities
        
        
        /**
         * @private
         */
        public function updateCalendar():void
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
        
        /**
         * @private
         */
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
        
        /**
         * @private
         */
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
	}
}