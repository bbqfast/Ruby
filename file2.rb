# encoding: utf-8
require 'fileutils.rb'
require 'pathname.rb'
require "iconv"
require "open-uri"

puts 'start'

def pof_cp_fullpath
  src='C:/TrupanionTFS/Source/Trupanion.WebApps/Trupanion.Mobile/Trupanion.Mobile/Views/EnrollWizard/vet-info.cshtml'
  dst='//iisdev1/d$/Sites/m.trupanion.dev/Views/EnrollWizard/vet-info.cshtml'
  #FileUtils.cp_r(src,dst, :remove_destination => true)
  #FileUtils.rm(dst)
  FileUtils.cp(src,dst)
end

def search_file(folder, match)
  result=[]
  Dir.glob(folder+"/**/*").each do |x|
    purename = File.basename(x)
    #puts purename
    if (purename == match)
      result.push x
    end
  end
  return result
end

def smart_copy(srcroot,dstroot,match)
  srcpath=search_file(srcroot, match)
  dstpath=search_file(dstroot, match)
  if srcpath.length > 1 || dstpath.length > 1
    raise 'multiple match'
  end
  puts srcpath
  puts dstpath
  #FileUtils.rm(dstpath)
  FileUtils.cp(srcpath.first,dstpath.first)
end

def find_next_ascii(a)
  a=(a.ord + 1)
  if (a > 'z'.ord)
    return 'a'
  end
  return a.chr
end

def find_next_string(a)
  (a.ord + 1).chr
end

def dump_clip_id
  cid = 'a'
  for i in 0..100
    cid = find_next_ascii cid
    putc cid
  end
  puts
end

def byref_test(a)
  if a.nil?
    a={:val => 0}
  end
  a[:val] = a[:val] + 1
end

def byte_read_to_big5
  ec = Encoding::Converter.new("UTF-8", "Big5-HKSCS")
  convertedCount=0
  errorCount=0
  File.open("fff/wesley-utf8.txt", "r:utf-8") do |f|
    File.open("fff/wesley-big5-out.txt", "w:Big5-HKSCS") do |out|
      while line = f.getc
        begin
          line = ec.convert(line)
          out.putc line
          convertedCount += 1
        rescue 
          puts "Can't convert "
          errorCount += 1
        end
      end
    #out.write f.read
    end
  end
  puts "convertedCount=" + convertedCount.to_s, "errorCount=" + errorCount.to_s
end

def byte_read
  File.open("fff/wesley-utf8.txt", "r:utf-8") do |f|
    counter = 0
    while (line = f.getc)
      putc line 
      counter = counter + 1
    end
    puts "total count=" + counter.to_s
  end
end

def file_copy
  File.open("fff/tjautumn12_TTS.txt", "r") do |f|
    File.open("fff/copy-out.txt", "w") do |out|
      line = f.gets
      out.puts line
      out.write f.read
    end
  end
end

def convert_big5
  ec = Encoding::Converter.new("UTF-8", "Big5-HKSCS")

  File.open("fff/wesley-utf8.txt", "r:utf-8") do |f|
    File.open("fff/wesley-big5-out.txt", "w:Big5-HKSCS") do |out|
      #puts ec.convert("衛斯理大是反感：“每一個人都在努力想找出王大同神經失常之謎，她有甚么權反對這個反對那個？陳長青黃堂小郭，是眼前可以通知得到，而且又有")
      line = f.gets
      puts "length=" + line.length.to_s
      line = ec.convert(line[1..15])
      out.puts line
      out.write f.read
    end
  end
end

def pof_char_by_char_read
	File.open("fff/wesley-utf8.txt", "r:utf-8") do |infile|
	counter = 1
			while (line = infile.gets)
        puts line if !line.match("衛斯理").nil?
					# puts "#{counter}: #{line}" unless !line.match("衛斯理").nil?
					counter = counter + 1
			end# ... process the file
	end
end

def last_folder_from_dir(dir)
	folders=dir.split('/');
	#puts folders.to_s	
	#puts folders.last.to_s
	folders.last
end

def loop_dir
	i=0
	Dir.foreach('./fff') do |item|
		next if item == '.' or item == '..'
		fn = "each filename" + item
		fullpath = './fff/' + item.to_s
		puts fullpath
		#myfile = File.new(item)
		#ft = File.mtime(item)
		next if fullpath.nil?
		File.utime(Time.now + i, Time.now + i, fullpath)
		#puts "moded" + moded.to_s
		i=i+60
		#ft = myfile.mtime
		# FileUtils.touch fn
		#FileUtils.touch fn, :mtime => 0#Time.now #- 2.hours
		# fn = fn.gsub(ext, "xxx")
		puts (fn + File.mtime(fullpath).to_s)#+ ' ' + ft.to_s
		#!fullpath || puts (fn + File.mtime(fullpath))#+ ' ' + ft.to_s
		# do work on real items
	end
end

def with_cwd dir
  Dir.chdir dir do
    yield  
  end
end

def redate_order_by_filename(dir)
  file_list=get_file_list_with_path dir
	file_list.sort_by{|c| c.basename.to_s.downcase}.each do |f|
    puts f.basename
	end
end

def get_file_list_with_path(dir)
	file_list=[]
	Pathname.new(dir).each_child do |f|
			#puts f.to_s + " " + f.mtime.to_s
			file_list.push f
	end
end	

def rename_as_dir(dir)
	file_list=get_file_list_with_path dir
	count=1

	file_list.sort_by{|c| c.mtime}.each do |f|
		#puts f.to_s + " " + f.mtime.to_s
		fullpath = f.realpath.to_s
		newfilename = last_folder_from_dir(dir) + " " + count.to_s + f.extname
		with_cwd dir do
			#f.rename('fff' +  ' ' + count.to_s)
			puts newfilename
			File.rename(fullpath, newfilename)
		end
		count+=1
	end
end

def pof_string_match
  puts "match"
  puts "apple".match("pp")
  puts "match"
  puts "apple".match("ppx").nil?
  puts "not found" if "apple".match("ppx").nil?
  puts "not found" unless !"apple".match("ppx").nil?  
end

def pof_path_and_extensions
  puts 'fullpath= '+Pathname.new('./fff').realpath.to_s
  puts 'basename= '+Pathname.new('./fff/aaha_landingpage.jpg').dirname.to_s
  puts 'extname= '+Pathname.new('./fff/aaha_landingpage.jpg').extname.to_s
  puts 'lastFolder= '+  last_folder_from_dir(Pathname.new('./fff').realpath.to_s)
  puts "敢的女性"  
end

def setup_test_data
  #FileUtils.mkdir "./fff_b"
	FileUtils.rm_rf "./fff"
	sleep 1
	FileUtils.cp_r "./testfiles/fff", "."
end

setup_test_data

# puts "敢的女性".encode("Big5")

ec = Encoding::Converter.new("UTF-8", "Big5-HKSCS")
#ec = Encoding::Converter.new("UTF-8", "Big5-UAO")
#ec = Encoding::Converter.new("UTF-8", "GB18030")

puts ec.convert("敢的女性")

#puts find_next_ascii 'a'
#dump_clip_id
#x={:val => 3}
#byref_test(x)
#puts 'x=' + x[:val].to_s

#convert_big5
#byte_read
#byte_read_to_big5

#redate_order_by_filename './fff'
#pof_char_by_char_read

#rename_as_dir './fff'

#loop_dir
#last_folder_from_dir(Dir.pwd)

#puts Dir.entries('./fff') 
#puts 'last_folder_from_dir=' + last_folder_from_dir('D:/Usr/MySrc/Ruby/fff')

#puts Pathname.new('./fff').entries



puts 'done2'

  #ext = File.extname(item)
  #puts ext

