FROM postgres:12.3

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      python2.7 \
      "postgresql-contrib-12" \
      "postgresql-plpython3-12" \
      "python3-pip"

RUN apt-get install -y --no-install-recommends \
    "postgresql-server-dev-12" \
    gcc \
    python3-dev \
    libyaml-dev

RUN apt-get clean \
 && rm -rf /var/cache/apt/* /var/lib/apt/lists/*

RUN pip3 install -U pip setuptools psycopg2-binary
RUN pip3 install yandex-pgmigrate

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d/
