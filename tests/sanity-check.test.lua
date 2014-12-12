function add(left, right)
	return left + right
end

describe("Addition", function()
	it('should yeld 4 when adding 2 and 2', function()
		assert.are.equal(4, add(2, 2))
	end)
end)
