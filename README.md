# AppImage Distribution of [CHIRP](https://chirpmyradio.com/projects/chirp/wiki/Home)

There already exists an [official AppImage deployment](https://github.com/goldstar611/chirp-appimage), but I’ve had issues with it. This deployment bundles more dependencies in the AppImage.

### What is bundled

* CHIRP wheel
* Python 3.10
* wxPython

## Build Locally

`docker` and `curl` required

```sh
chmod +x ./buildapp.sh && ./buildapp.sh
```

The AppImage will be found in `./dist/`.
