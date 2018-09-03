FROM ubuntu:latest

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y apt-transport-https
RUN apt-get install -y python-pip golang-go stacks docker.io curl wget
RUN pip install --upgrade pip
RUN pip install azure-cli

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.9.0/bin/linux/amd64/kubectl

RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

RUN wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz

RUN tar -xvf go1.10.3.linux-amd64.tar.gz
RUN mv go /usr/local

#RUN export GOROOT=/usr/local/go
ENV GOROOT=/usr/local/go

#RUN export GOPATH=$HOME/Projects/Proj1
ENV GOPATH=$HOME/Projects/Proj1

#RUN export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH

RUN go get -u github.com/cloudflare/cfssl/cmd/cfssl
