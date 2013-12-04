require "carnival/version"
require 'ostruct'

module Carnival
  class Mask

    attr_accessor :cipher, :coded

    def initialize (address, text = nil)
      munge(address, text)
    end

    class Rnd
      def initialize(today)
        @today = today
        @seed = (today.to_f*1000).round
      end

      def seed
        @seed = (@seed * 9301 + 49297) % 233280
        @seed/(233280.0)
      end
    end

    def rand(number)
      (@rnd.seed * number).ceil
    end

    def munge(address, text)
      @rnd = Rnd.new(Time.now)
      coded = ''
      @linktext = text.nil? ? "'+link+'" : text

      unmixedkey = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
      inprogresskey = unmixedkey
      mixedkey = ''
      unshuffled = 62
      for i in 0..62
		    ranpos = rand(unshuffled) - 1
		    puts ranpos
		    nextchar = inprogresskey[ranpos]
		    mixedkey += nextchar.to_s
		    before = ranpos != -1 ? inprogresskey[0,ranpos] : ''
		    after = inprogresskey[ranpos+1,unshuffled]
		    inprogresskey = before + after
		    unshuffled -= 1
	    end

	    cipher = mixedkey
	    shift = address.length

	    txt = '<script type="text/javascript" language="javascript">'

	    address.each_char do |char|
			    if cipher.index(char).nil?
			      chr = char
				    coded += char
			    else
				    chr = (cipher.index(char) + shift) % cipher.length
				    coded += cipher[chr]
			    end
      end

      @coded = coded
      @cipher = cipher
    end

    def html
      "<script type=\"text/javascript\" language=\"javascript\">\n" +
      "<!-"+"-\n" +
      "// Email obfuscator script 2.1 by Tim Williams, University of Arizona\n" +
      "// Random encryption key feature by Andrew Moulden, Site Engineering Ltd\n" +
      "// This code is freeware provided these four comment lines remain intact\n" +
      "// A wizard to generate this code is at http://www.jottings.com/obfuscator/\n" +
      "{ coded = '" + @coded + "'\n" +
		  "  key = '"+ @cipher +"'\n"+
		  "  shift=coded.length\n"+
		  "  link=''\n"+
		  "  for (i=0; i<coded.length; i++) {\n" +
		  "    if (key.indexOf(coded.charAt(i))==-1) {\n" +
		  "      ltr = coded.charAt(i)\n" +
		  "      link += (ltr)\n" +
		  "    }\n" +
		  "    else {     \n"+
		  "      ltr = (key.indexOf(coded.charAt(i))-shift+key.length) % key.length\n"+
		  "      link += (key.charAt(ltr))\n"+
	    "    }\n"+
		  "  }\n"+
		  "document.write('<a href=\"mailto:'+link+'\">" + @linktext + "</a>')\n" +
		  "}\n"+
         	"//-"+"->\n" +
         	"<" + "/script><noscript>Sorry, you need Javascript on to email me." +
		  "<"+"/noscript>\n"
    end
  end

  module ViewHelpers
    def carnival(address, text = nil)
      Carnival::Mask.new(address, text).html.html_safe
    end
  end
end

ActionView::Base.send :include, Carnival::ViewHelpers
