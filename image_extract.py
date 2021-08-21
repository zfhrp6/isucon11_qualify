import os, mysql.connector
from sqlalchemy.pool import QueuePool

mysql_connection_env = {
    'host': '127.0.0.1',
    'port': 3306,
    'user': 'isucon',
    'password': 'isucon',
    'database': 'isucondition',
    'time_zone': '+09:00',
}

cnxpool = QueuePool(lambda: mysql.connector.connect(**mysql_connection_env), pool_size=10)
cnx = cnxpool.connect()
cur = cnx.cursor(dictionary=True)

cur.execute('SELECT `jia_user_id`, `jia_isu_uuid`, `name`, `image` from `isu`')
a = cur.fetchall()

SAVE_PATH = '/home/isucon/isu_images'
if not os.path.exists(SAVE_PATH):
    os.mkdir(SAVE_PATH)

for im in a:
    print(im.keys())
    if not os.path.exists(f'{SAVE_PATH}/{im.get("jia_user_id")}'):
        os.mkdir(f'{SAVE_PATH}/{im.get("jia_user_id")}')

    with open(f'{SAVE_PATH}/{im.get("jia_user_id")}/{im.get("jia_isu_uuid")}.jpg', 'wb') as img:
        img.write(im.get('image'))

