#!/bin/bash

# Try/catch functions used from Mathias Henze's answer to SO question #22009364
function try()
{
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}

function catch()
{
    export ex_code=$?
    (( $SAVED_OPT_E )) && set +e
    return $ex_code
}

# Packages to install
packages=(matplotlib pandas numpy scipy nltk tensorflow scikit-learn
			requests simplejson scrapy arrow sympy seaborn bokeh
			plotly theano keras gensim statsmodels regex selenium
			construct numexpr milk pyreadline)

printf "Installing packages\n"A

for package in ${packages[*]}
do
	try
	{
    	pip install $package
	}

	catch || {
    	echo "Could not install pip package: $package" >> notfound.txt	
	}

	try
	{
    	pip3 install $package
	}

	catch || {
    	echo "Could not install pip3 package: $package" >> notfound.txt	
	}

done

# Search for packages
#for package in ${packages[*]}
#do
#	if [[ $(pip search $package) ]]; then
#		printf "%s found\n" $package
#	else
#		printf "%s not found\n" $package
#	fi
#done
