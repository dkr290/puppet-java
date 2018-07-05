function java::params(
  Hash  $options,
  Puppet::LookupContext  $context,
){
$base_params = {

       'java::java_install_path'           =>  '/usr/lib/java',
       'java::jdk_file'                    =>  'jdk-10.0.1_linux-x64_bin.tar.gz',
       'java::jdk_folder'                  =>  'jdk',
       'java::java_bin_folder'             =>  '/usr/lib/java/jdk/bin',
       'java::java_path'                   =>  'PATH=$PATH:/usr/lib/java/jdk/bin',
       'java::checksum_val'                =>  '4f0b8a0186ba62e2a3303d8a26d349f7',
       



      
      }

    $os_params  = case $facts['os']['family'] {
           'Debian': {
                { 'java::remove_java'           =>   'apt remove *jdk*',
                  
                  
                   }
             }
            default: { 
                { 'java::remove_java'           =>   'yum -y remove *jdk*',
                 
                 
                      }
             }
       
        }
    $base_params  + $os_params



}
