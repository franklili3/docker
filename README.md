# fmz robot for docker
```
docker build -q=false -t="fmz/docker" .
export id=XXX
export password=XXX
docker run --name=fmz/robot exec nohup ./robot -s node.fmz.com/$id -p $password & fmz/docker
```
