# Files
better than writefile.

```lua
local files = Files()

files.apple = {
	banana = "money!",
	orange = {
		pear = "yummy"
	}
}

files.sex = "hak"

print(files.apple.orange.pear) --> yummy
print(files.apple) --> apple
print(files.sex) --> hak
```
