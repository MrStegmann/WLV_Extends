local addonName, WLVX = ...

function WLVX:H1(parent, id, props) return WLVX:htmlCreateText(parent, id, "h1", props, { height = 32, font = "GameFontNormalLarge", color = { 1, 0.82, 0 }, scale = 1.15 }) end

function WLVX:H2(parent, id, props) return WLVX:htmlCreateText(parent, id, "h2", props, { height = 28, font = "GameFontNormalLarge", color = { 1, 0.82, 0 } }) end

function WLVX:H3(parent, id, props) return WLVX:htmlCreateText(parent, id, "h3", props, { height = 24, font = "GameFontNormal", color = { 1, 0.82, 0 } }) end

function WLVX:H4(parent, id, props) return WLVX:htmlCreateText(parent, id, "h4", props, { height = 22, font = "GameFontNormal" }) end

function WLVX:H5(parent, id, props) return WLVX:htmlCreateText(parent, id, "h5", props, { height = 20, font = "GameFontNormalSmall" }) end

function WLVX:H6(parent, id, props) return WLVX:htmlCreateText(parent, id, "h6", props, { height = 18, font = "GameFontNormalSmall" }) end

function WLVX:P(parent, id, props) return WLVX:htmlCreateText(parent, id, "p", props, { height = 20, font = "GameFontHighlightSmall" }) end

function WLVX:Span(parent, id, props) return WLVX:htmlCreateText(parent, id, "span", props, { width = 120, height = 18, font = "GameFontHighlightSmall" }) end

function WLVX:Small(parent, id, props) return WLVX:htmlCreateText(parent, id, "small", props, { height = 16, font = "GameFontDisableSmall" }) end