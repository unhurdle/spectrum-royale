package com.unhurdle.spectrum
{
	import org.apache.royale.core.IChild;

	public class RadioGroup extends FieldGroup
	{
		public function RadioGroup()
		{
			super();
		}
		private var _radioName:String;
		public function get radioName():String
		{
			return _radioName;
		}
		public function set radioName(value:String):void
		{
			_radioName = value;
		}
		override public function addElement(c:IChild, dispatchEvent:Boolean = true):void{
			if(c is Radio){
				var radio:Radio = c as Radio;
				radio.radioName = radioName;
			}
			super.addElement(c,dispatchEvent);
		}
	}
}