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

renderSvg :: NonElementParentNode -> Effect Unit
renderSvg docNode = do
  tpl <- LitHtml.mkHtmlTemplate """<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path d="M8 3S6 1 4.5 1C1 1 0 4 0 6c0 4 4 6 8 9 4-3 8-5 8-9 0-2-1-5-4.5-5C10 1 8 3 8 3z" fill-rule="evenodd"/></svg>"""
  getElementById "svg" docNode >>= traverse_ \el -> do
    LitHtml.render el tpl {}

renderSvgPath :: NonElementParentNode -> Effect Unit
renderSvgPath docNode = do
  tpl <- LitHtml.mkSvgTemplate """<path d="M8 3S6 1 4.5 1C1 1 0 4 0 6c0 4 4 6 8 9 4-3 8-5 8-9 0-2-1-5-4.5-5C10 1 8 3 8 3z" fill-rule="evenodd"/>"""
  getElementById "svg-path" docNode >>= traverse_ \el -> do
    LitHtml.renderSvg el tpl {}

renderButton :: NonElementParentNode -> Effect Unit
renderButton docNode = do
  tpl <- LitHtml.mkHtmlTemplate """<button @click=${onClick}>Click</button>"""
  getElementById "button" docNode >>= traverse_ \el -> do
    LitHtml.render' el tpl { onClick: Console.log "Button clicked."}

main :: Effect Unit
main = do
  docNode <- toNonElementParentNode <$> (window >>= document)
  renderTitle docNode
  renderNestedRecord docNode
  renderSvg docNode
  renderSvgPath docNode
  renderButton docNode
