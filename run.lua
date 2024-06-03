#!/usr/bin/env luajit
require 'local-default'
assert(loadfile((...)))(select(2, ...))
