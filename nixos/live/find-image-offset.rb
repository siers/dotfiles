#! /usr/bin/env ruby

raise "no root" unless Process.uid == 0

raise 'no device' unless (device = ENV['device'])
whole = %x{blockdev --getsz "#{device}"}.to_i

raise 'no image' unless File.exists?('image')
image_size = %x{du -B 512 image}.to_i

byte_offset = (whole - image_size - 1024 ** 2) * 512

env_bs = ENV.fetch('bs', 1)
bs = {
  '1M' => 1024 ** 2,
}.fetch(env_bs, env_bs).to_i

puts(byte_offset / bs)
