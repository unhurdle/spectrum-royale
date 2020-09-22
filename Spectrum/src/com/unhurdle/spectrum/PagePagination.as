package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.events.Event;
  }
  import com.unhurdle.spectrum.includes.ActionButtonInclude;
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

    private var prev:HTMLLinkElement;
    private var next:HTMLLinkElement;

    override protected function getTag():String{
      return "nav";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      var buttonBase:String = "spectrum-Button spectrum-Button--primary spectrum-Button--quiet ";
      prev = newElement("a",buttonBase+appendSelector("-prevButton")) as HTMLLinkElement
      var prevSpan:TextNode = new TextNode("");
      prevSpan.element = newElement("span","spectrum-Button-label") as HTMLSpanElement;
      prevSpan.text = "prev";
      prev.appendChild(prevSpan.element);
      prev.addEventListener("click",prevPage);
      elem.appendChild(prev);
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
        _href = "";
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
          if(selectedChild.text && selectedChild.text == "" + selectedPage){
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
    private function prevPage():void{
      selectedPage > 1? selectedPage--: selectedPage = 1;
    }
    private function nextPage():void{
      selectedPage < pagesNum? selectedPage++: selectedPage = pagesNum;
    }
    private function enableOrDisable():void{
      selectedPage == 1? prev.classList.add("is-disabled"): prev.classList.remove("is-disabled");
      selectedPage == pagesNum? next.classList.add("is-disabled"): next.classList.remove("is-disabled");
    }
    
    private var _selectedPage:Number = 2;

    public function get selectedPage():Number
    {
    	return _selectedPage;
    }

    public function set selectedPage(val:Number):void
    {
      if(val){
      	_selectedPage = val;
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
                var actionButtonSelector:String = ActionButtonInclude.getSelector();
                var link:HTMLElement = newElement("a",actionButtonSelector);
                link.classList.toggle(actionButtonSelector + "--quiet");
                var node:TextNode = new TextNode("span");
                node.className = actionButtonSelector + "-label";
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
        selectedPage = Number(ev.target.textContent);
      }
    }
  }
}