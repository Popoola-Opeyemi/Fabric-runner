from util import parseJson
from fabric import Connection, Config

class Handler:
	server_config = parseJson('config.json')['config']

	def __init__(self):
		self.connectionPool = []

	def get_sudo(self, passwd):
		return Config(overrides={'sudo': {'password': passwd}})    

	def openHandler(self, server):
		conn = Connection(server['hostname'], server['username'], connect_kwargs={"password":server['password']}, config=self.get_sudo(server['password']))
		self.connectionPool.append({"host":server["hostname"], "connection":conn})
		print(self.connectionPool)
	

	def start(self):
		config = Handler.server_config
		for conf in config:
			self.openHandler(conf)



H = Handler()
H.start()


