# Simple git sync

This script simply sync git repo from `source` to `target`

**It works only with ssh@git**

**https:// not supported now**

## SSH keys

It uses` id_ed25519` SSH keys from [.ssh](./.ssh) folder to run on server with crontab

## Usage

Script works only with `git@ssh` url, `https://` doesn't work

Install requirements and add SSH keys:
* `./install.sh`

Manually run:
* `./sync.sh git@source git@target`

Run with config (don't forget to edit `config.conf` for your needs, [check example](./config-sample.conf)):
* `./sync.sh -c`

Config example:
```
sourceRepo targerRepo
```

You set source git repo _space_ target git repo

### Run with crontab

* `crontab -e`
* `* */6 * * * /bin/bash /var/git/simple-git-mirror-sync/sync.sh -c >/dev/null 2>&1`
    * `/bin/bash` - path to `bash` on your server, you can check it with `which bash` on your server
    * `/var/git/simple-git-mirror-sync/sync.sh` - full path to this script

## License

* Contributing are welcome!
* [MIT](./LICENSE)
* [lgg](https://github.com/lgg), 2020
