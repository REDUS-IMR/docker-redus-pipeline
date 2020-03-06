#!/bin/bash

# Init status
name=()
redus=()
assess=()
echo '{ "name": "all", "redus": 3, "assessement": 3 }' > /tmp/status.json

ROOT=$(pwd)

for d in */ ; do
	cd $ROOT/$d
	echo "Processing $d"

	# Get name
	name+=($d)

	# Preprocess REDUS script
	Rscript -e "sink(file = \"./logs/redus.log\")" \
	-e "library(Rstox)" \
	-e "setJavaMemory(size = 2e+09)" \
	-e "Sys.setenv(R_CONFIG_ACTIVE = \"docker\")" \
	-e "REDUStools::preprocess(\"redus/redus.yaml\")"

	# Get status
	redus+=($?)

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
	-e "system(\"apk add make R-dev g++\")" \
	-e "install.packages(\"remotes\")" \
	-e "remotes::install_github(\"fishfollower/SAM/stockassessment\")" \
	-e "system(\"Rscript src/dataplot.R\")" \
	-e "status <- system(\"make plot forecast\")" \
	-e "q(save=\"no\", status=status)" \
	-e "}"

	# Get status
	assess+=($?)
done

# Set status

printf -v j1 '"%s",' "${name[@]}"
printf -v j2 '%s,' "${redus[@]}"
printf -v j3 '%s,' "${assess[@]}"

echo "{ \"name\":[${j1%,}], \"redus\": [${j2%,}], \"assessement\": [${j3%,}] }" > /tmp/status.json

# Generate report
cd $ROOT/..
Rscript -e "REDUStools::doGenReport(\"./projects\")"
cp ./projects/output.html /tmp

