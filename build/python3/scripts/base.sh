#!/bin/bash

# Source try/catch functions

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
