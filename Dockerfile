FROM ubuntu:16.04

MAINTAINER Manuel Kaufmann <humitos@gmail.com>

RUN apt-get update -y && \
    apt-get install -y software-properties-common

RUN add-apt-repository -y ppa:ubuntu-elisp/ppa && \
    apt-get -y update && \
    apt-get install -y \
            git \
            build-essential \
            python-pip \
            python3-venv \
            dbus-x11 \
            emacs-snapshot

RUN git clone \
    --depth 1 \
    https://github.com/humitos/emacs-configuration.git /code && \
    cd /code && \
    git submodule init && \
    git submodule update

WORKDIR /code

# Disable ERC
RUN mv --force startup.d/erc.el startup.d/erc.el.disabled

# Compile helm
RUN cd vendor/helm && make && cd -

# Install python dependecies for emacs' plugins
RUN pip install -U pip \
    && pip install -r requirements.elpy.in

# Set the `emacs-user-directory` used from the `init.el` file
ENV EMACS_USER_DIRECTORY /code/

RUN mkdir -p /root/.fonts
COPY Menlo-Regular.ttf /root/.fonts

# I don't know why but the first time fails because of something related to X11
# X protocol error: BadAccess (attempt to access private resource denied) on protocol request 130
CMD emacs-snapshot --no-site-file --no-splash --load .emacs.docker > /dev/null \
    ; emacs-snapshot --no-site-file --no-splash --load .emacs.docker
