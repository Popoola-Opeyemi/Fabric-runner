from core.util import parseJson
from fabric import Connection, Config, ThreadingGroup


class Handler:
    server_config = parseJson('config.json')['config']

    def __init__(self):
        self.connectionPool = []
        self.servers_list = Handler.server_config

    def get_sudo(self, passwd):
        return Config(overrides={'sudo': {'password': passwd}})

    def multipleHosts(self):
        servers = [Connection("%s@%s" % (host['username'], host['hostname']), connect_kwargs={
                              "password": host['password']}) for host in self.servers_list]
        connections = ThreadingGroup.from_connections(servers)
        return connections

    def openHandler(self, server):
        with Connection(server['hostname'], server['username'], connect_kwargs={
                "password": server['password']}, config=self.get_sudo(server['password'])) as c:
            try:
                cmd = c.run('whoami', hide=True)
                cmd = str(cmd.stdout).strip()
                if (cmd == server['username']):
                    self.connectionPool.append(
                        {"conn": c, 'cmd': server['commands']})

            except Exception as e:
                print("an error occured while connecting to {}".format(
                    server['hostname']))

    def start(self):
        config = Handler.server_config
        for conf in config:
            self.openHandler(conf)
        print("Total host connected {}".format(len(self.connectionPool)))
