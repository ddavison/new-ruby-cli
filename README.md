new-ruby-cli
---

A simple bootstrap script that will create everything you need for a new ruby CLI app.

Simply include the bash script via `source`, and be on your way.

Example:
```bash
$ source new-ruby-cli.sh
$ new-ruby-cli app
$ tree app
app
├── README.md
├── bin
│   └── app
└── lib
    ├── app
    │   ├── commands.rb
    │   └── version.rb
    └── app.rb
$ cd bin
$ ./app
Usage: app [options] ...
    -v, --version                    Show the version
    -h, --help                       Show the usage
```

### Known caveats
- Since the generation is based on the name, names with Dashes **do not work**. You'll have to refactor your module
- This project will generate a gitignore using the [`gi`](http://gitignore.io) CLI.  If you do not have `gi` in your path, then i'm not sure what'll happen :)

