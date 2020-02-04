package view.components
{

  import org.apache.royale.html.beads.layouts.VerticalSliderLayout;
  import org.apache.royale.core.IUIBase;
  import org.apache.royale.core.IRangeModel;
  import org.apache.royale.html.beads.ISliderView;

  public class MyVerticalSliderLayout extends VerticalSliderLayout
  {
    public function MyVerticalSliderLayout()
    {
    }

    override public function layout():Boolean
    {
        var viewBead:ISliderView = host.view as ISliderView;
        if (viewBead == null) {
            return false;
        }
        
        var useWidth:Number = host.width;
        if (isNaN(useWidth)) {
            useWidth = 25;
        }
        var useHeight:Number = host.height;
        if (isNaN(useHeight)) {
            useHeight = 100;
        }
        var square:Number = Math.min(useWidth, useHeight);
        var trackWidth:Number = useWidth;
        
        var thumb:IUIBase = viewBead.thumb as IUIBase;
        thumb.width = square;
        thumb.height = square;
        
        var track:IUIBase = viewBead.track as IUIBase;
        track.y = 0;
        track.x = 0; 
        track.height = useHeight;
        track.width = trackWidth;
        
        // determine the thumb position from the model information
        var model:IRangeModel = host.model as IRangeModel;
        var value:Number = model.value;
        if (value < model.minimum) value = model.minimum;
        if (value > model.maximum) value = model.maximum;
        var p:Number = (value-model.minimum)/(model.maximum-model.minimum);
        var yloc:Number = p * (useHeight - square);
        thumb.y = yloc;
        thumb.x = 0;
        
        return true;
    }

  }
}