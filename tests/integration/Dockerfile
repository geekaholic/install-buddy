# ---- Runs integration tests ----

# --- Source --
FROM alpine:latest AS source
WORKDIR /app
COPY Gemfile /app/
COPY bin /app/bin
COPY lib /app/lib
COPY tests /app/tests


# --- Debian ---
FROM debian:latest AS debian

COPY --from=source app /app

# Install ruby and other deps
RUN apt-get update && apt-get install -y apt-utils ruby

WORKDIR /app
RUN echo 'Running tests on Debian' && /app/tests/integration/test.sh

# --- ElementaryOS(Ubuntu as base) ---
FROM elementary/docker:loki AS elementary

COPY --from=source app /app

# Install ruby and other deps
RUN apt-get update && apt install -y ruby

WORKDIR /app
RUN echo 'Running tests on ElementaryOS' && /app/tests/integration/test.sh

# --- Fedora ---
FROM fedora:latest AS fedora

COPY --from=source app /app

# Install ruby and other deps
RUN dnf install -y ruby

WORKDIR /app
RUN echo 'Running tests on Fedora' &&  /app/tests/integration/test.sh

# --- Archlinux ---
FROM base/archlinux:latest AS archlinux

COPY --from=source app /app

# Install ruby and other deps
RUN pacman -Syu --noconfirm
RUN pacman -Sy --noconfirm ruby

WORKDIR /app
RUN echo 'Running tests on Archlinux' &&  /app/tests/integration/test.sh

# --- All done ---
FROM alpine:latest
RUN echo -e "\n\033[0;32mAll integration tests ran successfully!\033[0m"
