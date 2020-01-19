package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.events.Event;
  }
  public class PagePagination extends SpectrumBase
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/pagination/dist.css">
     * </inject_html>
     * 
     */
    public function PagePagination()
    {
      super();
      toggle(valueToSelector("listing"),true);
    }
    override protected function getSelector():String{
				return "spectrum-Pagination";
		}

    private var prew:HTMLLinkElement;
    private var next:HTMLLinkElement;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,"nav");
      var buttonBase:String = "spectrum-Button spectrum-Button--primary spectrum-Button--quiet ";
      prew = newElement("a",buttonBase+appendSelector("-prevButton")) as HTMLLinkElement
      var prewSpan:TextNode = new TextNode("");
      prewSpan.element = newElement("span","spectrum-Button-label") as HTMLSpanElement;
      prewSpan.text = "prew";
      prew.appendChild(prewSpan.element);
      prew.addEventListener("click",prewPage);
      elem.appendChild(prew);
      next = newElement("a",buttonBase + appendSelector("-nextButton")) as HTMLLinkElement
      var nextSpan:TextNode = new TextNode("");
      nextSpan.element = newElement("span","spectrum-Button-label") as HTMLSpanElement;
      nextSpan.text = "next";
      next.appendChild(nextSpan.element);
      next.addEventListener("click",nextPage);
      elem.appendChild(next);
      return elem;
    }
    private var _href:String;

    public function get href():String
    {
    	return _href;
    }

    public function set href(value:String):void
    {
      if(value){
      	_href = value;
      } else {
        _href = "#";
        }
    }
    private var _selected:Boolean = false;

    public function get selected():Boolean
    {
    	return _selected;
    }

    public function set selected(value:Boolean):void
    {
      if(value){
      	_selected = value;
        COMPILE::JS{
          findChild(element.children);
        }
      }
    }
    private function findChild(children:NodeList):void{
       for each(var selectedChild:Element in children){
          if(selectedChild.text && selectedChild.text == "" + pageIsSelected){
            selectedChild.classList.add("is-selected");
          }
          else{
            if(selectedChild.classList && selectedChild.classList.contains("is-selected")){
                selectedChild.classList.remove("is-selected");
            }
            else
            {
              if(selectedChild.children && selectedChild.children.length){
                findChild(selectedChild.children)
              }
            }
          }
        }
    }
    private function prewPage():void{
      pageIsSelected > 1? pageIsSelected--: pageIsSelected = 1;
    }
    private function nextPage():void{
      pageIsSelected < pagesNum? pageIsSelected++: pageIsSelected = pagesNum;
    }
    private function enableOrDisable():void{
      pageIsSelected == 1? prew.classList.add("is-disabled"): prew.classList.remove("is-disabled");
      pageIsSelected == pagesNum? next.classList.add("is-disabled"): next.classList.remove("is-disabled");
    }
    
    private var _pageIsSelected:Number = 2;

    public function get pageIsSelected():Number
    {
    	return _pageIsSelected;
    }

    public function set pageIsSelected(val:Number):void
    {
      if(val){
      	_pageIsSelected = val;
        selected = true;
        enableOrDisable();
      }
    }
    private var _pagesNum:int;

    public function get pagesNum():int
    {
    	return _pagesNum;
    }

    public function set pagesNum(val:int):void
    {
        if(val != _pagesNum){
        	_pagesNum = val;
            for(var i:int=0;i<val;i++){
              //TODO use ActionButton?
                var link:HTMLElement = newElement("a","spectrum-ActionButton spectrum-ActionButton--quiet");
                link.setAttribute("href","#");
                var node:TextNode = new TextNode("span");
                node.className = "spectrum-ActionButton-label";
                node.text = "" + (i + 1);
                link.appendChild(node.element);
                link.addEventListener("click",changeValue);
                COMPILE::JS{
                  element.insertBefore(link,next);
                }
            }
        }
    }

    private function changeValue(ev:Event):void
    {
      COMPILE::JS{
        pageIsSelected = Number(ev.target.textContent);
      }
    }
  }
}