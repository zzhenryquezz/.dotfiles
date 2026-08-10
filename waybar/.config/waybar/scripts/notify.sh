#!/bin/bash

if makoctl list | grep -q .; then
    echo '{"text":"󰂚","class":"unread"}'
else
    echo '{"text":"󰂚","class":"empty"}'
fi
