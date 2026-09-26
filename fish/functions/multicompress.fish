function multicompress --argument-names filename
	echo $filename
	ls -lh $filename
	# gzip -9v --keep $1

	rm -f "$filename.lzma"
	xz -9 --keep --format=lzma $filename
	ls -lh "$filename.lzma"

	rm -f "$filename.zst"
	zstd -T0 --ultra -22 -q $filename
	ls -lh "$filename.zst"

	rm -f "$filename.br"
	brotli -q 11 $filename
	ls -lh "$filename.br"

	rm -f "$filename.gz"
	zopfli --i50 $filename
	ls -lh "$filename.gz"
end
