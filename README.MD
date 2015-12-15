
## Composer Perf Test

A totally legitimate and not at all hacky way of generating callgrind data to analyze Composer 'optimizations'.

## DO NOT RUN ON A MACHINE WITH PHP BACK GROUND TASKS

I don't seem to be able to get the PIDs of PHP or callgrind accurately and so I'm having

## How to run

Just doing `sh test.sh` should fire up a test server (using the built-in PHP server) and make some requests to it.

Callgrind/cachegrind files will be written to the current directory.

They should be analyzed, for stuff!

