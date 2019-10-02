# from core.connection import Handler
from core.connection import *
from core import colors
import os


def runner():
  try:
    H = Handler()
    H.start()
    for pool in H.connectionPool:
      con = pool['conn']
      command = pool['cmd']
      print('\n')
      H.colors.warning("Initializing commands on  {}".format(pool['conn'].host))
      for cmd in command:
        print('\n')
        H.colors.print_warning("Running {} command {}".format(cmd["type"], cmd["cmd"]))
        if (cmd["type"] == "local"):
          try:
            H.run_local(cmd["cmd"])
            H.colors.print_status("Finished...")
          except Exception as e:
            H.colors.print_error("an error occured {}".format(e))
        else:
          con.sudo(cmd["cmd"])
  except KeyboardInterrupt:
    print("quitting Application")


        
runner()
