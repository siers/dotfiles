require 'rubygems'

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 10_000_000 # let's never lose it
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

require "#{ ENV['HOME'] }/code/ruby/util/extend.rb"
load "#{ ENV['HOME'] }/work/irbrc"

class Array
  def self.wrap(object)
    if object.nil?
      []
    elsif object.respond_to?(:to_ary)
      object.to_ary || [object]
    else
      [object]
    end
  end
end

def lines(fn); File.read(fn).each_line.to_a; end

def watch; loop do yield; sleep 1; end; end

def pl(list); p(*list); nil; end
