#!/bin/bash
for path in jupyter-slides/*; do
	fn=$(echo $path | cut -f 2 -d '/' || $1)
	num=$(echo $fn | cut -f 1 -d '-')
	name=$(echo $fn | cut -f 2 -d '-')

	echo "Processing #$num aka $name"
	mkdir -p $num

	jupyter-nbconvert --to slides jupyter-slides/$num-$name/$name.ipynb --reveal-prefix=../reveal.js --output `pwd`/$num/$name
	find $path \( -not -name '*.ipynb' \) -type f -exec cp {} $num \;
	echo '.prompt { display: none; }' > $num/custom.css
done
