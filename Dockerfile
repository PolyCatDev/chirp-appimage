FROM debian:bookworm

WORKDIR /

# Install build dependencies
RUN apt update && apt install -y \
        wget build-essential libssl-dev zlib1g-dev libncurses5-dev \
        libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev \
        libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev \
        libffi-dev libnss3-dev;

# Build and install Python 3.10 into /build/usr
RUN mkdir -p /build/usr \
    && wget https://www.python.org/ftp/python/3.10.12/Python-3.10.12.tgz \
    && tar xvf Python-3.10.12.tgz \
    && cd Python-3.10.12 \
    && ./configure --prefix=/build/usr --enable-optimizations \
    && make -j$(nproc) \
    && make install \
    && cd .. \
    && rm -rf Python-3.10.12 Python-3.10.12.tgz;


RUN apt-get update && apt-get install -y \
    libgtk-3-dev \
    lynx;

RUN /build/usr/bin/python3.10 -m ensurepip \
    && /build/usr/bin/python3.10 -m pip install --upgrade pip setuptools wheel;

RUN lynx -source "https://archive.chirpmyradio.com/chirp_next/next-20251212/chirp-20251212-py3-none-any.whl" > chirp-20251212-py3-none-any.whl && \
    /build/usr/bin/python3.10 -m pip install --prefix=/build/usr chirp-20251212-py3-none-any.whl && \
    sed -i '1d' /build/usr/bin/chirp;

RUN /build/usr/bin/python3.10 -m pip install attrdict3;
RUN /build/usr/bin/python3.10 -m pip install --prefix=/build/usr --no-build-isolation https://files.pythonhosted.org/packages/d9/33/b616c7ed4742be6e0d111ca375b41379607dc7cc7ac7ff6aead7a5a0bf53/wxPython-4.2.0.tar.gz;

COPY Chirp.AppDir/ /build/
RUN chmod +x /build/AppRun;

RUN mkdir -p /tmp/appdir;
CMD ["cp", "-r", "/build", "/tmp/appdir"]


