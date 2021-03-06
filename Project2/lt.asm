.data

fin:	.asciiz "a.txt"      # filename for input
buffer:	.space	100
new:	.asciiz "\n"

.text

la $t1, new
lb $t0, 0($t1)


  ###############################################################
  # Open a file
  li   $v0, 13       # system call for open file
  la   $a0, fin      # input file name
  li   $a1, 0        # Open for reading (flags are 0: read, 1: write)
  li   $a2, 0        # mode is ignored
  syscall            # open a file (file descriptor returned in $v0)
  move $s6, $v0      # save the file descriptor 
  ###############################################################
  # Read from file just opened
  li   $v0, 14       # system call for read from file
  move $a0, $s6      # file descriptor 
  la   $a1, buffer   # address of buffer from which to read
  li   $a2, 1       # hardcoded buffer length
  syscall            # write to file
  ###############################################################
  # Close the file 
  li   $v0, 16       # system call for close file
  move $a0, $s6      # file descriptor to close
  syscall            # close file
  ###############################################################
  # Let's see what is read
  la   $a0, buffer
  li   $v0, 4
  syscall
