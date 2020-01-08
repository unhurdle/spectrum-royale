package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

    public class ShowOnOverTooltip extends SpectrumBase
    {
      public function ShowOnOverTooltip()
      {
        super();
        typeNames = "u-tooltip-showOnHover";
      }
      
      private var textNode:TextNode;
      private var toolTip:Tooltip;

      COMPILE::JS
      override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,"span") as HTMLSpanElement;
      textNode = new TextNode("");
      toolTip = new Tooltip();
      addElement(toolTip);
      textNode.element = element;
      return element;
      }

      public function get visibleText():String
      {
        return textNode.text;
      }

      public function set visibleText(value:String):void
      {
        textNode.text = value;
      }
      public function get text():String
      {
        return toolTip.text;
      }

      public function set text(value:String):void
      {
        toolTip.text = value;
      }
      public function get flavor():String
      {
        return toolTip.flavor;
      }

      public function set flavor(value:String):void
      {
        toolTip.flavor = value;
      }
      public function get icon():String
      {
        return toolTip.icon;
      }

      public function set icon(value:String):void
      {
        toolTip.icon = value;
      }
      public function get direction():String
      {
        return toolTip.direction;
      }

      public function set direction(value:String):void
      {
        toolTip.direction = value;
      }
      public function get isOpen():Boolean
      {
        return toolTip.isOpen;
      }

      public function set isOpen(value:Boolean):void
      {
        toolTip.isOpen = value;
      }    
  }
}