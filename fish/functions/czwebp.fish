function czwebp
	for filename in $argv
		set -l new_filename (path change-extension webp $filename)
		cwebp -z 9 $filename -o $new_filename
		touch --no-create -r $filename $new_filename
	end
end
