package com.unhurdle.spectrum
{
  import org.apache.royale.html.beads.models.ArraySelectionModel;
  import org.apache.royale.core.IBead;

  public class ComboBoxModel extends ArraySelectionModel implements IBead, IComboBoxModel
  {
    public function ComboBoxModel()
    {
      
    }
    private var _text:String;
		/**
		 *  The string to display in the org.apache.royale.html.ComboBox input field.
		 * 
		 *  @copy org.apache.royale.core.IComboBoxModel#text
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			if (value != _text)
			{
				_text = value;
				dispatchEvent(new Event("textChange"));
			}
		}
  }
}