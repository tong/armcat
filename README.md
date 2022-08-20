# Armcat
Print binary [armory3d](https://armory3d.org/) `arm` files as json.


## Example Usage

```sh
armcat <file.arm>
```

- Pretty print using [jq](https://stedolan.github.io/jq/)
```sh
armcat <file.arm> | jq .
```

- Print `Scene.arm` objects
```sh
armcat <file.arm> | jq .objects
```

- Print all traits of all `Scene.arm` objects
```sh
armcat Scene.arm | jq ".objects[].traits"
```

- Live preview integration for the [lf](https://github.com/gokcehan/lf/) file
  manager: [lf/preview#L35](https://github.com/tong/dotfiles/blob/0ace45ba3b31208546e1ab3be3250f669596a532/lf/.config/lf/preview#L35)  
```sh
armcat "$1" | jq . | bat --language json --color=always
```

![](lf-armcat.png)

