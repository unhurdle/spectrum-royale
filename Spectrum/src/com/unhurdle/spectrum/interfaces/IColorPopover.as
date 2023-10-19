package com.unhurdle.spectrum.interfaces
{
	import org.apache.royale.core.IPopUp;
	import org.apache.royale.geom.Rectangle;
	import org.apache.royale.events.IEventDispatcher;
	import com.unhurdle.spectrum.ISpectrumElement;

	public interface IColorPopover extends IPopUp, IEventDispatcher, ISpectrumElement
	{
		
		function get dataProvider():Object;
		function set dataProvider(value:Object):void;

		function get appliedColor():IRGBA;
		function set appliedColor(value:IRGBA):void;
		
		function get position():String;
		function set position(value:String):void;

		function get anchor():Rectangle;
		function set anchor(value:Rectangle):void;
		
		function get applyText():String;
		function set applyText(value:String):void;
		
		function get cancelText():String;
		function set cancelText(value:String):void;
		
		function get showApplyButtons():Boolean;
		function set showApplyButtons(value:Boolean):void;
		
		function get showColorControls():Boolean;
		function set showColorControls(value:Boolean):void;
		
		function get showAlphaControls():Boolean;
		function set showAlphaControls(value:Boolean):void;
		
		function get showSelectionSwatch():Boolean;
		function set showSelectionSwatch(value:Boolean):void;

		function get open():Boolean;
		function set open(value:Boolean):void;

		function get areaSize():Number;
		function set areaSize(value:Number):void;

		function get preferredColumns():int;
		function set preferredColumns(value:int):void;

		function get preferredRows():int;
		function set preferredRows(value:int):void;

		function get hexEditable():Boolean;
		function set hexEditable(value:Boolean):void;
		
	}
}