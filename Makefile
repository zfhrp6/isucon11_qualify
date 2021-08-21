default:
	echo "restart|clear-log|alp-log"
restart:
	sudo systemctl restart isucondition.python.service
	sudo systemctl restart nginx
clear-log:
	sudo truncate --size 0 /var/log/nginx/access.log
alp-log:
	sudo cat /var/log/nginx/access.log | alp --reverse ltsv
manual-start:
	sudo systemctl stop isucondition.python.service
	$(shell cd /home/isucon/webapp/python; MYSQL_HOST="127.0.0.1" MYSQL_PORT=3306 MYSQL_USER=isucon MYSQL_DBNAME=isucondition MYSQL_PASS=isucon POST_ISUCONDITION_TARGET_BASE_URL="https://isucondition-2.t.isucon.dev" /home/isucon/local/python/bin/python main.py)
