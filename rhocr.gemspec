# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rhocr}
  s.version = "0.1.5"
  s.platform = Gem::Platform::RUBY

  s.authors = ["Andreas Neumann", "William Howard"]
  s.email = ["andreas@neumann.biz", "whoward.tke@gmail.com"]
  s.homepage = "http://github.com/daandi/rhocr"

  s.description = "Manipulate and use OCR data encoded in hOCR-Format see: http://code.google.com/p/hocr-tools/"

  s.files = Dir.glob("lib/**/*.rb")
  s.text_files = Dir.glob("test/**/*.rb")
  
  s.add_dependency "nokogiri"
end
