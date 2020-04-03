# libh3-sys - Wrapper for Uber’s Hexagonal Hierarchical Spatial Index in Rust

This crate provides unsafe Rust functions that call the underlying H3 library.

An interface to H3 using safe Rust is provided by [libh3](https://docs.rs/libh3/).

Contributions are welcome.

See the documentation here:

[https://docs.rs/libh3-sys/](https://docs.rs/libh3-sys/)

## Example `build.rs`
Assume you have vendored the [H3 project](https://github.com/uber/h3) into your crate's source tree at
`deps/h3`. You can now write a `build.rs` script which will statically build and link the external dependency
into your own crate, thus removing any dependency on any system installation of H3.

```rust
use cmake::Config;

fn main() {
    let build_type = if cfg!(debug_assertions) {
        "Debug"
    } else {
        "Release"
    };

    let dst = Config::new("deps/h3")
        .define("BUILD_TESTING", "OFF")
        .define("BUILD_GENERATORS", "OFF")
        .define("BUILD_BENCHMARKS", "OFF")
        .define("BUILD_FILTERS", "OFF")
        .define("ENABLE_LINTING", "OFF")
        .define("ENABLE_DOCS", "OFF")
        .define("ENABLE_COVERAGE", "OFF")
        .define("BUILD_TYPE", build_type)
        .build();
    println!("cargo:rustc-link-search=native={}/lib", dst.display());
    println!("cargo:cargo:include={}/include", dst.display());
    println!("cargo:rustc-link-lib=static=h3");
}
```

And add this to the `build-dependencies` section of your `Cargo.toml`:
```toml
[build-dependencies]
cmake = "0.1"
```
