(list
  "[" @delimiter
  "]" @delimiter) @container

(block
  "{" @delimiter
  "}" @delimiter) @container

(arg_block
  "(" @delimiter
  ")" @delimiter) @container

(string
  "{" @delimiter
  "}" @delimiter) @container
