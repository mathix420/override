1. Le programme utilise une forme de hashage sur le login afin de comparer le hash avec le serial pour ouvrir le shell.

2. Il suffit donc de regarder quelle valeur est comparee avec notre serial, pour avoir le bon serial pour un login donne.

```
(gdb) b *0x080487ba
(gdb) b *0x08048866
(gdb) r
Starting program: /home/users/level06/level06
***********************************
*		level06		  *
***********************************
-> Enter Login: AAAABBBB
***********************************
***** NEW ACCOUNT DETECTED ********
***********************************
-> Enter Serial: 420

Breakpoint 1, 0x080487ba in auth ()
(gdb) set $eax=1
(gdb) c
(gdb) x/wx $ebp-0x10
0xffffd5f8:	0x005f1132
(gdb) q

$ python -c 'print 0x005f1132'
6230322
$ ./level06
***********************************
*               level06           *
***********************************
-> Enter Login: AAAABBBB
***********************************
***** NEW ACCOUNT DETECTED ********
***********************************
-> Enter Serial: 6230322
$ cat /home/users/level07/.pass
GbcPDRgsFK77LNnnuh7QyFYA2942Gp8yKj9KrWD8
```
> Flag: GbcPDRgsFK77LNnnuh7QyFYA2942Gp8yKj9KrWD8
