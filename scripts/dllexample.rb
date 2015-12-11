require 'pathname'
# Load build script to help build C program
load "scripts/cbuild.rb"

# Configuration parameters
configDll = {
  :verbose      => :yes,
  :compiler     => 'gcc',
  :linker       => 'gcc',
# :include_path => [''],
  :user_define  => ['ADD_EXPORT'],
# :library_path => 'lib',
# :library => [''],
# :linker_script => 'MyLinkerScript.ld',
# :compiler_options => ['-DOK'],                 # Other compiler options
  :linker_options => ['-s', '-shared', '-Wl,--subsystem,windows'],     # Other linker options
  :option_keys  => {:library => '-l',
                    :library_path => '-L',
                    :include_path => '-I',
                    :output_file => '-o',
                    :compile => '-c',
                    :linker_script => '-T',
                    :define => '-D'}
}

configMain = {
  :verbose      => :yes,
  :compiler     => 'gcc',
  :linker       => 'gcc',
  :include_path => ['src'],
# :user_define  => [''],
  :library_path => 'src',
  :library => ['TestDll'],
# :linker_script => 'MyLinkerScript.ld',
# :compiler_options => ['-DOK'],          # Other compiler options
  :linker_options => ['-s'],              # Other linker options
  :option_keys  => {:library => '-l',
                    :library_path => '-L',
                    :include_path => '-I',
                    :output_file => '-o',
                    :compile => '-c',
                    :linker_script => '-T',
                    :define => '-D'}
}

TESTDLL_FILE = "src/TestDll.exe"
MAIN_FILE = "src/main/main.exe"

namespace :release do
  desc 'Release DLL'
  task :Dll do
    dep_list = compile_all('src', 'src', configDll)
    link_all(getDependers(dep_list), TESTDLL_FILE, configDll)
    Rake::Task[TESTDLL_FILE].invoke

    if File.exists? TESTDLL_FILE
        puts "renaming TestDLL.exe to TestDLL.dll..."
        sh "mv #{TESTDLL_FILE} src/TestDll.dll"
    end
  end

  desc 'Release main'
  task :main do
    dep_list = compile_all('src/main', 'src/main', configMain)
    link_all(getDependers(dep_list), MAIN_FILE, configMain)
    Rake::Task[MAIN_FILE].invoke

    if File.exists? "src/TestDll.dll"
        puts "moving TestDLL.dll..."
        sh "mv src/TestDll.dll src/main/TestDll.dll"
    end
  end
end
