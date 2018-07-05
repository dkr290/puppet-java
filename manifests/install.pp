class java::install(

   $java_install_path = $::java::java_install_path,
   $jdk_file          = $::java::jdk_file,
   $jdk_folder        = $::java::jdk_folder,
   $java_bin_folder   = $::java::java_bin_folder,
   $remove_java       = $::java::remove_java,
   $java_path         = $::java::java_path,
   $checksum_val      = $::java::checksum_val,
){



 file { $java_install_path:
  
  ensure => directory,
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
  notify => File["${java_install_path}/${jdk_folder}"]
 }
 file { "${java_install_path}/${jdk_folder}":
  
  ensure => directory,
  owner  => 'root',
  group  => 'root',
  mode   => '0755',

 }


 #exec {'remove_java':
 #     path    => ['/usr/bin', '/usr/sbin','/bin',],
 #     command => $remove_java,
 #     refreshonly => true,
 #     subscribe   => File["${java_install_path}"],

#}

archive { "${jdk_file}":
 path          => "${java_install_path}/${jdk_file}",
 source        => "puppet:///modules/java/${jdk_file}",
 checksum_type      => 'md5',
 checksum          => $checksum_val,
 extract       => true,
 extract_command => 'tar xfz %s --strip-components=1',
 extract_path  => "${java_install_path}/${jdk_folder}",
 #creates       => "${java_install_path}/${jdk_folder}",
 cleanup       => true,
 user          => 'root',
 group         => 'root',
 subscribe     => File[$java_install_path],
 notify        => File['/etc/profile.d/append-java-path.sh'],

}






file { '/etc/profile.d/append-java-path.sh':
    mode    => '644',
    content => $java_path,

}

#   exec {'rename_jdk':
#       path    => ['/usr/bin', '/usr/sbin','/bin',],
#       command => "mv  ${java_install_path}/jdk-10.0.1   ${java_install_path}/${jdk_folder}",
#       refreshonly => true,
#       subscribe   => Archive["${jdk_file}"],

# }


}





