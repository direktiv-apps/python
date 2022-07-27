FROM golang:1.18.2-alpine as build

COPY build/app/go.mod src/go.mod
COPY build/app/cmd src/cmd/
COPY build/app/models src/models/
COPY build/app/restapi src/restapi/

RUN cd src/ && go mod tidy

RUN cd src && \
    export CGO_LDFLAGS="-static -w -s" && \
    go build -tags osusergo,netgo -o /application cmd/python-server/main.go; 

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && apt-get install -y \
		curl \
		locales 

RUN locale-gen en_US.UTF-8 
ENV LANG=en_US.UTF-8 \
	LANGUAGE=en_US:en \
	LC_ALL=en_US.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		cmake \
		gnupg \
		gzip \
		jq \
		libcurl4-openssl-dev \
		libssl-dev \
		make \
		net-tools \
		netcat \
		openssh-client \
		software-properties-common \
		tar \
		tzdata \
		unzip \
		wget \
		zip \
        build-essential \
		ca-certificates \
		libbz2-dev \
		liblzma-dev \
		libncurses5-dev \
		libncursesw5-dev \
		libreadline-dev \
		libffi-dev \
		libsqlite3-dev \
		libxml2-dev \
		libxmlsec1-dev \
		llvm \
		make \
		python-openssl \
		tk-dev \
		wget \
		xz-utils \
		zlib1g-dev

RUN add-apt-repository ppa:git-core/ppa && apt-get install -y git

RUN curl https://pyenv.run | bash 
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PYENV_ROOT=/root/.pyenv \
	PATH=/root/.pyenv/shims:/root/.pyenv/bin:/root/.poetry/bin:$PATH

# install n-2 (pyenv install --list)
RUN env PYTHON_CONFIGURE_OPTS="--enable-shared --enable-optimizations" pyenv install 3.10.5 && pyenv global 3.10.5
RUN env PYTHON_CONFIGURE_OPTS="--enable-shared --enable-optimizations" pyenv install 3.9.13
RUN env PYTHON_CONFIGURE_OPTS="--enable-shared --enable-optimizations" pyenv install 3.8.13

RUN python --version && \
	pip --version && \
	pip install pipenv wheel

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -

# DON'T CHANGE BELOW 
COPY --from=build /application /bin/application

EXPOSE 8080

CMD ["/bin/application", "--port=8080", "--host=0.0.0.0", "--write-timeout=0"]