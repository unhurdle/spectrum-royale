package com.unhurdle.spectrum
{
  COMPILE::JS {
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.events.Event;
  import org.apache.royale.events.KeyboardEvent;
  import org.apache.royale.events.utils.UIKeys;
  import org.apache.royale.html.beads.plugin.ModalDisplay;

  [Event(name="modalShown", type="org.apache.royale.events.Event")]
  [Event(name="modalHidden", type="org.apache.royale.events.Event")]

  public class Alert extends InlineAlert {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/alert/dist.css">
     * </inject_html>
     *
     */

    public function Alert() {
      super();
      visible = false;
      modal = new ModalDisplay();
      addBead(modal);
    }

    private function handleKeyDown(event:KeyboardEvent):void {
      if (event.key == UIKeys.ESCAPE) {
        hide();
      }
    }
    private var _noDismiss:Boolean;

    public function get noDismiss():Boolean {
      return _noDismiss;
    }

    public function set noDismiss(value:Boolean):void {
      _noDismiss = value;
      if (_overlayBead) {
        _overlayBead.hideOnClick = !value;
      }
    }

    private var _showOverlay:Boolean;

    public function get showOverlay():Boolean {
      return _showOverlay;
    }

    public function set showOverlay(value:Boolean):void {
      if (value) {
        getOverlayBead();
      }
      else if (_overlayBead) {
        removeBead(_overlayBead);
      }
      _showOverlay = value;
    }

    private function getOverlayBead():Underlay {
      if (!_overlayBead) {
        _overlayBead = new Underlay();
        addBead(_overlayBead);
      }
      _overlayBead.hideOnClick = !_noDismiss;
      return _overlayBead;
    }
    private var _overlayBead:Underlay;

    private var modal:ModalDisplay;

    override public function show():void {
      super.show();
      window.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
      modal.show(Application.current.popUpHost);
      dispatchEvent(new Event("modalShown"));
    }

    override public function hide():void {
      window.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
      super.hide();
      modal.hide();
      dispatchEvent(new Event("modalHidden"));
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement {
      var elem:WrappedHTMLElement = super.createElement();
      var styleStr:String = "z-index:100;";
      elem.setAttribute("style", styleStr);
      return elem;
    }
  }
}
