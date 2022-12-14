#!/usr/bin/env bash

SOURCEDIR=$(dirname ${BASH_SOURCE[0]})
DESTDIR=${HOME}/.config/docker

install_docker(){
	sudo systemctl start docker.service
	sudo systemctl enable docker.service
	sudo usermod -aG docker ${USER}
	newgrp docker
}

install_docker_compose() {
	install -d -m 755 ${DESTDIR}/cli-plugins/
	curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o ${DESTDIR}/cli-plugins/docker-compose
	chmod +x ${DESTDIR}/cli-plugins/docker-compose
}


install_docker
install_docker_compose