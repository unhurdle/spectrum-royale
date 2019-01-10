package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  public class DatePicker extends SpectrumBase
  {
    public function DatePicker()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-InputGroup";
    }
    COMPILE::JS
    private var input:HTMLInputElement;

    COMPILE::SWF
    private var input:Object;

    COMPILE::JS
    private var button:HTMLButtonElement;

    COMPILE::SWF
    private var button:Object;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,'div');
      className = "spectrum-Datepicker";
      input = newElement("input") as HTMLInputElement;
      input.className = appendSelector("-field") + " spectrum-Textfield";
      input.type = "text";
      button = newElement("button") as HTMLButtonElement;
      button.className = "spectrum-FieldButton spectrum-InputGroup-button";
      var svgElement:SVGElement = document.createElementNS('http://www.w3.org/2000/svg', 'svg') as SVGElement;
      svgElement.setAttribute("class","spectrum-Icon spectrum-Icon--sizeS");
      svgElement.setAttribute("focusable",false);
      svgElement.setAttribute("viewBox","0 0 36 36");
      svgElement.setAttribute("role","img");
      var pathElement1:SVGPathElement = document.createElementNS('http://www.w3.org/2000/svg', 'path') as SVGPathElement;
      pathElement1.setAttribute("d","M33 6h-5V3a1 1 0 0 0-1-1h-2a1 1 0 0 0-1 1v3H10V3a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1v3H1a1 1 0 0 0-1 1v26a1 1 0 0 0 1 1h32a1 1 0 0 0 1-1V7a1 1 0 0 0-1-1zm-1 26H2V8h4v1a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1V8h14v1a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1V8h4z");
      svgElement.appendChild(pathElement1);
      var pathElement2:SVGPathElement = document.createElementNS('http://www.w3.org/2000/svg', 'path') as SVGPathElement;
      pathElement2.setAttribute("d","M6 12h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4zM6 18h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4zM6 24h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4z");
      svgElement.appendChild(pathElement2);
      button.appendChild(svgElement);
      element.appendChild(input);
      element.appendChild(button);
      return element;
    }
    //input.placeHolder
    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
    	if(_quiet != !!value){
        toggle(appendSelector("--quiet"),value);
        if(value){
          input.classList.add("spectrum-Textfield--quiet");
          button.classList.add("spectrum-FieldButton--quiet");
        }
        else{
          input.classList.remove("spectrum-Textfield--quiet");
          button.classList.remove("spectrum-FieldButton--quiet");
        }
      }
      _quiet = value;
    }
  }
}
// <divclass="spectrum-InputGroup spectrum-Datepicker" >
//   <input type="text" class="spectrum-Textfield spectrum-InputGroup-field" placeholder="Choose a date" value="">
//     <button type="button" class="spectrum-FieldButton spectrum-InputGroup-button">
//       <svg viewBox="0 0 36 36" focusable="false" role="img" class="spectrum-Icon spectrum-Icon--sizeS">
//         <path d="M33 6h-5V3a1 1 0 0 0-1-1h-2a1 1 0 0 0-1 1v3H10V3a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1v3H1a1 1 0 0 0-1 1v26a1 1 0 0 0 1 1h32a1 1 0 0 0 1-1V7a1 1 0 0 0-1-1zm-1 26H2V8h4v1a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1V8h14v1a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1V8h4z">
//         </path>
//         <path d="M6 12h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4zM6 18h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4zM6 24h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4z">
//         </path>
//       </svg>
//   </button>
// </div>


// <div class="spectrum-InputGroup spectrum-InputGroup--quiet spectrum-Datepicker">
//   <input type="text" class="spectrum-Textfield spectrum-Textfield--quiet spectrum-InputGroup-field" placeholder="Choose a date" value="">
//     <button type="button" class="spectrum-FieldButton spectrum-FieldButton--quiet spectrum-InputGroup-button">
//       <svg viewBox="0 0 36 36" focusable="false" role="img" class="spectrum-Icon spectrum-Icon--sizeS">
//         <path d="M33 6h-5V3a1 1 0 0 0-1-1h-2a1 1 0 0 0-1 1v3H10V3a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1v3H1a1 1 0 0 0-1 1v26a1 1 0 0 0 1 1h32a1 1 0 0 0 1-1V7a1 1 0 0 0-1-1zm-1 26H2V8h4v1a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1V8h14v1a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1V8h4z">
//         </path>
//         <path d="M6 12h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4zM6 18h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4zM6 24h4v4H6zm6 0h4v4h-4zm6 0h4v4h-4zm6 0h4v4h-4z">
//         </path>
//       </svg>
//   </button>
// </div>
