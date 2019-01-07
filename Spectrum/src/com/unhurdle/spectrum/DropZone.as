package com.unhurdle.spectrum
{
COMPILE::JS {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import com.unhurdle.spectrum.Icon;
    import org.apache.royale.html.elements.H2;
    import org.apache.royale.graphics.IDrawable;
    import org.apache.royale.graphics.IPath; //?
    import org.apache.royale.graphics.PathBuilder; //?
    import org.apache.royale.svg.Path; //?
    import google.maps.event;
    import org.apache.royale.events.Event;
    import org.apache.royale.events.DragEvent;
    import spark.primitives.Line;
    
  }
  public class DropZone extends SpectrumBase
  { 
    // public function DropZone(){
    //   super();
    //   typeNames = "spectrum-Dropzone";
    // }

    // private function valueToCSS(value:String):String{
    //     return "spectrum-Dropzone" + value;
    // }

    // private var header:TextNode;  //
    // private var illustratedMessageIllustration:Icon; //
    // private var paragraph:TextNode;
    // private var hyperlink:TextNode;
    // private var hyperlink2:TextNode; 


    // COMPILE::JS
    // private var illustratedMessage:HTMLDivElement; //
    //  COMPILE::JS
    // private var br:HTMLBRElement;
    //  COMPILE::JS
    // private var path1:SVGPathElement;
    //  COMPILE::JS
    // private var path2:SVGPathElement;
    //  COMPILE::JS
    // private var path3:SVGPathElement;
    //  COMPILE::JS
    // private var path4:SVGPathElement;
    //  COMPILE::JS
    // private var path5:SVGPathElement;
    //  COMPILE::JS
    // private var path6:SVGPathElement;
    //  COMPILE::JS
    // private var path7:SVGPathElement;
    //  COMPILE::JS
    // private var line1:SVGLineElement;
    //  COMPILE::JS
    // private var line2:SVGLineElement;
    //  COMPILE::JS
    // private var rect:SVGRectElement;
    //  COMPILE::JS
    // private var defs:SVGDefsElement; 
    //  COMPILE::SWF
    // private var illustratedMessage:Object; //
    //  COMPILE::SWF
    // private var header:TextNode;  //
    //  COMPILE::SWF
    // private var illustratedMessageIllustration:Icon; //
    //  COMPILE::SWF
    // private var paragraph:TextNode;
    //  COMPILE::SWF
    // private var hyperlink:TextNode; 
    //  COMPILE::SWF
    // private var hyperlink2:TextNode; 
    //  COMPILE::SWF
    // private var br:Object;
    //  COMPILE::SWF
    // private var path1:Object;
    //  COMPILE::SWF
    // private var path2:Object;
    //  COMPILE::SWF
    // private var path3:Object;
    //  COMPILE::SWF
    // private var path4:Object;
    //  COMPILE::SWF
    // private var path5:Object;
    //  COMPILE::SWF
    // private var path6:Object;
    //  COMPILE::SWF
    // private var path7:Object;
    //  COMPILE::SWF
    // private var line1:Object;
    //  COMPILE::SWF
    // private var line2:Object;
    //  COMPILE::SWF
    // private var rect:Object;
    //  COMPILE::SWF
    // private var defs:Object;

    // COMPILE::JS
    // private function elementDragged(ev:Event):void{
    //   toggle("is-dragged",true);
    // }
        
    // COMPILE::JS
    // override protected function createElement():WrappedHTMLElement{
    // addElementToWrapper(this,'div');
    // element.setAttribute("role","region"); //?
    // element.tabIndex = 0;
    // element.style.width = "300px";
    // element.addEventListener("drag",elementDragged); //?

    // illustratedMessage = newElement('div') as HTMLDivElement;
    // illustratedMessage.className = "spectrum-IllustratedMessage spectrum-IllustratedMessage--cta";
    // element.appendChild(illustratedMessage);

    // illustratedMessageIllustration = new Icon(null);//?no selector
    // illustratedMessageIllustration.getElement().style.width = "199";
    // illustratedMessageIllustration.getElement().style.height = "98";
    // illustratedMessageIllustration.getElement().setAttribute("viewBox", "0 0 199 97.7"); 
    
    // //   <defs> //help here 
    // // 	<style>
    //  //.cls-1,
		// //.cls-2{
    //   //fill:none;stroke-linecap:round;stroke-linejoin:round; //no .fill ....
    //   //}
    //   //.cls-1{
    //     //stroke-width:3px;
    //     //}
    //   //.cls-2{
    //     //stroke-width:2px;
    //     //}
		// // 	</style>
		// // </defs>
    
    // path1 = document.createElementNS('http://www.w3.org/2000/svg', 'path') as SVGPathElement;
    // path1.className = "cls-1";
    // path1.setAttribute("d","M240,4v8c0,2.3-1.9,4.1-4.2,4L1,9C0.4,9,0,8.5,0,8c0-0.5,0.4-1,1-1l234.8-7C238.1-0.1,240,1.7,240,4z");
    // illustratedMessageIllustration.getElement().appendChild(path1);
    
    // line1 = document.createElementNS('http://www.w3.org/2000/svg', 'line') as SVGLineElement;

		// // 		<line class="cls-1" x1="99.5" y1="95.5" x2="99.5" y2="58.5"/> 
    // // line1 = new SVGLineElement(); //illegal constructor
    // // line1.className = "cls-1";
    // //illustratedMessageIllustration.getElement().appendChild(line1);

	
    // path2 = document.createElementNS('http://www.w3.org/2000/svg', 'path') as SVGPathElement;
    // path2.className = "cls-1";
    // path2.setAttribute("d","M105.5,73.5h19a2,2,0,0,0,2-2v-43");
    // illustratedMessageIllustration.getElement().appendChild(path2);

		// path3 = document.createElementNS('http://www.w3.org/2000/svg', 'path') as SVGPathElement;
    // path3.className = "cls-1";
    // path3.setAttribute("d","M126.5,22.5h-19a2,2,0,0,1-2-2V1.5h-31a2,2,0,0,0-2,2v68a2,2,0,0,0,2,2h19");
    // illustratedMessageIllustration.getElement().appendChild(path3);

		// // 		<line class="cls-1" x1="105.5" y1="1.5" x2="126.5" y2="22.5"/>
    // //illustratedMessageIllustration.getElement().appendChild(line2);

		// path4 = document.createElementNS('http://www.w3.org/2000/svg', 'path') as SVGPathElement;
    // path4.className = "cls-2";
    // path4.setAttribute("d","M47.93,50.49a5,5,0,1,0-4.83-5A4.93,4.93,0,0,0,47.93,50.49Z");
    // illustratedMessageIllustration.getElement().appendChild(path4);

		// path5 = document.createElementNS('http://www.w3.org/2000/svg', 'path') as SVGPathElement;
    // path5.className = "cls-2";
    // path5.setAttribute("d","M36.6,65.93,42.05,60A2.06,2.06,0,0,1,45,60l12.68,13.2");
    // illustratedMessageIllustration.getElement().appendChild(path5);

		// path6 = document.createElementNS('http://www.w3.org/2000/svg', 'path') as SVGPathElement;
    // path6.className = "cls-2";
    // path6.setAttribute("d","M3.14,73.23,22.42,53.76a1.65,1.65,0,0,1,2.38,0l19.05,19.7");
    // illustratedMessageIllustration.getElement().appendChild(path6);

	  // path7 = document.createElementNS('http://www.w3.org/2000/svg', 'path') as SVGPathElement;
    // path7.className = "cls-1";
    // path7.setAttribute("d","M139.5,36.5H196A1.49,1.49,0,0,1,197.5,38V72A1.49,1.49,0,0,1,196,73.5H141A1.49,1.49,0,0,1,139.5,72V32A1.49,1.49,0,0,1,141,30.5H154a2.43,2.43,0,0,1,1.67.66l6,5.66");
    // illustratedMessageIllustration.getElement().appendChild(path7);

		// rect = document.createElementNS('http://www.w3.org/2000/svg', 'rect') as SVGRectElement;
    // rect.className = "cls-1";
    // rect.setAttribute("x",1.5);
    // rect.setAttribute("y",34.5);
    // rect.setAttribute("width",58);
    // rect.setAttribute("height",39);
    // rect.setAttribute("rx",2);
    // rect.setAttribute("ry",2);
    // illustratedMessageIllustration.getElement().appendChild(rect);

    // illustratedMessage.appendChild(illustratedMessageIllustration.getElement());
    
    // header = new TextNode("");
    // header.element = newElement("h2") as HTMLHeadingElement;
    // header.className = "spectrum-Heading spectrum-Heading--pageTitle spectrum-IllustratedMessage-heading";
    // header.text = "Drag and Drop Your File";
    // element.appendChild(header.element);

    // paragraph = new TextNode("");
    // paragraph.element = newElement("p") as HTMLParagraphElement;  
    // paragraph.className = "spectrum-Body--secondary spectrum-IllustratedMessage-description";
    // element.appendChild(paragraph.element);

    // hyperlink = new TextNode("");
    // hyperlink.element = newElement("a") as HTMLLinkElement; //confused why its a <a> if its getting the file from the computer
    // (hyperlink as HTMLLinkElement).href ="#"; //not really an href .....
    // hyperlink.className = "spectrum-Link";
    // hyperlink.text = "Select a File"; 
    // paragraph.element.appendChild(hyperlink.element);
    // paragraph.text = "from your computer ";  //not displaying
    
    // br = newElement("br") as HTMLBRElement;
    // paragraph.element.appendChild(br);

    // paragraph.text = "or ";  //in the wrong spot

    // hyperlink2 = new TextNode("");
    // hyperlink2.element = newElement("a") as HTMLLinkElement; //opens the site .. but instead of the MAMP page dunno how its supposed to work
    // hyperlink2.element.setAttribute("href","https://stock.adobe.com/"); //gets there but cant check for real cuz its blocked on my filter
    // hyperlink2.className = "spectrum-Link";
    // hyperlink2.text = "Search Adobe Stock"; 
    // paragraph.element.appendChild(hyperlink2.element);
    
    // return element;
    // }
    // private function getDropZoneMarkup():String{
    //   return '<svg class="spectrum-IllustratedMessage-illustration" width="199" height="98" viewBox="0 0 199 97.7"><defs><style>.cls-1,.cls-2{fill:none;stroke-linecap:round;stroke-linejoin:round;}.cls-1{stroke-width:3px;}.cls-2{stroke-width:2px;}</style></defs><path class="cls-1" d="M110.53,85.66,100.26,95.89a1.09,1.09,0,0,1-1.52,0L88.47,85.66"></path><line class="cls-1" x1="99.5" y1="95.5" x2="99.5" y2="58.5"></line><path class="cls-1" d="M105.5,73.5h19a2,2,0,0,0,2-2v-43"></path><path class="cls-1" d="M126.5,22.5h-19a2,2,0,0,1-2-2V1.5h-31a2,2,0,0,0-2,2v68a2,2,0,0,0,2,2h19"></path><line class="cls-1" x1="105.5" y1="1.5" x2="126.5" y2="22.5"></line><path class="cls-2" d="M47.93,50.49a5,5,0,1,0-4.83-5A4.93,4.93,0,0,0,47.93,50.49Z"></path><path class="cls-2" d="M36.6,65.93,42.05,60A2.06,2.06,0,0,1,45,60l12.68,13.2"></path><path class="cls-2" d="M3.14,73.23,22.42,53.76a1.65,1.65,0,0,1,2.38,0l19.05,19.7"></path><path class="cls-1" d="M139.5,36.5H196A1.49,1.49,0,0,1,197.5,38V72A1.49,1.49,0,0,1,196,73.5H141A1.49,1.49,0,0,1,139.5,72V32A1.49,1.49,0,0,1,141,30.5H154a2.43,2.43,0,0,1,1.67.66l6,5.66"></path><rect class="cls-1" x="1.5" y="34.5" width="58" height="39" rx="2" ry="2"></rect></svg>';
    // }
  }
}