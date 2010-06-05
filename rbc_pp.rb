#!/usr/bin/env ruby
##################
#
#  rbc_pp.rb: a ruby script to process ruby macros in
#     other source files.
#
#  author: gordon.sommers@gmail.com
#

class Integer
  def even?
    self % 2 == 0
  end
  def odd?
    not even?
  end
end

def parse_file(in_fh, out, start="$START$", stop="$STOP$")
  re = /#{Regexp.quote(start)}(.+?)#{Regexp.quote(stop)}/m;
  source_blocks = in_fh.read.split(re)
  source_blocks.each_index do |i|
    out.print source_blocks[i] if i.even?
    out.print eval(source_blocks[i]) if i.odd?
  end
end

def usage
  puts "usage: #{$0} [-X start stop] [file]"
  puts <<END
  defaults:  start        $START$
             stop         $STOP$
             file         STDIN
END
end

if __FILE__ == $0
  xloc = ARGV.index("-X")
  floc = nil
  fname = nil
  start = "$START$"
  stop = "$STOP$"
  if (xloc)
    if (xloc + 2 >= ARGV.length) then usage; exit 1; end
    start = ARGV[xloc+1]
    stop = ARGV[xloc+2]
    if (FileTest.exist?(start) || FileTest.exist?(stop))
      STDERR.puts "*WARN*: you specified a filename as your START or STOP arg\n*WARN*:  are you sure you passed your arguments in the right order?"
    end
    floc = (xloc + 3 >= ARGV.length) ? xloc - 1 : xloc + 3
    fname = (floc >= 0) ? ARGV[floc] : nil if floc
  else
    fname = ARGV[0] if ARGV[0]
  end

  f = (fname) ? File.open(fname) : STDIN
  parse_file(f, STDOUT, start, stop)
  f.close if fname #if we used a file, close it
end
##### ##### ##### ##### #####

