--[[
    Copyright (C) 2014 Ryan "MGinshe" Cole

	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation 
	files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, 
	modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software 
	is furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
	IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
]]--

-- a lot of the code here was based on higherorderfun's vector cheat sheet, which can be found here:
-- http://higherorderfun.com/blog/2012/06/03/math-for-game-programmers-05-vector-cheat-sheet/

local vector = {}
vector.__index = vector

function vector.new(self, x, y)
	local v = {}
	v.__type = "vector"

	if type(x) == "table" then
		v.x = x.x
		v.y = x.y
	else
		v.x = x
		v.y = y
	end

	return setmetatable(v, vector)
end

-- helper functions
function vector.unpack(self)
	return self.x, self.y
end
function vector.copy(self)
	return vector(self.x, self.y)
end

-- tostring
function vector.__tostring(self)
	return self.x .. " ," .. self.y
end

-- math
function vector.length(self)
	-- return the square root of the length
	return math.sqrt(self.x * self.x + self.y * self.y)
end
function vector.sqlength(self)
	-- return the length squared
	return self.x * self.x + self.y * self.ys
end

function vector.normalize(self)
	-- normalize the vector, altering it's components
	local len = math.sqrt(self.x * self.x + self.y * self.y)

	self.x = self.x / len
	self.y = self.y / len

	return self
end
function vector.normalized(self)
	-- return a normalized version of the vector, without changing the original
	local r = vector()
	local len = math.sqrt(self.x * self.x + self.y * self.y)

	r.x = self.x / len
	r.y = self.y / len

	return r
end

function vector.dot(a, b)
	-- return the dot product
	return a.x * b.x + a.y * b.y
end
function vector.cross(a, b)
	-- return the augmented z component of the cross product
	return a.x * b.y - a.y * b.x
end

function vector.rotateLeft(self)
	-- rotate the vector left, by 90 degrees
	local x = self.x

	self.x = -self.y
	self.y = x

	return self
end
function vector.rotateRight(self)
	-- rotate the vector right, by 90 degrees
	local x = self.x

	self.x = self.y
	self.y = -x

	return self
end

function vector.rotate(self, angle)
	-- rotate the vector by [angle] degrees
	local angle = math.rad(angle)
	local sin, cos = math.sin(angle), math.cos(angle)

	local x = self.x * cos - self.y * sin

	self.y = self.x * sin + self.y * cos
	self.x = x

	return self
end
function vector.rotation(self, angle)
	-- set the vectors rotation to [angle] degrees
	local angle = math.rad(angle) - self:getAngle()
	local sin, cos = math.sin(angle), math.cos(angle)

	local x = self.x * cos - self.y * sin

	self.y = self.x * sin + self.y * cos
	self.x = x

	return self
end
function vector.getAngle(self)
	-- get the angle the vector points to
	return math.atan2(self.y, self.x)
end

-- operators
function vector.__unm(self)
	-- unary minus
	return vector(-self.x, -self.y)
end

function vector.__add(a, b)
	if type(b) == "number" then
		return vector(a.x + b, a.y + b)
	elseif b.__type then
		if b.__type == "vector" then
			return vector(a.x + b.x, a.y + b.y)
		elseif b.__type == "matrix3" then

		end
	end

	return a
end
function vector.__sub(a, b)
	if type(b) == "number" then
		return vector(a.x - b, a.y - b)
	elseif b.__type then
		if b.__type == "vector" then
			return vector(a.x - b.x, a.y - b.y)
		elseif b.__type == "matrix3" then

		end
	end

	return a
end
function vector.__mul(a, b)
	if type(b) == "number" then
		return vector(a.x * b, a.y * b)
	elseif b.__type then
		if b.__type == "vector" then
			return vector(a.x * b.x, a.y * b.y)
		elseif b.__type == "matrix3" then

		end
	end

	return a
end
function vector.__div(a, b)
	if type(b) == "number" then
		return vector(a.x / b, a.y / b)
	elseif b.__type then
		if b.__type == "vector" then
			return vector(a.x / b.x, a.y / b.y)
		elseif b.__type == "matrix3" then

		end
	end

	return a
end

-- comparison
function vector.__lt(a, b)
	-- less than
	return (a.x < b.x) and (a.y < b.y)
end
function vector.__le(a, b)
	-- less than, or equal to
	return (a.x <= b.x) and (a.y <= b.y)
end
function vector.__eq(a, b)
	-- equal
	return (a.x == b.x) and (a.y == b.y)
end

return setmetatable(vector, {__call = vector.new})
