package com.unhurdle.spectrum.includes
{
  public class SideNavInclude
  {

    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/sidenav/dist.css">
     * </inject_html>
     * 
     */
    public function SideNavInclude()
    {
      
    }
    public static function getSelector():String{
      return "spectrum-SideNav";
    }
  }
}