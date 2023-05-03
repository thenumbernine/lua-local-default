## I'm Bored

Here's a script that makes Lua local-by-default.

Use it like so:

```
lua -llocal-default -lpath.to.your.script
```

Example:

```Lua
function f()
	x = 1
	print('within function, x =', x)
end
f()
print('outside function, x =', x)
```

```
lua -llocal-default -llocal-default.test1 -e ""
```
...produces...
```
parsed /home/chris/Projects/lua/local-default/test1.lua total lines:	7
within function, x =	1
outside function, x =	nil
```

You can't just run the script, you gotta `require` it.

Because I did the code injection via overriding the `require()` function.

Works on function scope and file scope.

You can only set globals by explicitly setting `_G.variable = value`.

I could probably get the first run file injected as well so you don't have to `lua -l` everything.

Meh.


### Dependencies:
- https://github.com/thenumbernine/lua-parser
