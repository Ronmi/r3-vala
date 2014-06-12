# Vala binding for [libr3](https://github.com/c9s/r3)

## What?
[libr3](https://github.com/c9s/r3) is super fast URL router lib written in C.

[Vala](https://wiki.gnome.org/Projects/Vala) is currently my favorite programming language.

So it's here.

## How?
1. Clone, compile and install libr3.
2. Put r3.vapi /some/where.
3. Compile your vala code with something like `valac --vapidir=/some/where --pkg r3 my_prog.vala`

## Caution
In step 2, never try this at home:
```
mkdir -p /some/where;cp r3.vapi /some/where
```

Do this instead:
```
x-www-browser "https://wiki.gnome.org/Projects/Vala/FAQ#Is_having_a_local_copy_of_a_.vapi_in_my_project_good_practice.3F"
```

## Copyright
This program is free software, see LICENSE for further info.
