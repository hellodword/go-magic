# go-magic

## environment variables such as GODEBUG

- https://go.dev/doc/godebug [^1]

Go and its packages provide a mechanism called GODEBUG (or else) to reduce the impact such changes have on Go developers using newer toolchains to compile old code, but some of them are not documented, for example the `GODEBUG=quiclogpackets=1` for `golang.org/x/net/quic`: https://github.com/golang/net/blob/f95a3b3a48597cebf9849b84a02cd240fb185b16/quic/log.go#L19

I will try to use Github API and regex to find all of them.

- https://github.com/search?q=org%3Agolang+%2F%28%3F-i%29os%5C.Getenv%5C%28%5B%22%60%5D%5BA-Za-z_%5Cd%5D%2B%5B%22%60%5D%5C%29%2F+language%3AGo+NOT+path%3Atest+&type=code

The GitHub search only returs the first 100 results[^2] [^3], so I think I should clone and search them locally.

```go
// https://github.com/golang/go/blob/7f76c00fc5678fa782708ba8fece63750cb89d03/src/runtime/runtime1.go#L404C13-L404C32
gogetenv("GODEBUG")

os.Getenv("GODEBUG")
os.Setenv("GODEBUG", "")

// https://github.com/golang/go/blob/7f76c00fc5678fa782708ba8fece63750cb89d03/src/os/exec/exec.go#L406
// https://github.com/golang/go/blob/7f76c00fc5678fa782708ba8fece63750cb89d03/src/internal/godebugs/table.go#L19-L59
GODEBUG=

envOr("GOMODCACHE", "")

EnvVar{Name: "CGO_ENABLED"

// https://github.com/golang/go/blob/7f76c00fc5678fa782708ba8fece63750cb89d03/src/runtime/testdata/testprogcgo/catchpanic.go#L43
LookupEnv("CGOCATCHPANIC_EARLY_HANDLER"
```

[^1]: https://github.com/golang/go/blob/7f76c00fc5678fa782708ba8fece63750cb89d03/doc/godebug.md
[^2]: https://github.com/orgs/community/discussions/55202
[^3]: https://github.com/orgs/community/discussions/79052
