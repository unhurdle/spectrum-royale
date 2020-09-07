package com.unhurdle.spectrum
{
  COMPILE::JS
  {}
  import com.unhurdle.spectrum.includes.SideNavInclude;

  public class SideNavItem extends Group
  {
    public function SideNavItem(text:String = "")
    {
      super();
      this.text = text;
    }
    
    override protected function getSelector():String{
      return SideNavInclude.getSelector() + "-item";
    }

    COMPILE::JS
    private var _textNode:TextNode;
    
    private var _text:String;

    public function get text():String{
    	return _text;
    }

    public function set text(value:String):void
    {
    	_text = value;
      COMPILE::JS{
        if(value && !_textNode){
          _textNode = new TextNode("span");
          _textNode.className = appendSelector("Link");
          _textNode.element.style.userSelect = "none";
          _textNode.element.style.display = "inline-flex";
          _element.appendChild(_textNode.element);
          _textNode.text = value;
        }
      }
    }

    private var _disabled:Boolean;

		public function get disabled():Boolean
		{
			return _disabled;
		}

		public function set disabled(value:Boolean):void
		{
			if(value != !!_disabled){
        COMPILE::JS
        {
          toggle("is-disabled",value);
        }
      }
			_disabled = value;
    }
    private var _selected:Boolean;

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			if(value != !!_selected){
        COMPILE::JS
        {
          toggle("is-selected",value);
        }
      }
			_selected = value;
    }
    private var _heading:Boolean;

		public function get heading():Boolean
		{
			return _heading;
		}

		public function set heading(value:Boolean):void
		{
			if(value != !!_heading){
        COMPILE::JS
        {
          toggle(appendSelector("-heading"),value);
        }
      }
			_heading = value;
    }
    
    private var _icon:String;

    public function get icon():String
    {
    	return _icon;
    }

    public function set icon(value:String):void
    {
      if(value && !value != !_icon){
        var type:String = value;
        var iconElement:Icon = new Icon(Icon.getCSSTypeSelector(type));
        COMPILE::JS{
          _textNode.element.insertBefore(iconElement.element,_textNode.element.firstChild);
          _textNode.element.style.width = '100%';
        }
      }
    	_icon = value;
    }
  }
}