#!/usr/local/bin/node

// HACK: just calls `lib/cli-lib` to workaround CoffeeScript emitting
// javascript comment "Generated by CoffeeScript x.x.x" as first line
// which interfers with bash invoker above.

require('./lib/cli-lib');
