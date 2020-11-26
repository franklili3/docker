# fmz robot for docker
```
docker build -q=false -t="fmz/docker" .
docker run --name=fmz/robot -d --user=10003 fmz/docker nohup ./robot -s node.fmz.com/XXX -p XXX &
```
