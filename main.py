# from core.connection import Handler
from core.connection import *
from core import colors
import os


def runner():
  H = Handler()
  H.start()
  for pool in H.connectionPool:
    con = pool['conn']
    command = pool['cmd']
    H.colors.warning("Initializing commands on  {}".format(pool['conn'].host))
    for cmd in command:
      print('\n')
      H.colors.print_warning("Running {} command {}".format(cmd["type"], cmd["cmd"]))
      if (cmd["type"] == "local"):
        H.run_local(cmd["cmd"])
        print("Finished......")
      else:
        con.sudo(cmd["cmd"])
        
runner()
