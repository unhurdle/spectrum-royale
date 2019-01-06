package com.unhurdle.spectrum
{
   COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  public class Rule extends SpectrumBase
  {
    public function Rule()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Rule";
    }
    private var header:TextNode;
    private var rule:HTMLHeadingElement;
    private var p:TextNode;
    
    override public function addedToParent():void{
			super.addedToParent();
			changeElement("large");
    }

		protected function changeElement(s:String):void{
			COMPILE::JS
			{
        switch (s){
        case "small":header.element = newElement("h4") as HTMLHeadingElement;
                      header.element.className = "spectrum-Heading--subtitle3";
                      break;
        case "medium":header.element = newElement("h3") as HTMLHeadingElement;
                      header.element.className = "spectrum-Heading--subtitle2";
                      break;
        case "large":header.element = newElement("h2") as HTMLHeadingElement;
                      header.element.className = "spectrum-Heading--subtitle1";
                      break;
        default:
            throw new Error("Invalid size: " + s);
        }
        header.text = s;
			}
		}
     COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,"div");
      header = new TextNode("");
      header.element = newElement("h2") as HTMLHeadingElement;// need to be h2 / h3 /h4
      header.element.className = "spectrum-Heading--subtitle1";
      elem.appendChild(header.element);
      rule = newElement("hr") as HTMLHeadingElement;
      rule.className = "spectrum-Rule";
      elem.appendChild(rule);
      p = new TextNode("");
      p.element = newElement("p") as HTMLParagraphElement;
      p.element.className = "spectrum-Body";
      elem.appendChild(p.element);
      return elem;
    }
    
        private var _size:String;

        public function get size():String
        {
            return _size;
        }

        public function set size(value:String):void
        {
            if(value != _size){
                switch (value){
                  case "small":p.text = "Divide like-elements (tables, tool groups, elements within a panel, etc.)";
                  case "medium":p.text = "Divide subsections, or divide different groups of elements (between panels, rails, etc.)";
                  case "large":p.text = "Page or Section Titles.";
                      break;
                  default:
                      throw new Error("Invalid size: " + value);
                }
                changeElement(value);
                var oldSize:String = valueToSelector(_size);
                var newSize:String = valueToSelector(value);
                toggle(newSize, true);
                toggle(oldSize, false);
                _size = value;
            }
        }
  }
}