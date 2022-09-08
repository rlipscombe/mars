# Problem: Martian Robots

This repository contains four solutions to the problem.

## Elixir Livebook

The first is as an Elixir Livebook. For installation instructions, go to <https://livebook.dev/>. At the time of
writing, the current version of Livebook is 0.6.3.

To open the livebook:

1. Run the 'Livebook' application. It will open a web browser.
2. On the 'Home' page, navigate to the `mars.livemd` notebook and open it.
3. Press `Esc`, `e`, `a` to evaluate the notebook.
4. Enter your sample input in the relevant place.
5. Press `Esc`, `e`, `a` to evaluate the notebook.

## Dart

The second uses Dart; see <https://dart.dev/>. Look in the `mars` directory.

## GNU awk

> Because if it can't be done with bash and awk [...], it's not worth doing.

-- <https://twitter.com/rogerlipscombe/status/1070727244136497153>

```
gawk -f mars.awk < input.txt
```

## Rust

In the `redplanet` directory.

```
cargo run
```
