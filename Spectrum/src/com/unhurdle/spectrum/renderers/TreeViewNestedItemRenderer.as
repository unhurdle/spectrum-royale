package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  import com.unhurdle.spectrum.newElement;
  import com.unhurdle.spectrum.Icon;
  import com.unhurdle.spectrum.TreeViewNestedItem;
  import com.unhurdle.spectrum.const.IconType;
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.TreeViewNested;
  import goog.events.Event;
  // import createjs.MouseEvent;

  
  public class TreeViewNestedItemRenderer extends DataItemRenderer
  {
    public function TreeViewNestedItemRenderer()
    {
      super();
      typeNames = '';
    }
    protected function appendSelector(value:String):String{
      return "spectrum-TreeView" + value;
    }
    // protected var classList:CSSClassList;
    //from spectrumBase but added in elem before .add and .remove
    protected function toggle(classNameVal:String,add:Boolean):void{
    // protected function toggle(elem:HTMLElement,classNameVal:String,add:Boolean):void{
      COMPILE::JS{
        trace("element - toggle");
        trace(element);
        add? element.classList.add(classNameVal) : element.classList.remove(classNameVal);
        // add? elem.classList.add(classNameVal) : elem.classList.remove(classNameVal);
        (element as TreeViewNestedItem).opened = add;
        // (elem as TreeViewNestedItem).opened = add;
      }
    }
    private var icon:Icon;
    private var link:TextNode;
    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value
      var elem:HTMLElement = element as HTMLElement;
      var treeViewNestedItem:TreeViewNestedItem = value as TreeViewNestedItem;
      elem.className += appendSelector("-item");
      link.element.setAttribute("href",treeViewNestedItem.href || "#");
      link.text =treeViewNestedItem.text;
      elem.appendChild(link.element);
      if(!!treeViewNestedItem.isList){
        var type:String = IconType.CHEVRON_RIGHT_MEDIUM;
        icon = new Icon(Icon.getCSSTypeSelector(type));
        icon.type = type;
        icon.className += "spectrum-TreeView-indicator";
        // icon.addEventListener("click",openOrClose);
        elem.addEventListener("click",openOrClose);
        link.element.insertBefore(icon.element,link.element.firstChild || null);
        var ul:TreeViewNested = new TreeViewNested();
        ul.dataProvider = treeViewNestedItem.dataProvider;
        addElement(ul);
      }
      if(treeViewNestedItem.opened){
        toggle("is-open",true);
        // toggle(elem,"is-open",true);
        icon.element.style.transform = "rotate("+90+"deg)";
      } else {
        // toggle(elem,"is-open",false);
        toggle("is-open",false);
      }
    }
    private function openOrClose(event:Event):void{
      var styleStr:String;
      COMPILE::JS{
        var el:HTMLElement = event.target.closest('.spectrum-TreeView-item');
        if(el != null){
          // if(el.parentElement.parentElement.className == "spectrum-TreeView-item"){
          // // if(el.parentElement.parentElement.classList.contains('is-open')){
          //   notOpenOrClose(el.parentElement.parentElement,event);
          // }
          if(el.parentElement.parentElement.className == "royale"){
          // if(el.parentElement.parentElement.classList.contains('is-open')){
            toggle('is-open',el.children[1].classList.contains("is-open"));
          }
          else{
            notOpenOrClose(el.parentElement.parentElement,event);
            // if(el.parentElement.parentElement.classList.contains("is-open")){
            //   el.parentElement.parentElement.classList.remove('is-open');
            // }else{
            //   el.parentElement.parentElement.classList.add('is-open');
            // }
          }
          // else{
            if(el.classList.contains('is-open')){
              toggle('is-open',false);
              // toggle(el,'is-open',false);
              styleStr="transform:rotate("+0+"deg)";
              // icon.element.style.transform = "rotate("+0+"deg)";
            }else{
              toggle('is-open',true);
              // toggle(el,'is-open',true);
              styleStr="transform:rotate("+90+"deg)";
              // icon.element.style.transform = "rotate("+90+"deg)";
            }
            icon.element.setAttribute("style",styleStr);
          // }
          // event.preventDefault();
        }
      }      
    }
    private function notOpenOrClose(el:Element, event:Event):void{
      var styleStr:String;
      COMPILE::JS{
      //   if(el.classList.contains('is-open')){
      //       toggle('is-open',false);
      //       styleStr="transform:rotate("+0+"deg)";
      //       // icon.element.style.transform = "rotate("+0+"deg)";
      //     }else{
      //       toggle('is-open',true);
      //       styleStr="transform:rotate("+90+"deg)";
      //       // icon.element.style.transform = "rotate("+90+"deg)";
      //     }
        if(el == event.target.closest('.spectrum-TreeView-item')){
          // if(el.classList.contains('is-open')){
            toggle('is-open',!(el.children[1].classList.contains("is-open")));
            // toggle('is-open',false);
            // styleStr="transform:rotate("+0+"deg)";
        //     // icon.element.style.transform = "rotate("+0+"deg)";
        //   }else{
        //     toggle('is-open',true);
        //     styleStr="transform:rotate("+90+"deg)";
        //     // icon.element.style.transform = "rotate("+90+"deg)";
        //   }
        // // if(el.parentElement.parentElement.classList.contains('is-open')){
        icon.element.setAttribute("style",styleStr);
          notOpenOrClose(el.parentElement.parentElement, event);
         } 
          // if(el.children[1].classList.contains('is-open')){
          // // if(el.parentElement.parentElement.classList.contains('is-open')){
          //   toggle('is-open',false);
            
          //   styleStr="transform:rotate("+0+"deg)";
          //   // icon.element.style.transform = "rotate("+0+"deg)";
          // }else{
          //   toggle('is-open',true);
          //   styleStr="transform:rotate("+90+"deg)";
          //   // icon.element.style.transform = "rotate("+90+"deg)";
          // }
          // icon.element.setAttribute("style",styleStr);
        
        // else{
        //   if(el.classList.contains('is-open')){
        //     toggle('is-open',false);
        //     styleStr="transform:rotate("+0+"deg)";
        //     // icon.element.style.transform = "rotate("+0+"deg)";
        //   }else{
        //     toggle('is-open',true);
        //     styleStr="transform:rotate("+90+"deg)";
        //     // icon.element.style.transform = "rotate("+90+"deg)";
        //   }
        //   // icon.element.setAttribute("style",styleStr);
        // }
      }
    }
    // private var flag:Boolean = true;    
    // private function openOrClose(event:Event):void{
    //   COMPILE::JS{
    //     var el:HTMLElement = event.target.closest('.spectrum-TreeView-item');
    //     // var flag:Boolean = true;
    //     trace("el");
    //     trace(el);
    //     trace("el.children");
    //     trace(el.children);
    //     trace("el.classList");
    //     trace(el.classList);
    //     trace("el.parentElement.parentElement");
    //     trace(el.parentElement.parentElement);
    //     trace("event");
    //     trace(event);
    //     trace("event.target");
    //     trace(event.target);
    //     trace("event.currentTarget");
    //     trace(event.currentTarget);
    //     trace("event.hasOwnProperty('is-open')");
    //     trace(event.hasOwnProperty('is-open'));
    //     // if (el!== null){
    //     // if ( (el = event.target.closest('.spectrum-TreeView-item')) !== null) {
    //       // if(event.target.parentElement.classList.contains('is-open')){
    //         trace("el!== null");
    //         trace(el!== null);
    //         trace("el.parentElement.parentElement != event.target.closest('.spectrum-TreeView-item')");
    //         trace(el.parentElement.parentElement != event.target.closest('.spectrum-TreeView-item'));
    //         trace("el.classList.contains('is-open')");
    //         trace(el.classList.contains('is-open'));
    //         trace("el.parentElement.parentElement.classList.contains('is-open')");
    //         trace(el.parentElement.parentElement.classList.contains('is-open'));
    //       if(el!== null && (el.parentElement.parentElement != event.target.closest('.spectrum-TreeView-item') && (el.classList.contains('is-open'))) || (el.parentElement.parentElement.classList.contains('is-open'))){
    //       // if((el as TreeViewNestedItem).opened){
    //       // if(flag && (el as TreeViewNestedItem).opened){
    //       // if(el.classList.contains('is-open')){
    //         toggle(el,'is-open',false);
    //         icon.element.style.transform = "rotate("+0+"deg)";
    //       }else{
    //         toggle(el,'is-open',true);
    //         icon.element.style.transform = "rotate("+90+"deg)";
    //         // flag = false;
    //         // return;
    //       }
    //       // event.preventDefault();
    //     // }
        
    //     // // if ( (el = event.target.closest('.spectrum-TreeView-item')) !== null) {
    //     //   if((element as TreeViewNestedItem).opened){
    //     //   // if(flag && (element as TreeViewNestedItem).opened){
    //     //   // if(el.classList.contains('is-open')){
    //     //     toggle(element,'is-open',false);
    //     //     icon.element.style.transform = "rotate("+0+"deg)";
    //     //   }else{
    //     //     toggle(element,'is-open',true);
    //     //     icon.element.style.transform = "rotate("+90+"deg)";
    //     //     // flag = false;
    //     //     // return;event.target.parentElement.classList
    //     //   }
    //       event.preventDefault();
    //     // // }
    //   }      
    // }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'li');
      link = new TextNode("");
      link.element = newElement("a",appendSelector("-itemLink"));
      // elem.appendChild(link.element);
      // !!ul? addElement(ul): null;
      return elem; 
    }   
  }
}
