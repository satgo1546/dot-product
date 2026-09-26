function czjxl
	set -l has_errors 0
	for filename in $argv
		set -l new_filename (path change-extension jxl $filename)
		cjxl $filename $new_filename --distance=0 --container=0 --keep_invisible=0 --lossless_jpeg=1 --effort=9
		# effort can go up to 10 but is drastically slower than 9
		touch --no-create -r $filename $new_filename
		if magick compare -metric AE $filename $new_filename null:
			echo " errors"
		else
			set -l has_errors 1
			echo
			echo "██ ENCODING ERROR!!"
			magick compare $filename $new_filename $new_filename.error.png
		end
	end
	if [ $has_errors -ne 0 ]
		echo "██ Errors occurred."
	end
end
