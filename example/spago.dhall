{ name = "example"
, dependencies =
  [ "argonaut-codecs"
  , "console"
  , "effect"
  , "psci-support"
  , "unsafe-reference"
  , "web-dom"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "../src/**/*.purs", "src/**/*.purs" ]
}
