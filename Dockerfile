FROM debian:bookworm

WORKDIR /

ARG WHEEL_URL="https://files.catbox.moe/g2lvpa.whl"
ARG WHEEL_NAME="chirp-20260130-py3-none-any.whl"

# Install build dependencies
RUN apt update && apt install -y \
        wget build-essential libssl-dev zlib1g-dev libncurses5-dev \
        libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev \
        libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev \
        libffi-dev libnss3-dev

# Build and install Python 3.10 into /build/usr
RUN mkdir -p /build/usr \
    && wget https://www.python.org/ftp/python/3.10.12/Python-3.10.12.tgz \
    && tar xvf Python-3.10.12.tgz \
    && cd Python-3.10.12 \
    && ./configure --prefix=/build/usr --enable-optimizations \
    && make -j$(nproc) \
    && make install \
    && cd .. \
    && rm -rf Python-3.10.12 Python-3.10.12.tgz


RUN apt-get update && apt-get install -y \
    libgtk-3-dev \
    curl

RUN /build/usr/bin/python3.10 -m ensurepip \
    && /build/usr/bin/python3.10 -m pip install --upgrade pip setuptools wheel

RUN curl -o "$WHEEL_NAME" "$WHEEL_URL"  && \
    /build/usr/bin/python3.10 -m pip install --prefix=/build/usr "$WHEEL_NAME" && \
    sed -i '1d' /build/usr/bin/chirp

RUN /build/usr/bin/python3.10 -m pip install attrdict3
RUN /build/usr/bin/python3.10 -m pip install --prefix=/build/usr --no-build-isolation https://files.pythonhosted.org/packages/d9/33/b616c7ed4742be6e0d111ca375b41379607dc7cc7ac7ff6aead7a5a0bf53/wxPython-4.2.0.tar.gz

COPY Chirp.AppDir/ /build/
RUN chmod +x /build/AppRun

RUN mkdir -p /tmp/appdir
CMD ["cp", "-r", "/build", "/tmp/appdir"]
