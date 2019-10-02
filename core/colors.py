class bcolors:
  backWhite = '\033[47m'
  GREEN = '\033[92m'
  BLUE = '\033[94m'
  backBlue = '\033[44m'
  YELLOW = '\033[93m'
  CYAN = '\033[96m'
  RED = '\033[91m'
  DARKCYAN = '\033[36m'
  ENDC = '\033[0m'
  backGreen = '\033[42m'
  PURPLE = '\033[95m'
  backBlack = '\033[40m'
  BOLD = '\033[1m'
  backRed = '\033[41m'
  backMagenta = '\033[45m'
  backYellow = '\033[43m'
  UNDERL = '\033[4m'
  backCyan = '\033[46m'

def warning(message):
  print(bcolors.BLUE + bcolors.BOLD + "[-] " + bcolors.ENDC + str(message))

def warning(message):
  print(bcolors.BLUE + bcolors.BOLD + "[-] " + bcolors.ENDC + str(message))

def terminal(message):
  return (bcolors.BLUE + bcolors.BOLD + message + bcolors.ENDC )  

def print_warning(message):
  print(bcolors.YELLOW + bcolors.BOLD + "[!] " + bcolors.ENDC + str(message))

def print_status(message):
  print(bcolors.GREEN + bcolors.BOLD + "[*] " + bcolors.ENDC + str(message))

def print_error(message):
  print(bcolors.RED + bcolors.BOLD +
  "[!] " + bcolors.ENDC + bcolors.RED + str(message) + bcolors.ENDC)

def print_bold(message):
  print(bcolors.BOLD + str(message) + bcolors.ENDC)

def display_header(message):
  print("")
  print (bcolors.PURPLE + bcolors.BOLD + message + bcolors.ENDC)
  print("")
