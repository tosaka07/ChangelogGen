# ChangelogGen

ChangelogGen is a command-line tool that generates changelog from milestone.

```sh
$ changeloggen generate --token '...' -m '1.2.0' -t 'tosaka07/changeloggen'
```

## Installation

### Homebrew

```sh
$ brew install tosaka07/tap/changeloggen
```

### Mint

```sh
$ mint install tosaka07/ChangelogGen
```

### Manual

```sh
$ git clone https://github.com/tosaka07/ChangelogGen.git
$ make install
```

## Usage

Run changeloggen help to see usage instructions.

```
USAGE: changeloggen generate --token <token> --milestone <milestone> [--spec <spec>] [--target <target>] [--labels <labels>] [--labels-prefix <labels-prefix>] [--format <format>] [--prefix <prefix>] [--suffix <suffix>] [--verbose]

OPTIONS:
  --token <token>         GitHub access token.
  -m, --milestone <milestone>
                          Milestone title.
  -s, --spec <spec>       The path to the spec file. Defaults to changeloggen.yml
  -t, --target <target>   The repositorie that generate change logs. Format is 'owner/repo'
  -l, --labels <labels>   Labels to filter issues. Format is 'AAAA,BBBB'.
  --labels-prefix <labels-prefix>
                          Characters to filter when outputting label sections..
  -f, --format <format>   Format of changes. Defaults to '{title} #{number} @{user}'
  --prefix <prefix>       Prefix
  --suffix <suffix>       Suffix
  -v, --verbose
  --version               Show the version.
  -h, --help              Show help information.
```

### changeloggen.yml

You can specify a spec with yml.

```yml
target: "tosaka07/ChangelogGen"
labels:
  label:
    - "Type: Added"
    - "Type: Fixed"
    - "Type: Changed"
  prefix: "Type: "
format: "{title} #{number} @{user}"
prefix: "This is prefix"
suffix: "This is suffix"
```

## Development

**open project with Xcode**

```sh
$ make generate
$ open ChangelogGen.xcodeproj
```

**Local build**

```
$ make build-debug
$ ./build/debug/changeloggen ...
```

**Release build**

```sh
$ make build
```

## License

MIT
