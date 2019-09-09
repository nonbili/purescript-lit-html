module LitHtml
  ( HtmlTemplate
  , mkHtmlTemplate
  , render
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
