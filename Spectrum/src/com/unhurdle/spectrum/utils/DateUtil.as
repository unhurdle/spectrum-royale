package com.unhurdle.spectrum.utils
{
  import Intl.DateTimeFormat;

  public class DateUtil
  {
    private function DateUtil(){}
    public static function getShortWeekdays():Array{
      var options:Object = { weekday: 'short'};
      return getWeekdays(options);
    }
    public static function getLongWeekdays():Array{
      var options:Object = { weekday: 'long'};
      return getWeekdays(options);
    }
    public static function getNarrowWeekdays():Array{
      
      var options:Object = { weekday: 'narrow'};
      return getWeekdays(options);
    }
    private static function getWeekdays(options:Object):Array
    {
      var weekdays:Array = [];
      var d:Date = new Date("1/1/2017");
      while(d.getDate() <= 7){
        weekdays.push(new Intl.DateTimeFormat('en-US', options).format(d));
        d.setDate(d.getDate() + 1);
      }
      return weekdays;
    }
    public static function getMonths():Array{
      var months:Array = [];
      var options:Object = { month: 'long'};
      var d:Date = new Date("1/1/2017");
      while(d.getFullYear() == 2017){
        months.push( new Intl.DateTimeFormat('en-US', options).format(d));
        d.setMonth(d.getMonth() + 1);}
      return months;
    }
    public static function getDateString(date:Date):String
    {
      var options:Object = {  weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'};
      return new Intl.DateTimeFormat('en-US', options).format(date);
    }
  }
}