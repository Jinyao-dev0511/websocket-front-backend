FROM intersystemsdc/iris-community:latest

USER root
WORKDIR /opt/irisapp

# Copy files
COPY src src
COPY iris.script iris.script
COPY web web

# Set permissions
RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp

USER ${ISC_PACKAGE_MGRUSER}

# Import ObjectScript code
RUN iris start IRIS \
    && iris session IRIS < iris.script \
    && iris stop IRIS quietly
