#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'pdf/reader'



#ページ枚数を取得する
def getPageCount()
	File.open("/Users/ichikawayuya/Desktop/guraduate.pdf", "rb") do |io|
	  reader = PDF::Reader.new(io)
	  return reader.page_count
	end
end

#pdfの文字を格納する
def convertPDFToContents(path)
	#ページの枚数だけ配列を用意
	contents = []

	File.open(path, "rb") do |io|
		# インスタンス化
		reader = PDF::Reader.new(io)	
		
	 	# ページ単位で文字列を格納
	  	reader.pages.each do |page|
			contents.concat([page.text])
	  	end
	end	
	return contents
end


#正規表現を用いて必要な文字列を取得する
def sampleSentencesFromContent(contents)
	sentences = []
	
	contents.each do |content|
		sentences.concat(content.split(" "))
	end
	
	return sentences
end



if __FILE__ == $0
	path = "/Users/ichikawayuya/Desktop/guraduate.pdf"
	contents = convertPDFToContents(path)
	sentences = sampleSentencesFromContent(contents)
	
	sentences.each do |sentence|
		print(sentence)
		print("\n")
	end
end
