# project_dom_tree
Like leaves on the wind

[A data structures, algorithms, file I/O, ruby and regular expression (regex) project from the Viking Code School](http://www.vikingcodeschool.com)

Rootnode = <html>

in <html> reach <head>
add <head> to <html> children and enter <head>

in <head> reach <title>
add <title> to <head> children and enter <title>

in <title> reach </title>
enter <title>'s parent <head>

in <head> reach </head>
enter <head>'s parent <html>

in <html> reach <body>

until current_node is nil

open .html each do |line|
  if tag = parse_tag(line)
  current_node = <head>
end

<head>

<body>

