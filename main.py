# from core.connection import Handler
from fabric import Connection, Config, SerialGroup, ThreadingGroup, exceptions, runners
from core.connection import *


def runner():
    H = Handler()
    H.start()


runner()
