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

-- 测试

print(fido)
print(felix)
print(leo)

print("Fido is a Dog: ", fido:is_a(Dog))
print("Fido is an Animal: ", fido:is_a(Animal))
print("Fido is a Cat: ", fido:is_a(Cat))
