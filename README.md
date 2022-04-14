# Armcat
Print arm files as json.


## Usage
```sh
armcat <file.arm>
```

Pretty print using jq:
```sh
armcat <file.arm> | jq .
```

Pretty print using python json.tool:
```sh
armcat <file.arm> | python -m json.tool
```
