$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w(pis_pasep pis_pasep_active_record).each {|req| require File.dirname(__FILE__) + "/pispasep_rb/#{req}"}

%w(rubygems active_record active_support).each {|req| require req }

module PisPasepRb
end

