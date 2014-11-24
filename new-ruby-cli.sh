function new-ruby-cli {
  if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <app-name>"
  else
    product_name="$1"
    module_name="$(tr '[:lower:]' '[:upper:]' <<< ${product_name:0:1})${product_name:1}"
    $(
      mkdir ${product_name}
      cd ${product_name}
      mkdir bin
      mkdir lib
      gi ruby,intellij > .gitignore

      echo "#!/usr/bin/env ruby

$:.unshift File.expand_path('../../lib', __FILE__)

require '${product_name}'
require '${product_name}/commands'" > "bin/${product_name}"
      chmod u+x "bin/${product_name}"
      mkdir "lib/${product_name}"

      echo "#encoding utf-8
module ${module_name}
  VERSION = '0.0.1'
end
" > "lib/${product_name}/version.rb"

      echo "#encoding utf-8
module ${module_name}
  class Runner
    def initialize(args=[])

    end
  end
end
" > "lib/${product_name}.rb"


      echo "# encoding: utf-8
require 'optparse'

options = {}

OptionParser.new do |opts|
  opts.banner = 'Usage: ${product_name} [options] ...'

  opts.on('-v', '--version', 'Show the version') do
    require '${product_name}/version'
    puts ${module_name}::VERSION
    exit
  end

  opts.on('-h', '--help', 'Show the usage') do
    puts opts
    exit
  end

  if ARGV.size <= 0
    puts opts
    exit 1
  end

  opts.parse!
end

if ARGV.size > 0 && !File.exists?(ARGV.first)
  puts \"#{ARGV.first} doesn't exist\"
  exit 1
end

if options.empty?
  ${module_name}::Runner.new(ARGV)
else
  ${module_name}::Runner.new(ARGV, options)
end" > "lib/${product_name}/commands.rb"

      echo "${product_name}
---
" > "README.md"
    )
    echo "${product_name} created."
  fi
}