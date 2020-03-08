#!/bin/sh
bindgen /usr/local/Cellar/h3/3.6.3/include/h3/h3api.h -o src/bindings.rs  --size_t-is-usize --whitelist-function "h3rust.*" -- -DH3_PREFIX=h3rust_
cat src/bindings.rs | sed -e s/h3rust_//g > src/binds2
mv src/binds2 src/bindings.rs
