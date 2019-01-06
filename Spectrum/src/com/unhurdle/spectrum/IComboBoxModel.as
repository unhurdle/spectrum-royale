package com.unhurdle.spectrum
{
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.core.IBeadModel;

	public interface IComboBoxModel extends IEventDispatcher, IBeadModel
	{
        // TODO: should extend ITextModel
        /**
         *  The text displayed in the ComboBox.
         *
         */
		function get text():String;
		function set text(value:String):void;
		
        /**
         *  The set of choices displayed in the ComboBox's
         *  dropdown.  The dataProvider can be a simple 
         *  array or vector if the set of choices is not
         *  going to be modified (except by wholesale
         *  replacement of the dataProvider).  To use
         *  different kinds of data sets, you may need to
         *  provide an alternate "mapping" bead that
         *  iterates the dataProvider, generates item
         *  renderers and assigns a data item to the
         *  item renderers.
         *
         */
		function get dataProvider():Object;
		function set dataProvider(value:Object):void;
		
        /**
         *  The index of the selected item in the
         *  dataProvider.  Values less than 0 can
         *  have specific meanings but generally mean
         *  that no item is selected because the
         *  user has typed in a custom entry or has
         *  yet to make a choice.
         *
         */
		function get selectedIndex():int;
		function set selectedIndex(value:int):void;
		
        /**
         *  The data item selected in the
         *  dataProvider.  null usually means
         *  that the user has not selected a value
         *  and has typed in a custom entry.
         *
         */
		function get selectedItem():Object;
		function set selectedItem(value:Object):void;
	}  
}