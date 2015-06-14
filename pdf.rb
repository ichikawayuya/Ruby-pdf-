#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'pdf/reader'



#ページ枚数を取得する
def Page()
	File.open("/Users/ichikawayuya/Desktop/guraduate.pdf", "rb") do |io|
	  reader = PDF::Reader.new(io)
	  return reader.page_count
	end
end
#pdfの文字を格納する
def pdf_to_array(page)
	#ページの枚数だけ配列を用意
	str = Array.new(page)
	count = 0

	File.open("/Users/ichikawayuya/Desktop/guraduate.pdf", "rb") do |io|
	  # インスタンス化
	  reader = PDF::Reader.new(io)	
	  # ページ単位で文字列を格納
	  reader.pages.each do |page|
		str[count] = page.text
		count = count + 1
	  end
	end
	return str
end


#正規表現を用いて必要な文字列を取得する
def RegularExpression(str, page)
	text = Array.new(1000)
	count = 0
	
	for i in 0..page do
		loop{
			if/([^\s]*)\b[0-9]*/ =~ str[i] then
  				text[count] = $&
				#正規表現の結果から基の文字列を削除する 
				str[i].slice!("#{$&}")
				 count= count + 1
			else
				break
			end
		}
	end
	
	return text
end



if __FILE__ == $0
	page = Page()
	array = pdf_to_array(page)
	str =RegularExpression(array, page)
	for i in 0 .. 1000 do
		print i 
		print ":"
		puts str[i] 
	end
	
end
