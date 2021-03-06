#coding: utf-8
require_relative "ocr_element"
require 'nokogiri'
require 'pp'

class OCRPage < OCRElement
    
    attr_reader :meta_data, :page_number, :dimensions, :lines
    attr_accessor :image
    alias :each_block :each
    alias :blocks :children
    
    def initialize(file_path , image_path = nil )
        doc = process_hocr_html_file(file_path)
        page_content = doc.at_css("div.ocr_page")
        coordinates, @page_number = extract_bbox_ppageno( page_content['title'] )
        
        @page_content  = doc.at_css("div.ocr_page")
        children = OCRElement.extract_children(@page_content)
        super('ocr_page', children, coordinates)
        @image = image_path
    end
    
    
    def each_paragraph
        for block in blocks do
            for paragraph in block do
                yield paragraph
            end
        end
    end
    
    def each_line
        for block in blocks do
            for paragraph in block do
                for line in  paragraph do
                    yield line
                end
            end
        end
    end
    
    def each_word
        for block in blocks do
            for paragraph in block do
                for line in  paragraph do
                    for word in line do
                        yield word
                    end
                end
            end
        end
    end
    
    def words
        words = []
        each_word {|w| words << w }
        words
    end

    def extract_bbox_ppageno( ocr_html_text_fragment )
        bbox, ppageno = ocr_html_text_fragment.split(';')
        ppageno =~ /(\d+)/
        [ OCRElement.extract_coordinates_from_string(bbox) , $1.to_i ]
    end
    
    def process_hocr_html_file(filename)
        html_string = File.open(filename,"r").read
        Nokogiri::HTML(html_string).elements
    end
        
    def to_text
        Enumerator.new(self,:each_line).map {|line| line.to_text}.join("\n")
    end
    
    def to_image_html(options = {})
        zoom = options[:zoom] || 1
        display_class = options[:css_class] || css_class_string
        children_html = @children.map {|c| c.to_image_html(:zoom => zoom) }.join("")
        "<div class='#{ display_class }' style='position:absoulte; left:#{@left}px; top:#{@top}px; background-image: url(#{@image}); width:#{@width * zoom}px; height:#{@height * zoom}px;'>#{children_html}</div>"
    end
    
    def enclosed_words(ocr_box)
        enum = Enumerator.new(self,:each_enclosed_word,ocr_box)
        enum.inject([]) { |acc,w| acc << w}
    end
    
    def each_enclosed_word(ocr_box)
        each_word do |w|
            if w.enclosed_by? ocr_box then
                yield w
            end
        end
    end

    
end
