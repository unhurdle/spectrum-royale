package vos
{
    [Bindable]
    public class GuitarristVO
    {
        public var guitarrist:String;
        public var album:String;
        public var year:int;

        public function GuitarristVO(guitarrist:String, album:String, year:int)
        {
            this.guitarrist = guitarrist;
            this.album = album;
            this.year = year;
        }
    }
}
