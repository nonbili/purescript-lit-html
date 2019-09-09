module Main where

import Prelude

import Data.Foldable (traverse_)
import Data.Maybe (fromJust, isJust)
import Effect (Effect)
import Effect.Console as Console
import LitHtml as LitHtml
import Partial.Unsafe (unsafePartial)
import Unsafe.Reference (unsafeRefEq)
import Web.DOM.NonElementParentNode (NonElementParentNode, getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

renderTitle :: NonElementParentNode -> Effect Unit
renderTitle docNode = do
  tpl <- LitHtml.mkHtmlTemplate "<h1 id='title'>${title}</h1>"
  getElementById "app" docNode >>= traverse_ \el -> do
    LitHtml.render el tpl { title: "title"}
    title <- getElementById "title" docNode
    LitHtml.render el tpl { title: "new title"}
    newTitle <- getElementById "title" docNode

    -- Notice <h1> is reused acrossed re-render
    Console.logShow $ isJust title
    Console.logShow $ unsafeRefEq
      (unsafePartial $ fromJust title)
      (unsafePartial $ fromJust newTitle)

renderNestedRecord :: NonElementParentNode -> Effect Unit
renderNestedRecord docNode = do
  tpl <- LitHtml.mkHtmlTemplate "${obj.id} - ${obj.name}"
  getElementById "obj" docNode >>= traverse_ \el -> do
    let obj = { id: 1, name: "test" }
    LitHtml.render el tpl { obj }

main :: Effect Unit
main = do
  docNode <- toNonElementParentNode <$> (window >>= document)
  renderTitle docNode
  renderNestedRecord docNode
