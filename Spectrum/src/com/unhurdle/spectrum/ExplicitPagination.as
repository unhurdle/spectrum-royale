package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import com.unhurdle.spectrum.const.IconType;
    import com.unhurdle.spectrum.includes.ActionButtonInclude;
    import com.unhurdle.spectrum.includes.ActionButtonInclude;
  }
  public class ExplicitPagination extends SpectrumBase
  {
    public function ExplicitPagination()
    {
      super();
      toggle(valueToSelector("explicit"),true);
      pagesNum = 1;
      selectedPage = 1;
    }
    override protected function getSelector():String{
				return "spectrum-Pagination";
		}

    private var span:TextNode;
    private var prev:HTMLLinkElement;
    private var next:HTMLLinkElement;
    private var textField:TextField;

    override protected function getTag():String{
      return "nav";
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      var buttonBase:String = ActionButtonInclude.getSelector();
      prev = newElement("a",buttonBase) as HTMLLinkElement;
      prev.classList.toggle(appendSelector("-prevButton"),true);
      prev.classList.toggle(ActionButtonInclude.getSelector() + "--quiet",true);
      var prevType:String = IconType.CHEVRON_LEFT_MEDIUM;
      var prevCheckIcon:Icon = new Icon(Icon.getCSSTypeSelector(prevType));
      prevCheckIcon.type = prevType;
      prev.appendChild(prevCheckIcon.element);
      prev.addEventListener("click",prevPage);
      elem.appendChild(prev);
      textField = new TextField();
      textField.text = "" + selectedPage;
      textField.addEventListener("change",changeValue);
      elem.appendChild(textField.element);
      span = new TextNode("");
      span.element = newElement("span","spectrum-Body--secondary" + appendSelector("-counter"));
      span.element.style.marginLeft = '6px';
      elem.appendChild(span.element);
      next = newElement("a",buttonBase) as HTMLLinkElement;
      next.classList.toggle(appendSelector("-nextButton"),true);
      next.classList.toggle(ActionButtonInclude.getSelector() + "--quiet",true);
      var nextType:String = IconType.CHEVRON_RIGHT_MEDIUM;
      var nextCheckIcon:Icon = new Icon(Icon.getCSSTypeSelector(nextType));
      nextCheckIcon.type = nextType;
      next.appendChild(nextCheckIcon.element);
      next.addEventListener("click",nextPage);
      elem.appendChild(next);
      return elem;
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
    
    private var _selectedPage:Number;

    public function get selectedPage():Number
    {
    	return _selectedPage;
    }

    public function set selectedPage(val:Number):void
    {
      if(val && val <= pagesNum){
      	_selectedPage = val;
      }
      enableOrDisable();
      textField.text = "" + _selectedPage;
    }
    private var _pagesNum:int;

    public function get pagesNum():int{
    	return _pagesNum;
    }

    public function set pagesNum(val:int):void
    {
        if(val != !!_pagesNum){
        	_pagesNum = val;
        }
      enableOrDisable();
      span.text = "  of  " + _pagesNum + "  pages";
    }

    private function changeValue():void{
      COMPILE::JS{
        if(Number(textField.text) > pagesNum){
          textField.text = "" + pagesNum;
        }
        if(Number(textField.text) < 0){
          textField.text = "1";
        }
        selectedPage = Number(textField.text);
      }
    }
  }
}