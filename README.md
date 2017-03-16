# docker-meteor-chimp-ci
Everything you need to get chimp running in your CI

## Running it
```
$ alias chimp="docker run -it --rm -v $PWD:/app astrocoders/chimp"

# Supposing your tests are in a dir called tests
chimp --mocha --ddp=http://localhost:3000/ --path=tests
```
