#/usr/bin/python3
## by Claudia Silva
from sys import argv # to read by console


file_ent = open(argv[1], "r") # open sbml file                                                        
db = open(argv[2], "r") # open reaction file 

lines = db.readlines()
db.close()

arc=str(argv[1]).split(".")[0]
data=str(file_ent.read())
result=str(argv[1]).split(".")[0]+"\t"

for lin in lines:

	lin=lin.rstrip('\n')

	if lin.rstrip('\n') in data:
		result=str(result)+str(1)+"\t"

	else:
		result=str(result)+str(0)+"\t"


file_new = open(arc , "w")
file_new.write(result+"\n")
file_new.close()

file_ent.close()
db.close()
