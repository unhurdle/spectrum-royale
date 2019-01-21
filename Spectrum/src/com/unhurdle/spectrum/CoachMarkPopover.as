package com.unhurdle.spectrum
{
  COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.html.elements.Img;
    }
  public class CoachMarkPopover extends SpectrumBase
  {
    public function CoachMarkPopover()
    {
      super();
    }
    override protected function getSelector():String{
        return "spectrum-CoachMarkPopover";
    }
    private var title:TextNode;
    private var content:TextNode;
    private var step:TextNode;
    private var footer:HTMLDivElement;
    private var header:HTMLDivElement;
    private var imageElement:HTMLImageElement;
    private var nextButton:Button;
    private var skipTourButton:Button;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
        var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
        width = 400;
        header = newElement("div",appendSelector("-header")) as HTMLDivElement;
        title = new TextNode("");
        title.element = newElement("div",appendSelector("-title"));
        header.appendChild(title.element);
        elem.appendChild(header);
        content = new TextNode("");
        content.element = newElement("div",appendSelector("-content"));
        elem.appendChild(content.element);
        footer = newElement("div",appendSelector("-footer")) as HTMLDivElement;
        elem.appendChild(footer);
        return elem;
    }
    
        private var _isAbsolute:Boolean;

        public function get isAbsolute():Boolean
        {
        	return _isAbsolute;
        }

        public function set isAbsolute(value:Boolean):void
        {
        	_isAbsolute = value;
          positionElements();
        }
        private var _isOkayButton:Boolean;

        public function get isOkayButton():Boolean
        {
        	return _isOkayButton;
        }

        public function set isOkayButton(value:Boolean):void
        {
        	_isOkayButton = value;
          positionElements();
        }
        private var _isTwoButtons:Boolean;

        public function get isTwoButtons():Boolean
        {
        	return _isTwoButtons;
        }

        public function set isTwoButtons(value:Boolean):void
        {
        	_isTwoButtons = value;
          positionElements();
        }
        private var _isStep:Boolean;
        public function get isStep():Boolean
        {
        	return _isStep;
        }
        public function set isStep(value:Boolean):void
        {
        	_isStep = value;
          positionElements();
        }
        private var _isImg:Boolean;
        public function get isImg():Boolean
        {
        	return _isImg;
        }
        public function set isImg(value:Boolean):void
        {
        	_isImg = value;
          positionElements();
        }
        private var _titleText:String;
        public function get titleText():String
        {
        	return _titleText;
        }
        public function set titleText(value:String):void
        {
        	_titleText = value;
          title.text = value;
        }
        private var _contentText:String;
        public function get contentText():String
        {
        	return _contentText;
        }
        public function set contentText(value:String):void
        {
        	_contentText = value;
          content.text = value;
        }
    private var _src:String;

    public function get src():String
    {
    	return _src;
    }
        public function set src(value:String):void
        {
          if(value == _src){
            return;
          }
          imageElement.src = value;
          _src = value;
        }
        protected function positionElements():void{
          COMPILE::JS
          {          
            if(isAbsolute){
              element.style.position = "absolute";
              element.style.marginLeft = "34px";
            }
            else{
              element.style.position = "relative";
              element.style.position = "0px";
            }
            if(!footer.children.length){
              if(isTwoButtons){
                skipTourButton = new Button();
                skipTourButton.text = "Skip Tour";
                skipTourButton.flavor = "secondary";
                skipTourButton.quiet = true;
                skipTourButton.addEventListener("click",skipTourPage);
                footer.appendChild(skipTourButton.element);
                nextButton = new Button();
                nextButton.text = "Next";
                nextButton.flavor = "primary";
                nextButton.addEventListener("click",nextPage);
                footer.appendChild(nextButton.element);
              }
              if(isOkayButton){
                var button:Button = new Button();
                button.text = "Okay";
                button.flavor = "primary";
                footer.appendChild(button.element);
              }
            }
            if(isStep){
              step = new TextNode("");
              step.element = newElement("div", appendSelector("-step"));
              header.appendChild(step.element);
            }
            if(isImg){
              imageElement = newElement("img",appendSelector("-image")) as HTMLImageElement;
              imageElement.src = src;
              element.insertBefore(imageElement, element.childNodes[0] || null);
            }
          }
        }
        private function skipTourPage():void
        {
          pageIsSelected = pagesNum;
        }
        private function nextPage():void{
          pageIsSelected < pagesNum? pageIsSelected++: pageIsSelected = pagesNum;
        }
    private function enableOrDisable():void{
      pageIsSelected == pagesNum? nextButton.disabled = true: nextButton.disabled = false
      skipTourButton.disabled = nextButton.disabled;
        if(step){
          step.text = pageIsSelected + " of " + pagesNum;
        }
    }
    
    private var _pageIsSelected:Number = 2;

    public function get pageIsSelected():Number
    {
    	return _pageIsSelected;
    }

    public function set pageIsSelected(val:Number):void
    {
      if(val && val <= pagesNum){
      	_pageIsSelected = val;
      }
      enableOrDisable();
    }
    private var _pagesNum:int = 1;

    public function get pagesNum():int
    {
    	return _pagesNum;
    }

    public function set pagesNum(val:int):void
    {
        if(val != _pagesNum){
        	_pagesNum = val;
        }
        enableOrDisable();
    }
  }
}