1. On decouvre le programme en plus de certaines fonctions non appelee explicitement.
   ```
   (gdb) info functions

   0x080485f4  clear_stdin
   0x08048617  get_unum
   0x0804864f  prog_timeout
   0x08048660  decrypt
   0x08048747  test
   0x0804885a  main
   ```

2. On remarque que le programme appelle toujours la fonction `decrypt`, mais egalement que la fonction `decrypt` applique un `XOR` avec la clef. Etant donne que nous connaissons le resultat final de l'opperation ainsi que les datas initiales, on peut en deduire la clef.
   ```
   # On sait que
   "Q}|u`sfg~sf{}|a3" ^ key = "Congratulations!"

   # donc
   ord('Q') ^ x = ord('C')
   # soit
   ord('Q') ^ ord('C') = 18
   ```
   > La clef est donc 18.

3. On sait que la clef prend pour valeur `0x1337d00d - key`. Il faut donc l'adapter.
   ```
   0x1337d00d - 18 = 322424827
   ```

```
(echo "322424827"; cat;) | ./level03
cat /home/users/level04/.pass
```

> Flag: kgv3tkEb9h2mLkRsPkXRfc2mHbjMxQzvb2FrgKkf
