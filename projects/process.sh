#!/bin/sh

ROOT=$(pwd)

for d in */ ; do
	echo "Processing $d"
	cd $ROOT/$d
	mkdir logs

	# Preprocess REDUS script
	Rscript -e "sink(file = \"./logs/redus.log\")" \
	-e "library(Rstox)" \
	-e "setJavaMemory(size = 2e+09)" \
	-e "Sys.setenv(R_CONFIG_ACTIVE = \"docker\")" \
	-e "REDUStools::preprocess(\"redus/redus.yaml\")"

	# Run assessment
	Rscript -e "sink(file = \"./logs/assessment.log\")" \
	-e "Sys.setenv(R_CONFIG_ACTIVE = \"docker\")" \
	-e "if(file.exists(\"data.R\")) {" \
	-e "print(\"TAF source\")" \
	-e "system(\"apk add R-dev g++\")" \
	-e "icesTAF::taf.bootstrap()" \
	-e "source(\"data.R\")" \
	-e "source(\"model.R\")" \
	-e "source(\"output.R\")" \
	-e "source(\"report.R\")" \
	-e "} else {" \
	-e "print(\"Stockassessment.org source\")" \
	-e "system(\"Rscript src/dataplot.R\")" \
	-e "system(\"make plot forecast\")" \
	-e "}"
done

