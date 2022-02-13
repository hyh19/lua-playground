# Simple Lua Classes

<http://lua-users.org/wiki/SimpleLuaClasses>

```lua
Account = {}
Account.__index = Account

function Account:create(balance)
    local acnt = {} -- our new object
    setmetatable(acnt, Account) -- make Account handle lookup
    acnt.balance = balance -- initialize our object
    return acnt
end

function Account:withdraw(amount)
    self.balance = self.balance - amount
end

-- create and use an Account
acc = Account:create(1000)
acc:withdraw(100)
```

```lua
-- animal.lua

require "class"

Animal =
    class(
    function(a, name)
        a.name = name
    end
)

function Animal:__tostring()
    return self.name .. ": " .. self:speak()
end

Dog = class(Animal)

function Dog:speak()
    return "bark"
end

Cat =
    class(
    Animal,
    function(c, name, breed)
        Animal.init(c, name) -- must init base!
        c.breed = breed
    end
)

function Cat:speak()
    return "meow"
end

Lion = class(Cat)

function Lion:speak()
    return "roar"
end

fido = Dog("Fido")
felix = Cat("Felix", "Tabby")
leo = Lion("Leo", "African")
```

```lua
-- class.lua
-- Compatible with Lua 5.1 (not 5.0).
function class(base, init)
    local c = {} -- a new class instance
    if not init and type(base) == "function" then
        init = base
        base = nil
    elseif type(base) == "table" then
        -- our new class is a shallow copy of the base class!
        for i, v in pairs(base) do
            c[i] = v
        end
        c._base = base
    end
    -- the class will be the metatable for all its objects,
    -- and they will look up their methods in it.
    c.__index = c

    -- expose a constructor which can be called by <classname>(<args>)
    local mt = {}
    mt.__call = function(class_tbl, ...)
        local obj = {}
        setmetatable(obj, c)
        if init then
            init(obj, ...)
        else
            -- make sure that any stuff from the base class is initialized!
            if base and base.init then
                base.init(obj, ...)
            end
        end
        return obj
    end
    c.init = init
    c.is_a = function(self, klass)
        local m = getmetatable(self)
        while m do
            if m == klass then
                return true
            end
            m = m._base
        end
        return false
    end
    setmetatable(c, mt)
    return c
end
```
