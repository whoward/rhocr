#coding: utf-8
require_relative "ocr_element"
require 'nokogiri'
require 'pp'

class OCRPage < OCRElement
    
    attr_accessor :meta_data, :page, :dimensions

    def initialize(filename)

       
    end
    
    def each
        
    end
    
    def each_block
       
    end
    
    def each_paragraph
       
    end
    
    def each_line
        
    end
    
    def each_word
        
    end
    
    def extract_page_dimensions_and_number( ocr_html_text_fragment )
        bbox, ppageno = ocr_html_text_fragment.split(';')
        ppageno =~ /(\d+)/
        [extract_coordinates_from_string(bbox), $1 ]
        
    end
    
    def process_hocr_html_file(filename)
        hocr_doc = Nokogiri::HTML(File.open(filename,"r"))
       
    end
    
    def enclosed_words(box)
    end
    
end
