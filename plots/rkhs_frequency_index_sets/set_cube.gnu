# Checking if we have enough input parameters
if (ARGC!=3) print 'set_cube needs 3 input parameters'; exit

# Getting the input parameters
x = ARG1
y = ARG2
z = ARG3

if (!exists("object_number")) object_number = 1;
set object object_number polygon from \
  x-z/2,y-z/2 to x-z/2,1+y-z/2 to 1+x-z/2,1+y-z/2 to 1+x-z/2,y-z/2 to x-z/2,y-z/2
set object object_number+1 polygon from \
  x-z/2,1+y-z/2 to 1+x-z/2,1+y-z/2 to 1.5+x-z/2,1.5+y-z/2 to 0.5+x-z/2,1.5+y-z/2 to x-z/2,1+y-z/2
set object object_number+2 polygon from \
  1+x-z/2,y-z/2 to 1.5+x-z/2,0.5+y-z/2 to 1.5+x-z/2,1.5+y-z/2 to 1+x-z/2,1+y-z/2 to 1+x-z/2,y-z/2
set object object_number fc rgb "#cccccc" fs solid border -1 lw 1
set object object_number+1 fc rgb "#ffffff" fs solid border -1 lw 1
set object object_number+2 fc rgb "#888888" fs solid border -1 lw 1
object_number = object_number+3
