compensated
===========

[![Build Status](https://secure.travis-ci.org/analytics/compensated.png)](http://travis-ci.org/analytics/compensated)

This package provides a form of compensated arithmetic that lets you perform many operations on chains of doubles at higher precision.

In particular addition, multiplication, etc. on a `Compensated Double` is done with twice as many bits of `significand` as on a raw `Double`.

This construction is designed so that it can be iterated.

This was forked from the [analytics](http://github.com/analytics/analytics.git) repository after repeated requests.

Work still needs to be done to properly support most `Floating` operations, but everything below that level of the numeric hierarchy should work.

Contact Information
-------------------

Contributions and bug reports are welcome!

Please feel free to contact me through github or on the #haskell IRC channel on irc.freenode.net.

-Edward Kmett
