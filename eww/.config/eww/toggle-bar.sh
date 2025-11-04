#!/bin/bash
if eww active-windows | grep -q "bar"; then
    eww close bar & eww close calander_menu
else
    eww open bar
fi  
