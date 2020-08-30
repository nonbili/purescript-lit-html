let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.13.8-20200828/packages.dhall sha256:6ba231455f5f611ee97840c336bbce312cd959234e3914a16ba579eb7b978fcf

let overrides = {=}

let additions = {=}

in  upstream // overrides // additions
