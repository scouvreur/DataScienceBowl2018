#!/bin/bash

for folder in */; do
	echo $folder
	cd $folder
	cd masks/

	outputname=`basename $folder`
	outputname="$outputname-mask.png"

	composite *.png -compose Plus mask.png

	for image in *.png; do
		echo $image
		composite $image mask.png -compose Plus mask.png
	done

	convert mask.png -negate mask.jpg
	rm *.png
	convert mask.jpg -threshold 95% mask.png
	rm *.jpg
	mv mask.png $outputname
	cd ../..
done
