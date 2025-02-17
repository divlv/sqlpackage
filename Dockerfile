FROM mcr.microsoft.com/mssql/server:2022-latest
LABEL maintainer="Dmitrijs Zaharovs https://github.com/divlv/"
USER root
VOLUME download
ENV ACCEPT_EULA=Y
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        unzip \
        msodbcsql17 \
        mssql-tools
RUN wget -O sqlpackage.zip https://aka.ms/sqlpackage-linux \
    && unzip sqlpackage.zip -d /opt/sqlpackage \
    && chmod +x /opt/sqlpackage/sqlpackage \
    && rm /sqlpackage.zip
#
# Don't needed for backup itself:
#RUN wget "http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb" \
#    && dpkg -i libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb
#USER mssql

ENV PATH=$PATH:/opt/mssql-tools/bin:/opt/sqlpackage
