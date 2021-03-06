module JsTestCore
  class Server
    class << self
      attr_accessor :rackup_path
      def start
        require "thin"
        Thin::Runner.new([
          "--port", "8080",
          "--rackup", File.expand_path(rackup_path),
          "start"]
        ).run!
      end

      def standalone_rackup(rack_builder, spec_root_path=nil, public_path=nil)
        require "sinatra"

        JsTestCore.spec_root_path = spec_root_path || File.expand_path("./spec/javascripts")
        if File.directory?(JsTestCore.spec_root_path)
          puts "Spec root path is #{JsTestCore.spec_root_path}"
        else
          raise ArgumentError, "#{spec_root_path} #{JsTestCore.spec_root_path} must be a directory"
        end

        JsTestCore.public_path = public_path || File.expand_path("./public")
        if File.directory?(JsTestCore.public_path)
          puts "Public path is #{JsTestCore.public_path}"
        else
          raise ArgumentError, "#{public_path} #{JsTestCore.public_path} must be a directory"
        end

        rack_builder.use JsTestCore::App
        rack_builder.run Sinatra::Application
      end
    end
  end
end