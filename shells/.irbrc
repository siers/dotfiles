require 'rubygems'

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 20000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

require '/home/s/code/ruby/util/extend.rb'
