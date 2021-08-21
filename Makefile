default:
	echo "restart|clear-log|alp-log"
restart:
	sudo systemctl restart isucondition.python.service
	sudo systemctl restart nginx
clear-log:
	sudo truncate --size 0 /var/log/nginx/access.log
alp-log:
	sudo cat /var/log/nginx/access.log | alp --reverse ltsv
