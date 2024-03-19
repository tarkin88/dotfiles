#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})
case $BLOCK_STATUS in
	0) $DIR/clock.sh ;;
	*) notify-send -t 2000 "Unknown status $BLOCK_STATUS clicked $BLOCK_BUTTON" & ;;
esac
