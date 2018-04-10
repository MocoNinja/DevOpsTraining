#! /bin/bash
ancho_linea=81

function line {
    ((contador++))
    while [ $contador -lt $ancho_linea ]; do
        # msg=$msg"+="
        # msg=$msg"="
        msg=$msg+"="
        ((contador++))
    done
    echo $msg
}

line