const Lit = require("lit-html");

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
