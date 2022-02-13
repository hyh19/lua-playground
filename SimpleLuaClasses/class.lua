function class(base, init)
    local c = {}

    if not init and type(base) == "function" then
        init = base
        base = nil
    elseif type(base) == "table" then
        for i, v in pairs(base) do
            c[i] = v
        end
        c._base = base
    end

    c.__index = c

    local mt = {}

    mt.__call = function(_, ...)
        local obj = {}
        setmetatable(obj, c)
        if init then
            init(obj, ...)
        else
            if base and base.init then
                base.init(obj, ...)
            end
        end
        return obj
    end

    setmetatable(c, mt)

    c.init = init

    function c:is_a(klass)
        local m = getmetatable(self)
        while m do
            if m == klass then
                return true
            end
            m = m._base
        end
        return false
    end

    return c
end
