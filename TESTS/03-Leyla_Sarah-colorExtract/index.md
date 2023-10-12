``` bash
    find ./ -name "*.m4a" -exec ffmpeg -i {} -c:a aac -strict experimental {}.mp4 \;
```
