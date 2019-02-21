package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.core.ISelectableItemRenderer;
  public interface ITextItemRenderer extends ISelectableItemRenderer
  {
    function get text():String;
      function set text(value:String):void;

      
    function get align():String
    function set align(value:String):void
    }
  }
