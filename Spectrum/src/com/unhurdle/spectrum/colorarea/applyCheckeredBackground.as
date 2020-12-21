package com.unhurdle.spectrum.colorarea
{
    public function applyCheckeredBackground(style:CSSStyleDeclaration):void{
      style.background = "linear-gradient(-45deg, transparent 75.5%, rgb(188,188,188) 75.5%), linear-gradient(45deg, transparent 75.5%, rgb(188,188,188) 75.5%), linear-gradient(-45deg, rgb(188,188,188) 25.5%, transparent 25.5%), linear-gradient(45deg, rgb(188,188,188) 25.5%, transparent 25.5%)";
      style.backgroundColor = "white";
      style.backgroundSize = "16px 16px";
      style.backgroundPosition = "0 0, 0 8px, 8px -8px, -8px 0";
      style.width = "100%";
      style.height = "100%";
      style.borderRadius = "4px";
      style.outline =  "1px #d0d0d0 solid";
    }
}