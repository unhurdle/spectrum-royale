package com.unhurdle.spectrum
{
    import org.apache.royale.core.UIBase;

    COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
    public class CircleLoader extends UIBase
    {
        public function CircleLoader()
        {
            super();
            typeNames = "spectrum-CircleLoader"
        }
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            var track:WrappedHTMLElement = new WrappedHTMLElement();
            track.className = "spectrum-CircleLoader-track";
            elem.appendChild(track);
            var fills:WrappedHTMLElement = new WrappedHTMLElement();
            fills.className = "spectrum-CircleLoader-fills";
            elem.appendChild(fills);
            var fillMask1:WrappedHTMLElement = new WrappedHTMLElement();
            fillMask1.className = "spectrum-CircleLoader-fillMask1";
            elem.appendChild(fillMask1);
            var fillSubMask1:WrappedHTMLElement = new WrappedHTMLElement();
            fillSubMask1.className = "spectrum-CircleLoader-fillSubMask1";
            elem.appendChild(fillSubMask1);
            var fill1:WrappedHTMLElement = new WrappedHTMLElement();
            fill1.className = "spectrum-CircleLoader-fill";
            elem.appendChild(fill1)
            ;var fillMask2:WrappedHTMLElement = new WrappedHTMLElement();
            fillMask2.className = "spectrum-CircleLoader-fillMask2";
            elem.appendChild(fillMask2);
            var fillSubMask2:WrappedHTMLElement = new WrappedHTMLElement();
            fillSubMask2.className = "spectrum-CircleLoader-fillSubMask2";
            elem.appendChild(fillSubMask2);
            var fill2:WrappedHTMLElement = new WrappedHTMLElement();
            fill2.className = "spectrum-CircleLoader-fill";
            elem.appendChild(fill2);
            return elem;
        }
    }
}