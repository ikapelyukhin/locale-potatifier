#!/usr/bin/env ruby

def make_mess(str)
  str.tr('A-Za-z', 'АБЦДЕФГХИЖКЛМНОПКРСТУВВКЫЗабцдефгхижклмнопкрстуввкыз').gsub('\\н', '\\n')
end

msgids = []

msgid = nil
File.readlines(ARGV[0]).each do |line|
  if line =~ /^msgid (".*?")/
    msgids << msgid if msgid
    msgid = []
    msgid << $1
  elsif line =~ /^"/
    msgid << line if msgid
  else
    next
  end
end

msgids << msgid if msgid

msgids.shift
msgids.each do |msgid|
  puts "msgid " + msgid.map { |str| str.strip }.join("\n")
  puts "msgstr " + msgid.map { |str| make_mess(str).strip }.join("\n")
  puts "\n"
end
