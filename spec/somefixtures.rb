Dir[File.join(File.dirname(__FILE__), "**/*.rb")].sort.each { |m| require m }
