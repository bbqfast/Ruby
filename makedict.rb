require 'fileutils.rb'
require 'pathname.rb'
#require "iconv"
require "open-uri"

def read_to_hash(fname, dict)
  File.open(fname, "r:utf-8") do |f|
    while(line = f.gets)
      item = line.split(' ')
      dict[item[0]] = item[1].to_i
      #puts item.to_s
    end
  end
end

def write_from_hash_js(fname, dict)
  File.open(fname, "w") do |out|
    out.puts 'var dictdata=['
    dict.each_key do |x|
      if (x.include? "'")
        next
      end
      # out.puts "\"#{x}\" : \"#{dict[x].to_s}\","
      out.puts "[\"#{x}\" , \"#{dict[x].to_s}\"],"
    end
    out.puts '];'
    out.puts "module.exports.dictdata = dictdata;";
  end
end

def write_from_hash(fname, dict)
  File.open(fname, "w") do |out|
    dict.each_key do |x|
      out.puts x + ' ' + dict[x].to_s
    end
  end
end

def pof_read_words(fname, dict)
  hash = dict
  #puts 'hash=' + dict.to_s
  File.open(fname, "r") do |f|
    while(line = f.gets)
      words = line.split(/[ ,.:"')({}-]/)
      words.each do |e|
        if (e =~ /[0-9?]/ )
          next
        end
        
        e=e.downcase
        #puts e
        if !hash[e].nil?
          hash[e]=hash[e] + 1
        end
      end
    end
  end
  #hash.sort_by {|_key, value| value}
  hash.sort {|a1,a2| a2[1]<=>a1[1]}
end

def printSortedHash(hash)
  list = hash.sort {|a1,a2| a2[1]<=>a1[1]}
  list.each do |x|
    if (x[1] > 50)
      puts x[0] + ' (' + x[1].to_s + ')'
    end
  end  
  puts 'total word' + list.length.to_s
end

def get_output_name(fn)
  oldname = File.basename(fn, '.*')
  num = oldname[/-([0-9]+)/, 1]
  oldname = oldname.sub(/-[0-9]+/, '')
  if num.nil?
    num = 0
  else
    num = num.to_i
  end
  num = num + 1
  
  return oldname + "-#{num}" + File.extname(fn)
  
end
 
dict = {}
fn = 'orig-1.txt'
read_to_hash(fn, dict)
bookfile = '5 - Apollyon.txt'
#pof_read_words(bookfile, dict)

#newfn = get_output_name(fn)
#newfn = fn
newfn = 'thedict.js'; 
puts 'new file=' + newfn
write_from_hash_js(newfn, dict)
printSortedHash(dict)


