# Automatic building from hub.docker.com
FROM alpine:latest

MAINTAINER Manuel Kaufmann <humitos@gmail.com>

RUN apk add --no-cache \
        emacs-x11 \
        python3 \
        git \
        make \
        grep \
        diffutils \
        ctags \
        ack

# Make `python` the default for `python3`
RUN ln -s /usr/bin/python3 /usr/bin/python

COPY . /code

WORKDIR /code

RUN mkdir -p /root/.fonts
RUN mv -f Menlo-Regular.ttf /root/.fonts

# Disable ERC
RUN mv -f startup.d/erc.el startup.d/erc.el.disabled

# Install python dependecies for emacs' plugins
RUN pip3 install --no-cache-dir -U pip
RUN pip3 install --no-cache-dir -r requirements.elpy.in

# Compile helm
RUN cd vendor/helm && make

# Set the `emacs-user-directory` used from the `init.el` file
ENV EMACS_USER_DIRECTORY /code/

# Used to set the proper ctags executable
ENV DOCKER true


WORKDIR /src

CMD sh -c "emacs --no-site-file --no-splash --load /code/.emacs.docker"
