function cqjpg
	for filename in $argv
		echo $filename
		cjpeg -quality 25 -optimize -outfile $filename.jpg $filename
	end
end
