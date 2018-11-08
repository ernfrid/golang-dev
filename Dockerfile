FROM golang:1.11-stretch

ARG username=ernfrid

RUN apt-get update -qq && \
    apt-get install -y \
        vim \
        sudo && \
    useradd -Ms /bin/bash ${username} && \
    mkdir /home/${username} && \
    echo "export PATH=$PATH:/home/${username}/.local/bin" > /home/${username}/.profile && \
    chown -R ${username} /home/${username}/ && \
	chgrp -R ${username} /home/${username}/ && \
    echo "${username} ALL=(ALL:ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo

USER ${username}    
WORKDIR /home/${username}
RUN mkdir -p go/bin go/pkg go/src
ENV GOPATH=/home/${username}/go
ENV PATH=${GOPATH}/bin:${PATH}
ENV TERM=screen-256color
    
CMD ["/bin/bash", "-l"]
