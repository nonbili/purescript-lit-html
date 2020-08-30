module LitHtml
  ( HtmlTemplate
  , mkHtmlTemplate
  , render
  , render'
  , SvgTemplate
  , mkSvgTemplate
  , renderSvg
  ) where

import Prelude

import Data.Argonaut.Core (Json)
import Data.Argonaut.Encode (class EncodeJson, encodeJson)
import Effect (Effect)
import Foreign (Foreign, unsafeToForeign)
import Prim.Row (class Lacks)
import Web.DOM (Element)

data HtmlTemplate

-- | Make an HTML template from a String. Similar to html`<h1>hello</h1>`.
foreign import mkHtmlTemplate :: String -> Effect HtmlTemplate

foreign import render_ :: Element -> HtmlTemplate -> Foreign -> Effect Unit

-- | Render an HTML template to a container element, interpolated by a Record.
-- | The record will be encoded to JSON.
render
  :: forall r
   . Lacks "html" r
  => EncodeJson (Record r)
  => Element -> HtmlTemplate -> Record r -> Effect Unit
render el tpl params = render_ el tpl (unsafeToForeign $ encodeJson params)

-- | Render an HTML template to a container element, interpolated by a Record.
-- | The record will not be encoded to JSON, make it suitable to contain event
-- | handlers.
render'
  :: forall r
   . Lacks "html" r
  => Element -> HtmlTemplate -> Record r -> Effect Unit
render' el tpl params = render_ el tpl (unsafeToForeign params)

data SvgTemplate

-- | Make an SVG template from a String. Similar to svg`<svg>hello</svg>`.
foreign import mkSvgTemplate :: String -> Effect SvgTemplate

foreign import renderSvg_ :: Element -> SvgTemplate -> Json -> Effect Unit

-- | Render an SVG template to a container element, interpolated by a Record.
-- | The record will be encoded to JSON.
renderSvg
  :: forall r
   . Lacks "svg" r
  => EncodeJson (Record r)
  => Element -> SvgTemplate -> Record r -> Effect Unit
renderSvg el tpl params = renderSvg_ el tpl (encodeJson params)
