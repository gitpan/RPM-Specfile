use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'RPM::Specfile',
    'VERSION_FROM'	=> 'lib/RPM/Specfile.pm', # finds $VERSION
    'PREREQ_PM'		=> {}, # e.g., Module::Name => 1.1
    'EXE_FILES'         => [ 'cpanflute2' ],
#    'PL_FILES'          => { 'cpanflute2.PL' => 'cpanflute2' },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/RPM/Specfile.pm', # retrieve abstract from module
       AUTHOR     => 'Chip Turner <cturner@redhat.com>') : ()),
);
