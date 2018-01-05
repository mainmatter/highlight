Highlight
=========

[![Build Status](https://travis-ci.org/simplabs/highlight.png)](https://travis-ci.org/simplabs/highlight)

Highlight is a simple syntax highlighting gem for Ruby and Rails. It's basically a
wrapper around the popular [http://pygments.org](http://pygments.org) highlighter that's
written in Python and supports an impressive number of languages.

If pygments is installed on the machine and in the `PATH`, that binary is used, otherwise
the plugin falls back to the web API at [https://pygments.simplabs.com/](https://pygments.simplabs.com/),
created by Trevor Turk.

See the API docs at [http://rdoc.info/projects/simplabs/highlight](http://rdoc.info/projects/simplabs/highlight).

Usage
-----

Highlight can either be used standalone via

```ruby
require 'simplabs/highlight'
Simplabs::Highlight.highlight(:ruby, 'class Test; end')
```

or in Rails where it adds the `highlight_code` helper:

```ruby
highlight_code(language, code = nil, &block)
```

`language` may be either a Symbol or a String (see supported languages
below). The code can be passed either as a string or inside a block, e.g.:

```ruby
highlight_code(:ruby, 'class Test; end')
```

or

```ruby
highlight_code(:ruby) do
  klass = 'class'
  name  = 'Test'
  _end  = 'end'
  "#{klass} #{name}; #{_end}"
end
```

Since highlighting the code takes a while, all highlighted source code
should be cached, e.g.:

```ruby
<%- code = 'class Test; end' -%>
<%- cache Digest::SHA1.hexdigest(code) do -%>
  <%= highlight_code(:ruby, code) -%>
<%- end -%>
```


Supported Languages
-------------------

The following languages are supported (there are probably more that are supported by `pygments`).
All of the paranthesized identifiers may be used as parameters for highlight to denote the
language the source code to highlight is written in (use either Symbols or Strings).

  * Actionscript (`as`, `as3`, `actionscript`)
  * Applescript (`applescript`)
  * bash (`bash`, `sh`)
  * C (`c`, `h`)
  * Clojure (`clojure`)
  * C++ (`c++`, `cpp`, `hpp`)
  * C# (`c#`, `csharp`, `cs`)
  * CSS (`css`)
  * diff (`diff`)
  * Dylan (`dylan`)
  * Erlang (`erlang`, `erl`, `er`)
  * HTML (`html`, `htm`)
  * Java (`java`)
  * JavaScript (`javascript`, `js`, `jscript`)
  * JSP (`jsp`)
  * Make (`make`, `basemake`, `makefile`)
  * Objective-C (`objective-c`)
  * OCaml (`ocaml`)
  * Perl (`perl`, `pl`)
  * PHP (`php`)
  * Python (`python`, `py`)
  * RHTML (`erb`, `rhtml`)
  * Ruby (`ruby`, `rb`)
  * Scala (`scala`)
  * Scheme (`scheme`)
  * Smalltalk (`smalltalk`)
  * Smarty (`smarty`)
  * SQL (`sql`)
  * XML (`xml`, `xsd`)
  * XSLT (`xslt`)
  * YAML (`yaml`, `yml`)


Installation
------------

Installation is as easy as

```bash
gem install highlight
```

To use highlight in Rails apps, you have to define the dependency in the Gemfile:

```ruby
gem 'highlight', :require => 'simplabs/highlight'
```

Highlight also comes with a default CSS file that defines styles for the highlighted code. This CSS file can be copied to
your application's `public/stylesheets` directory via

```bash
./bin/rails generate highlight_styles
```

If you don't have python and pygments installed, you will need that too.
For instructions on installing pygments, refer to
[http://pygments.org/docs/installation/](http://pygments.org/docs/installation/).


Author
------

Copyright (c) 2008-2010 Marco Otte-Witte ([http://simplabs.com](http://simplabs.com)),
released under the MIT license


Acknowledgements
----------------

The actual highlighting is done by Pygments ([http://pygments.org](http://pygments.org)).
