# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 1 };
use RPM::Specfile;
ok(1); # If we made it this far, we're ok.

my $spec = new RPM::Specfile;
$spec->name('blippy-foo');
$spec->version('1.00');
$spec->release('1');
$spec->license("GPL");
$spec->group("Applications/CPAN");
$spec->push_source("blippy-foo-1.00.tar.gz");
$spec->push_source("extra-blippy.conf");
$spec->push_patch("super-blippy.patch");
$spec->push_require("foo >= 1.2");
$spec->push_require("foo2 >= 1.2");
$spec->push_buildrequire("xfoo >= 1.2");
$spec->push_buildrequire("xfoo2 >= 1.2");
$spec->description(<<E);
This is an extra blippy module.  It slices, it dices.
Author: Blippy Foo <cturner\@redhat.com>
E
$spec->prep(<<E);
%setup -q
E
$spec->build(<<E);
CFLAGS="\$RPM_OPT_FLAGS" perl Makefile.PL
make
E
$spec->install(<<E);
rm -rf \$RPM_BUILD_ROOT
eval `perl '-V:installarchlib'`
mkdir -p \$RPM_BUILD_ROOT/\$installarchlib
make PREFIX=\$RPM_BUILD_ROOT/usr install

[ -x /usr/lib/rpm/brp-compress ] && /usr/lib/rpm/brp-compress

find \$RPM_BUILD_ROOT/usr -type f -print | \
	sed \"s\@^\$RPM_BUILD_ROOT\@\@g\" | \
	grep -v perllocal.pod | \
	grep -v \"\\.packlist\" > $clm_name-$clm_version-filelist
if [ \"\$(cat $clm_name-$clm_version-filelist)X\" = \"X\" ] ; then
    echo \"ERROR: EMPTY FILE LIST\"
    exit -1
fi
E
$spec->file_param("-f blippy-filelist");
$spec->push_changelog(<<E);
* \$clm_changelog
- Spec file was autogenerated.
E

print $spec->generate_specfile;

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

