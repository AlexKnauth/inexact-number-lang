#lang scribble/manual

@title{inexact-number-lang}

source code: @url["https://github.com/AlexKnauth/inexact-number-lang"]

@defmodulelang[inexact-number]{
A lang-extension that reads all numbers as inexact, whether they have a decimal point or not.

Example:

@codeblock|{
#lang inexact-number racket

5
; => 5.0
1/2
; => 0.5
-0
; => -0.0
(/ -0)
; => -inf.0
}|
}
