begin
	set -gx my_prompt_line_level (math $my_prompt_line_level + 1)
	set -l colors red green yellow blue magenta cyan
	set -l color $colors[(math $my_prompt_line_level % 6 + 1)]
	set -l normal (set_color normal)
	# [1] = before first normal
	# [2] = before first special
	# [3] = before normal
	# [4] = between normal and special
	# [5] = between special and normal
	# [6] = before special
	# [7] = after last
	set -g my_prompt_line_separators \
		$normal(set_color -r $color) \
		$normal(set_color -b brwhite $color) \
		$normal(set_color -r $color)│ \
		$normal(set_color -b brwhite $color)▒ \
		$normal(set_color -b brwhite $color)▒$normal(set_color -r $color) \
		$normal(set_color -b brwhite $color)│ \
		$normal(set_color $color)
end

function my_prompt_line
	set -l sunken_before 0
	set -l sunken_after 0
	set -l separator 0
	for item in $argv
		if [ -z $item ]
			set sunken_after (math 1 - $sunken_after)
		else
			echo -n $my_prompt_line_separators[(math $separator x 2 + $sunken_before x 2 + $sunken_after + 1)] \
				$item ""
			set separator 1
			set sunken_before $sunken_after
		end
	end
	echo -n $my_prompt_line_separators[7]
end
