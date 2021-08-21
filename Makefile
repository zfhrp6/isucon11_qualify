default:
	echo "restart|clear-log|alp-log"
restart:
	sudo systemctl restart isucondition.python.service
	sudo systemctl restart nginx
clear-log:
	sudo truncate --size 0 /var/log/nginx/access.log
	sudo journalctl --vacuum-time=1s
alp-log:
	sudo cat /var/log/nginx/access.log | alp ltsv --reverse -m "^/api/condition/[^/]+,^/api/isu/[^/]+,^/api/isu/[^/]+/icon,^/isu/[^/]+/condition,^/isu/[^/]+,^/isu/[^/]+/graph"
manual-start:
	$(shell sudo systemctl stop isucondition.python.service && cd /home/isucon/webapp/python; MYSQL_HOST="127.0.0.1" MYSQL_PORT=3306 MYSQL_USER=isucon MYSQL_DBNAME=isucondition MYSQL_PASS=isucon POST_ISUCONDITION_TARGET_BASE_URL="https://isucondition-2.t.isucon.dev" /home/isucon/local/python/bin/python main.py)
