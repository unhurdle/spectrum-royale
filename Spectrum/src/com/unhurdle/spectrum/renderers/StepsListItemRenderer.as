package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.util.getLabelFromData;
  import com.unhurdle.spectrum.StepsListItem;
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.newElement;
  import com.unhurdle.spectrum.Link;
  public class StepsListItemRenderer extends DataItemRenderer
  {
    public function StepsListItemRenderer()
    {
      super();
      typeNames = '';
    }
  //   <div class="spectrum-Steplist-item u-tooltip-showOnHover is-complete">
  //   <div class="spectrum-Steplist-markerContainer">
  //     <div class="spectrum-Tooltip spectrum-Tooltip--top">
  //       <span class="spectrum-Tooltip-label">Step 1</span>
  //       <span class="spectrum-Tooltip-tip"></span>
  //     </div>
  //     <div class="spectrum-Steplist-marker">
  //     </div>
  //   </div>

  //   <span class="spectrum-Steplist-segment">
  //   </span>
  // </div>
    override protected function getSelector():String{
      return "spectrum-Steplist";
    }

    override public function set data(value:Object):void{
      super.data = value;
      var elem:HTMLElement = element as HTMLElement;
      var stepsListItem:StepsListItem = value as StepsListItem;
      toggle(appendSelector("-item"),true);
      // elem.style.pointerEvents = null
      if(stepsListItem.interactive){
        var link:HTMLElement = newElement("a",appendSelector("-link"))
        link.tabIndex = -1;
        link.appendChild(markerContainer);
        elem.insertBefore(link,segment);
      } else {
        elem.insertBefore(markerContainer,segment);
      }
      // if(stepsListItem.selected){
      //   elem.classList.add("is-selected");
      // } else {
      //   elem.classList.remove("is-selected");
      // }
      if(stepsListItem.completed){
        elem.classList.add("is-complete");
      } else {
        elem.classList.remove("is-complete");
      }
      if(!!stepsListItem.text){
        var label:TextNode = new TextNode("");
        // label.element = newElement("span","spectrum-Steplist-label");
        // label.text = stepsListItem.text;
        // label.text = getLabelFromData(this,value);
        // elem.appendChild(label.element);
        if(!!stepsListItem.toolTip){
          elem.classList.add("u-tooltip-showOnHover");
          // var toolTipDiv:ShowOnOverTooltip = new ShowOnOverTooltip();
          // var toolTipDiv:ShowOnOverTooltip = new ShowOnOverTooltip();
          // toolTipDiv.direction = "top";
          // toolTipDiv.text = stepsListItem.text;
          var toolTipDiv:HTMLDivElement = newElement("div","spectrum-Tooltip spectrum-Tooltip--top") as HTMLDivElement;
          label.element = newElement("span","spectrum-Tooltip-label");
          label.text = stepsListItem.text;
          toolTipDiv.appendChild(label.element);
          var toolTipSpan:HTMLSpanElement = newElement("span","spectrum-Tooltip-tip") as HTMLSpanElement;
          toolTipDiv.appendChild(toolTipSpan);
          markerContainer.insertBefore(toolTipDiv,marker);
        }
        else{
          label.element = newElement("span","spectrum-Steplist-label");
          label.text = stepsListItem.text;
          elem.insertBefore(label.element,markerContainer);      
        }
        // label.text = stepsListItem.text;
      //   elem.classList.remove("is-complete");
      }
      // if(!!stepsListItem.toolTip){
      //   label = new TextNode("");
      //   label.element = newElement("span","spectrum-Steplist-label");
      //   label.text = stepsListItem.text;
      //   // label.text = getLabelFromData(this,value);
      //   // elem.appendChild(label.element);
      //   elem.insertBefore(label.element,markerContainer || null);
      // }
      // else {
      //   if(!!stepsListItem.text){
      //     label = new TextNode("");
      //     label.element = newElement("span","spectrum-Steplist-label");
      //     label.text = stepsListItem.text;
      //     // label.text = getLabelFromData(this,value);
      //     // elem.appendChild(label.element);
      //     elem.insertBefore(label.element,markerContainer || null);
      //   }
      // //   elem.classList.remove("is-complete");
      // }
      // textNode.text = getLabelFromData(this,value);
    }
    private var markerContainer:HTMLSpanElement;
    private var marker:HTMLSpanElement;
    private var segment:HTMLSpanElement
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      // elem.className = appendSelector("-item");
      markerContainer = document.createElement("span") as HTMLSpanElement;
      markerContainer.className = appendSelector("-markerContainer");
      marker = document.createElement("span") as HTMLSpanElement;
      marker.className = appendSelector("-marker");
      markerContainer.appendChild(marker);
      segment = document.createElement("span") as HTMLSpanElement;
      segment.className = appendSelector("-segment");
      elem.appendChild(segment);
      return elem;
    }
  }
}