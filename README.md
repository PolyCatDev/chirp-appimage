# AppImage Distribution of [CHIRP](https://chirpmyradio.com/projects/chirp/wiki/Home)

> [!WARNING]
> This project has been superseeded by [my flatpak that can be found on flahub](https://flathub.org/en/apps/com.chirpmyradio.chirp).

There already exists an [official AppImage deployment](https://github.com/goldstar611/chirp-appimage), but I’ve had issues with it. This deployment includes CHIRP-next’s version specific dependencies directly in the AppImage.

### What is bundled

- CHIRP wheel
- Python 3.10
- wxPython 4.2.0

## Build Locally

`docker` and `curl` required

```sh
chmod +x ./buildapp.sh && ./buildapp.sh
```

The AppImage will be found in `./dist/`.
