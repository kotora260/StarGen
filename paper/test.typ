#import "@preview/physica:0.9.0": *
#import "@preview/metro:0.1.0": *

Hello, world!

*hoge* _hoge_ `hoge`
= hoge

- hoge
- hoge
+ hoge
+ hoge

/ hoge: hogehoge

'hoge' "hoge"

// hogehoge

$ dv(f,x),quad dv(f,x,n),quad dv(f,x,s:\/) $
$ dd(f),quad dd(x,y,z) $
$ pdv(f,x),quad pdv(f,x,[n]),quad pdv(f,x,y,z),quad pdv(,x) $
$ &planck.reduce,quad hbar $
$ ket(psi),quad bra(phi),quad braket(phi,psi),quad ketbra(psi,phi),quad mel(phi,A,psi) $
$ tensor(Gamma,+mu,-nu,-rho),quad $
$ isotope("CO",a:13),quad isotope("C")isotope("O",a:18) $

#num(1.23,e:8), #num(1.23,e:8,minimum-decimal-digits:3)

#unit("keV"), #unit("m/s"), #unit("J/(K m^3)", per-mode:symbol)

#qty(511,"keV"), #qty(511,pm:3,"keV"), #qty(1.23,e:8,"m/s")