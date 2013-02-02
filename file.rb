# encoding: utf-8

require 'fileutils.rb'
require 'pathname.rb'
puts 'start'

def open_test
	File.open("file.txt", "r") do |infile|
	counter = 1
			while (line = infile.gets)
					puts "#{counter}: #{line}"
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

def setup_test_data
	FileUtils.rm_rf "./fff"
	sleep 1
	FileUtils.cp_r "./testfiles/fff", "."
end

setup_test_data

puts 'fullpath= '+Pathname.new('./fff').realpath.to_s
puts 'basename= '+Pathname.new('./fff/aaha_landingpage.jpg').dirname.to_s
puts 'extname= '+Pathname.new('./fff/aaha_landingpage.jpg').extname.to_s
puts 'lastFolder= '+  last_folder_from_dir(Pathname.new('./fff').realpath.to_s)
puts "´±ªº¤k©Ê"

redate_order_by_filename './fff'

#rename_as_dir './fff'

#loop_dir
#last_folder_from_dir(Dir.pwd)

#puts Dir.entries('./fff') 
#puts 'last_folder_from_dir=' + last_folder_from_dir('D:/Usr/MySrc/Ruby/fff')


#file_list.each do |f|
#	puts "-" + f.to_s + " " + f.mtime.to_s
#end

#FileUtils.mkdir "./fff_b"

#puts Pathname.new('./fff').entries



puts 'done2'

  #ext = File.extname(item)
  #puts ext

