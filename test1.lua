function f()
	x = 1
	print('within function, x =', x)
end
f()
print('outside function, x =', x)

y = 1
print('file scope, y =', y)
print('global scope, y = ', _G.y)
