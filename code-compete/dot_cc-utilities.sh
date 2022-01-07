#!/bin/env bash

red=$( tput setaf 196 )
reset=$( tput sgr0 )

crd() {
	if [[ $1 = "" ]] || [[ $1 = '-'* ]]; then
		echo "${red}ERROR:${reset} Invalid directory name!"
	else
		mkdir "${HOME}"/code-compete/"$1" 
		[[ -d ${HOME}/code-compete/$1 ]] && cp "${HOME}"/code-compete/.cc-template.cpp "${HOME}"/code-compete/"$1"/"$1".cpp
	fi
}

cdd() {
	if [[ $1 = "-c" ]]; then
		crd "$2"
		[[ -d ${HOME}/code-compete/$2 ]] && cd "${HOME}"/code-compete/"$2"
	else
		cd "${HOME}"/code-compete/"$1"
	fi
}
