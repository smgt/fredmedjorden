task :cleanup do
  %w{build .sass-cache}.each do |file|
    FileUtils.rm_r(file) if File.exist?(file)
  end
end

namespace :publish do

  desc "Publish to http://smgt.me/fredmedjorden"
  task :staging => [:cleanup] do
    FileUtils.rm_r('build') if File.exist?('build')

    sh "middleman build"

    # this should not be necessary, but I can't figure out how to
    #   # just keep a goddamn static file in the root with nanoc
    # File.open("build/CNAME", 'w+') do |f|
    #   f.puts("developers.flattr.net")
    # end

    ENV['GIT_DIR'] = File.expand_path(`git rev-parse --git-dir`.chomp)
    old_sha = `git rev-parse refs/remotes/origin/gh-pages`.chomp
    Dir.chdir('build') do
      ENV['GIT_INDEX_FILE'] = gif = '/tmp/dev.gh.i'
      ENV['GIT_WORK_TREE'] = Dir.pwd
      File.unlink(gif) if File.file?(gif)
      `git add -A`
      tsha = `git write-tree`.strip
      puts "Created tree   #{tsha}"
      if old_sha.size == 40
        csha = `echo 'boom' | git commit-tree #{tsha} -p #{old_sha}`.strip
      else
        csha = `echo 'boom' | git commit-tree #{tsha}`.strip
      end
      puts "Created commit #{csha}"
      puts `git show #{csha} --stat`
      puts "Updating gh-pages from #{old_sha}"
      `git update-ref refs/heads/gh-pages #{csha}`
      `git push origin gh-pages`
    end
    Rake::Task["cleanup"].invoke
  end

  desc "Deploy to http://fredmedjorden.smgt.me"
  task :smgt => [:cleanup] do
    sh "middleman build"
    # sh "scp -r build/* dbrails1.driftbolaget.se:/users/simongate/fredmedjorden/"
    sh "rsync -avz build/ -e ssh dbrails1.driftbolaget.se:/users/simongate/fredmedjorden/"
    Rake::Task["cleanup"].invoke
  end
end


