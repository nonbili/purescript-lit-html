const Lit = require("lit-html");

// Adapted from https://gist.github.com/malko/b8a432bbb2198ca5d38cd3dc27d40f24
exports.mkHtmlTemplate = template => () => {
  return params =>
    new Function(
      "{" + Object.keys(params).join(",") + "}",
      "return html`" + template + "`"
    )(params);
};

exports.render_ = el => tpl => params => () => {
  params.html = Lit.html;
  Lit.render(tpl(params), el);
};

exports.mkSvgTemplate = template => () => {
  return params =>
    new Function(
      "{" + Object.keys(params).join(",") + "}",
      "return svg`" + template + "`"
    )(params);
};

exports.renderSvg_ = el => tpl => params => () => {
  params.svg = Lit.svg;
  Lit.render(tpl(params), el);
};
