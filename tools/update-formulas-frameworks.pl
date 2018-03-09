#!/usr/bin/env perl

use File::Copy;
use Digest::SHA qw(sha256_hex);

use strict;
use warnings;

my %frameworks = (

    ### Updated list in https://api.kde.org/frameworks/
    ### ECM
    'extra-cmake-modules' => '',

    ### Tier 1
    'attica'              => '',
    'breeze-icons'        => '',
    'kapidox'             => '',
    'karchive'            => '',
    'kcodecs'             => '',
    'kconfig'             => '',
    'kcoreaddons'         => '',
    'kdbusaddons'         => '',
    'kdnssd'              => '',
    'kguiaddons'          => '',
    'ki18n'               => '',
    'kidletime'           => '',
    'kirigami2'           => '',
    'kitemmodels'         => '',
    'kitemviews'          => '',
    'kplotting'           => '',
    'syntax-highlighting' => '',
    'kwidgetsaddons'      => '',
    'kwindowsystem'       => '',
    'qqc2-desktop-style'  => '',
    'solid'               => '',
    'sonnet'              => '',
    'threadweaver'        => '',

    ### Tier 2
    'kactivities'     => '',
    'kauth'           => '',
    'kcompletion'     => '',
    'kcrash'          => '',
    'kdoctools'       => '',
    'kfilemetadata'   => '',
    'kimageformats'   => '',
    'knotifications'  => '',
    'kjobwidgets'     => '',
    'kpackage'        => '',
    'kpty'            => '',
    'kunitconversion' => '',

    ### Tier 3
    'kbookmarks'       => '',
    'kcmutils'         => '',
    'kconfigwidgets'   => '',
    'kdeclarative'     => '',
    'kded'             => '',
    'kdesignerplugin'  => '',
    'kdesu'            => '',
    'kdewebkit'        => '',
    'kemoticons'       => '',
    'kglobalaccel'     => '',
    'kiconthemes'      => '',
    'kinit'            => '',
    'kio'              => '',
    'knewstuff'        => '',
    'knotifyconfig'    => '',
    'kparts'           => '',
    'kpeople'          => '',
    'krunner'          => '',
    'kservice'         => '',
    'ktexteditor'      => '',
    'ktextwidgets'     => '',
    'kwallet'          => '',
    'kxmlgui'          => '',
    'kxmlrpcclient'    => '',
    'plasma-framework' => '',

    ### Tier 4
    'frameworkintegration' => '',

    ### Porting Aids
    'kdelibs4support' => 'portingAids/kdelibs4support',
    'khtml'           => 'portingAids/khtml',
    'kjs'             => 'portingAids/kjs',
    'kjsembed'        => 'portingAids/kjsembed',
    'kmediaplayer'    => 'portingAids/kmediaplayer',
    'kross'           => 'portingAids/kross'
);

my $version      = "5.44";
my $upstream_url = "https://download.kde.org/stable/frameworks/${version}/";

my $frameworks_upstream_suffix = "-${version}.0.tar.xz";
my $brew_prefix                = `brew --cache`;

if ($? != 0)
{
    die "Unable to call brew -cache: $!";
}

chomp($brew_prefix);

sub updatePackage($)
{

    my $package = $_[0];

    my $upstream_suffix = $frameworks_upstream_suffix;

    my $upstream = $frameworks{$package};
    if ($upstream eq '')
    {
        $upstream = $package;
    }

    my $formula              = "Formula/kf5-$package.rb";
    my $package_upstream_url = "$upstream_url$upstream$upstream_suffix";

    if (!-e $formula)
    {
        print("Formula $formula does not exist!\n");
        return;
    }

    my $cached_file = "$brew_prefix/kf5-$package$upstream_suffix";

    if (!-e $cached_file)
    {
        `curl -L -s -o "$cached_file" "$package_upstream_url"`;
        if ($? != 0)
        {
            die "Unable to download $package_upstream_url: $!";
        }
    }

    if (!-e $cached_file)
    {
        die "$cached_file not available!";
    }

    open(CACHED_FILE, "<", $cached_file);
    my $ctx = Digest::SHA->new(256);
    $ctx->addfile(*CACHED_FILE);
    my $sha = $ctx->hexdigest;
    close(CACHED_FILE);

    # print("$cached_file: $sha1\n");

    open(FORMULA, "<", $formula) or die $!;

    open(NEW_FORMULA, ">", "$formula.new") or die $!;

    while (<FORMULA>)
    {
        my $line = $_;

        if ($line =~ /^\s*^  url\s+\"(.*)\"\s*$/)
        {
            next;
        }
        if ($line =~ /^\s*^  sha256\s+\"(.*)\"\s*$/)
        {
            next;
        }

        print NEW_FORMULA $line;

        if ($line =~ /^\s*^  homepage\s+(.*)\"/)
        {
            print NEW_FORMULA "  url \"$package_upstream_url\"\n";
            print NEW_FORMULA "  sha256 \"$sha\"\n";
        }
    }

    close FORMULA;
    close NEW_FORMULA;

    move("$formula.new", "$formula") or die $!;

    print "Updated $formula\n";
}

for my $package (keys %frameworks)
{
    updatePackage($package);
}
