module LitHtml
  ( HtmlTemplate
  , mkHtmlTemplate
  , render
  , SvgTemplate
  , mkSvgTemplate
  , renderSvg
  ) where

import Prelude

import Data.Argonaut.Core (Json)
import Data.Argonaut.Encode (class EncodeJson, encodeJson)
import Effect (Effect)
import Prim.Row (class Lacks)
import Web.DOM (Element)

data HtmlTemplate

foreign import mkHtmlTemplate :: String -> Effect HtmlTemplate

foreign import render_ :: Element -> HtmlTemplate -> Json -> Effect Unit

render
  :: forall r
   . Lacks "html" r
  => EncodeJson (Record r)
  => Element -> HtmlTemplate -> Record r -> Effect Unit
render el tpl params = render_ el tpl (encodeJson params)

data SvgTemplate

foreign import mkSvgTemplate :: String -> Effect SvgTemplate

foreign import renderSvg_ :: Element -> SvgTemplate -> Json -> Effect Unit

renderSvg
  :: forall r
   . Lacks "svg" r
  => EncodeJson (Record r)
  => Element -> SvgTemplate -> Record r -> Effect Unit
renderSvg el tpl params = renderSvg_ el tpl (encodeJson params)
