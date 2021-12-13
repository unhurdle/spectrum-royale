# spectrum-royale
A [Spectrum](https://github.com/adobe/spectrum-css) component set built for [Apache Royale](https://royale.apache.org/)

# Home Page
There is a demo hosted on Github pages and is available in the docs folder. The source of the demo is in the SpectrumBrowser folder. There is a lot to learn by browsing the source code. [Check out the demo here.](https://unhurdle.github.io/spectrum-royale/)
# Projects

## Spectrum
The Spectrum project creates a swc library which enables using Spectrum components in MXML and ActionScript in your projects.

## SpectrumBrowser
A sample web application for viewing and interacting with the built components.

# Building the Spectrum Library
## Prerequisites
1. Run `npm install`. This will add a dependencies. Notably it will add a `playerglobal.swc` file to to Spectrum folder.
1. You need a full Royale SDK (including SWF support) on your system. The latest release version can be installed using `npm install @apache-royale/royale-js-swf -g`.

## Build Using `ant`
1. You need a `ROYALE_HOME` environment variable which points to this SDK.
1. You also need a working copy of ant installed. [Details here.](https://ant.apache.org/manual/install.html)
1. Open a Command Prompt/Terminal window in the Spectrum folder.
1. Run `ant`.

## Build Using `asconfigc`
### Command Line
1. Run `npm install asconfigc -g` to install asconfigc globally.
1. In your Terminal/Command Prompt window, `cd` into the Spectrum directory.
1. Run `asconfigc`.
### VS Code
1. Make sure you have the [ActionScript & MXML](https://as3mxml.com/) extension installed.
1. Open the Spectrum folder in VS Code. 
1. Select Run Build Task and select `compile release`.

Once built, you will have a file `Spectrum.swc` in a `target` directory. Include the `Spectrum.swc` file in your projects, and the Spectrum components will be available.

The SpectrumBrowser folder points to the `swc` in the `target` directory. Once the library is built, you can build SpectrumBrowser using `asconfigc` or the VS Code extension.

# Using the Spectrum Library

Royale apps are built using ActionScript and MXML. Read more about the basics of Royale [here.](https://apache.github.io/royale-docs/)

## Simple but Complete Spectrum-Royale app
````
<?xml version="1.0" encoding="utf-8"?>
<sp:Application
  xmlns="library://ns.apache.org/royale/html"
  xmlns:fx="http://ns.adobe.com/mxml/2009"
  xmlns:js="library://ns.apache.org/royale/basic"
  xmlns:sp="library://ns.unhurdle.com/spectrum" colorstop="light" appScale="medium">
  <fx:Script>
    <![CDATA[
        import com.unhurdle.spectrum.Toast;
        private function showResult():void{
          new Toast(helloInput.text,2000).show();
        }
    ]]>
  </fx:Script>
  <sp:initialView>
    <js:View width="100%" height="100%">
    <sp:FlexContainer vertical="true" alignItems="center" width="100%" height="100%" style="margin:40px">
        <sp:Heading size="1" text="Welcome to Spectrum"/>
        <sp:Body text="Click below to change the theme color"/>
        <sp:ButtonGroup>
          <sp:Button text="Lightest" click="this.colorstop='lightest'"/>
          <sp:Button text="Light" click="this.colorstop='light'"/>
          <sp:Button text="Dark" click="this.colorstop='dark'"/>
          <sp:Button text="Darkest" click="this.colorstop='darkest'"/>
        </sp:ButtonGroup>
        <Div height="20"/>
        <sp:Body text="Click below to change the theme size"/>
        <sp:ButtonGroup>
          <sp:Button text="Medium" click="this.appScale='medium'"/>
          <sp:Button text="Large" click="this.appScale='large'"/>
        </sp:ButtonGroup>
        <Div height="20"/>
        <sp:FieldGroup>
          <sp:FieldLabel text="Let's talk!"/>
          <sp:TextField id="helloInput" placeholder="Write Something here."/>
          <sp:Button text="Go!" click="showResult()"/>
        </sp:FieldGroup>
      </sp:FlexContainer>
    </js:View>
  </sp:initialView>  
</sp:Application>
````
Theming can be set and changed by simply changing the `colorstop` and `appScale` properites of the app.

The full gamut of spectrum components can be declared and wired up with very little effort. Have fun playing!

Make sure to include the full CSS folder and adjust the html template file as done in the SpectrumBrowser project.

Include the following:
1. Copy https://github.com/unhurdle/spectrum-royale/blob/master/SpectrumBrowser/asconfig.json and modify `js-library-path`. You will probably want to place Spectrum.swc in your `libs` folder and remove the reference to `../Spectrum/target`.
2. Copy https://github.com/unhurdle/spectrum-royale/blob/master/SpectrumBrowser/index-template.html to the root of your project.
3. Copy the full folder at https://github.com/unhurdle/spectrum-royale/tree/master/SpectrumBrowser/src/assets to your `src` folder. You should change the favicon to your own.

Those should be the only steps you need to use Spectrum.

You can remove references to Spectrum CSS that you are not using from the template file to reduce the number of CSS dependencies.
