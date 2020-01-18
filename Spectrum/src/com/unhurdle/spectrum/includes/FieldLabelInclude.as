package com.unhurdle.spectrum.includes
{
  public class FieldLabelInclude
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/fieldlabel/dist.css">
     * </inject_html>
     * 
     */
    public function FieldLabelInclude()
    {
      
    }
    public static function getSelector():String{
      return "spectrum-FieldLabel";
    }
    public static function getFormSelector():String{
      return "spectrum-Form";
    }
  }
}