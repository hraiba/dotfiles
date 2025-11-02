#!/bin/bash
if eww active-windows | grep -q "bar"; then
    eww close bar
else
    eww open bar
fi
