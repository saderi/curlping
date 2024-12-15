# curlping

> This repo is under development.

This is a simple script that ping url with curl and return reuslt like ping command.
I inspired by [httping-docker](https://github.com/BretFisher/httping-docker) repo.

## Usage
You can clone repo and run script or use the following command to add script to your system.
```bash
curl -o /usr/local/bin/curlping https://raw.githubusercontent.com/kyungw00k/curlping/master/curlping.sh
chmod +x /usr/local/bin/curlping
```

Then you can use `curlping` command like below:

```bash
$ curlping -u https://github.com
```

Also you can use `-s` option to spesisfy the time interval. default is 1 second.

```bash
$ curlping -u https://github.com -s 0.4
```

## License
WTFPL
