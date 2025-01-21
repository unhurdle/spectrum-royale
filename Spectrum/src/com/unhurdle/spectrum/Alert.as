package com.unhurdle.spectrum
{
  import org.apache.royale.events.Event;
  import org.apache.royale.html.beads.plugin.ModalDisplay;

  [Event(name="modalShown", type="org.apache.royale.events.Event")]
  [Event(name="modalHidden", type="org.apache.royale.events.Event")]

  public class Alert extends AlertBase {
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

    private var modal:ModalDisplay;

    override public function show():void {
      super.show();
      modal.show(Application.current.popUpHost);
      dispatchEvent(new Event("modalShown"));
    }

    override public function hide():void {
      super.hide();
      modal.hide();
      dispatchEvent(new Event("modalHidden"));
    }
  }
}
