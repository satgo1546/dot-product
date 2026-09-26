function tmproot
	if [ "x$1" = "x-" ]
		docker start -i $(docker ps -ql)
	else
		mkdir -p /tmp/tmproot
		docker run -it --network host -v /tmp/tmproot:/swapper tensorflow/tensorflow /bin/sh -c \
			'sed -i "s/deb.debian.org/mirrors.ustc.edu.cn/g; s/security.debian.org/mirrors.ustc.edu.cn/g" /etc/apt/sources.list && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && apt-get update; exec bash'
	end
end
