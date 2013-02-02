require 'fileutils.rb'
require 'pathname.rb'

require "win32/clipboard"
#require "pp"
include Win32


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
    puts srcpath
    puts dstpath
    raise 'multiple match'
  end
  puts srcpath
  puts dstpath
  #FileUtils.rm(dstpath)
  FileUtils.chmod 666, dstpath.first, :verbose => true
  FileUtils.cp(srcpath.first,dstpath.first)
end

def mobile
  sss = 'C:/TrupanionTFS/Source/Trupanion.WebApps/Trupanion.Mobile/Trupanion.Mobile'
  ddd = '//iisdev1/d$/Sites/m.trupanion.dev'
  #ddd = 'J:/Sites/m.trupanion.dev'
  #puts search_file(sss, 'create-account.html')
  
  #pof_cp_fullpath
  
  #smart_copy(sss,ddd, 'vet-info.cshtml')
  #smart_copy(sss,ddd, 'payment-method.cshtml')
  #smart_copy(sss,ddd, 'paymentPanelCreditCard.cshtml')
  #smart_copy(sss,ddd, 'paymentPanelBankAcct.cshtml')
  #smart_copy(sss,ddd, 'payment-review.cshtml')
  #smart_copy(sss,ddd, 'enroll-confirm.cshtml')
  #smart_copy(sss,ddd, 'trial-enroll-confirm.cshtml')
  #smart_copy(sss,ddd, 'testimonials.cshtml')
  #smart_copy(sss,ddd, 'signup.cshtml')
  #smart_copy(sss,ddd, 'policy-details.cshtml')
  #smart_copy(sss,ddd, 'faqs.cshtml')
  smart_copy(sss,ddd, 'get-a-quote.cshtml')
  smart_copy(sss,ddd, 'main.js')
  smart_copy(sss,ddd, '_mobileNumberPad.cshtml')
  smart_copy(sss,ddd, '_mobileDatePicker.cshtml')
  smart_copy(sss,ddd, 'mDatePicker.js')
  smart_copy(sss,ddd, 'mNumPad.js')
  smart_copy(sss,ddd, '_Layout.cshtml')
  #smart_copy(sss,ddd, '_PageFooter.cshtml')
  #smart_copy(sss,ddd, '')
  #smart_copy(sss,ddd, '')
  #smart_copy(sss,ddd, '')
  #smart_copy(sss,ddd, '')
  #smart_copy(sss,ddd, '')  
end

Clipboard.set_data("foobar")









