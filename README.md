# purescript-lit-html

[![purescript-lit-html on Pursuit](https://pursuit.purescript.org/packages/purescript-lit-html/badge)](https://pursuit.purescript.org/packages/purescript-lit-html)

A PureScript wrapper of [lit-html](https://github.com/Polymer/lit-html).

## Usage

```
import LitHtml as LitHtml
import Web.DOM (Element)

renderTitle :: Element -> Effect Unit
renderTitle el =
  tpl <- LitHtml.mkHtmlTemplate "<h1 id='title'>${title}</h1>"
  LitHtml.render el tpl { title: "new title" }
```

## Development

```
cd example
yarn
pulp -w build -I ../src
yarn start
```
