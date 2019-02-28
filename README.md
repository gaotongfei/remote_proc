# remote_proc

## Usage

* server
```
bin/remote_proc -b 127.0.0.1 -p 8099 -c 10 --commands-dir="./commands_example"
```

* client

```
$ bundle console

# in console
RemoteProc.call('hello', {name: 'tongfei'})
```


