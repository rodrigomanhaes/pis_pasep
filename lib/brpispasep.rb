$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w(pis_pasep).each {|req| require File.dirname(__FILE__) + "/brpispasep/#{req}"}

%w(rubygems active_record active_support).each {|req| require req }

#ActiveRecord::Base.send :include, CpfCnpjActiveRecord

module BrPisPasep
end

