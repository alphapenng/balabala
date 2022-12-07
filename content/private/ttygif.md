---
2022-12-06 16:13:55
---

# ttygif

## Setup

### macOS

```bash
$ brew install ttygif
```

## Usage

1. Create ttyrec recording

    ```bash
    $ ttyrec myrecording
    ```

    - Hit CTRL-D or type `exit` when done recording.

2. Convert to gif

    ```bash
    $ ttygif myrecording
    ```

    On OSX optionally you can set a -f flag which will bypass cropping which is needed for terminal apps which aren't full screen. Both standard Terminal and iTerm apps are supported.

    ```bash
    $ ttygif myrecording -f
    ```

## Additional Notes

If you're getting `Error: WINDOWID environment variable was empty.`, then you need to manually set `WINDOWID`.

```bash
export WINDOWID=23068679
```
