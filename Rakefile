require 'yaml'
require 'rake/contrib/ftptools'

task :cleanup do
  %w{build .sass-cache}.each do |file|
    FileUtils.rm_r(file) if File.exist?(file)
  end
end

namespace :publish do
  desc "Deploy to live"
  task :live => [:cleanup] do

    config = YAML.load_file('ftp.yaml')

    if config[:username].nil? || config[:password].nil?
      puts "Username or password is missing..."
      exit 1
    end

    sh "middleman build"

    Dir.chdir("./build/")
    puts Dir.pwd
    Rake::FtpUploader.connect(config[:path], config[:hostname], config[:username], config[:password]) do |ftp|
      ftp.verbose = true # gives you some output
      ftp.upload_files("./**/*")
    end
  end
end


