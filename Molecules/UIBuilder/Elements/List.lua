local addonName, WLVX = ...

function WLVX:Ul(parent, id, props, callback)
    props, callback = WLVX:htmlNormalizeProps(props, callback)
    props.tag = "ul"
    props.direction = props.direction or "column"
    return self:Div(parent, id, props, callback)
end

function WLVX:Ol(parent, id, props, callback)
    props, callback = WLVX:htmlNormalizeProps(props, callback)
    props.tag = "ol"
    props.direction = props.direction or "column"
    local list = self:Div(parent, id, props, callback)
    list.htmlListCounter = 0
    return list
end

function WLVX:Li(parent, id, props)
    props = WLVX:htmlNormalizeProps(props)
    props.tag = "li"

    if parent and parent.htmlTag == "ol" then
        parent.htmlListCounter = (parent.htmlListCounter or 0) + 1
        props.text = tostring(parent.htmlListCounter) .. ". " .. (props.text or "")
    elseif props.bullet ~= false then
        props.text = "- " .. (props.text or "")
    end

    if type(props.onClick) == "function" then
        return self:Button(parent, id, props)
    end

    return self:P(parent, id, props)
end