FROM redusimr/redus-pipeline

LABEL org.label-schema.license="LGPL-3.0" \
      org.label-schema.vcs-url="https://github.com/REDUS-IMR/docker-redus-pipeline" \
      org.label-schema.vendor="REDUS Project at IMR Norway"

ADD projects /root/workspace/projects

WORKDIR /root/workspace/projects

EXPOSE 8888

CMD /etc/run.sh & \
    Rscript -e "dirs <- list.dirs(path = getwd(), full.names = TRUE, recursive = FALSE)" \
	-e "print(dirs)" \
	-e "for (dir in dirs){" \
	-e "setwd(dir)" \
	-e "REDUStools::preprocess(\"redus/redus.yaml\")" \
	-e "if(file.exists(\"data.R\")) {" \
	-e "print(\"TAF\")" \
	-e "source(\"data.R\")" \
	-e "source(\"input.R\")" \
	-e "source(\"model.R\")" \
	-e "source(\"output.R\")" \
	-e "source(\"report.R\")" \
	-e "} else {" \
	-e "system(\"Rscript src/dataplot.R\")" \
	-e "system(\"make plot forecast\")" \
	-e "}" \
	-e "}" \
    && tar czf results.tar.gz * --exclude='.*' \
    && /bin/sh

