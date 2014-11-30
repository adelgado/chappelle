for file in tests/*.test.lua
do
	echo "running $file"
	luanode $file
done
