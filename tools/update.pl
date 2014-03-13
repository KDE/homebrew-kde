#!/usr/bin/env perl

use File::Copy;
use Digest::SHA1  qw(sha1_hex);

use strict;
use warnings;

my %frameworks = (

    ### Tier 1
    'kguiaddons' => '',
    'kcodecs' => '',
    'kdbusaddons' => '',
    'kitemviews' => '',
    'sonnet' => '',
    'kwidgetsaddons' => '',
    'kconfig' => '',
    'kimageformats' => '',
    'kidletime' => '',
    'kcoreaddons' => '',
    'umbrella' => 'kf5umbrella',
    'solid' => '',
    'karchive' => '',
    'kjs' => '',
    'kwindowsystem' => '',
    'kplotting' => '',
    'threadweaver' => '',
    'kitemmodels' => '',

     ### Tier 2
    'kcompletion' => '',
    'kjobwidgets' => '',
    'kauth' => '',
    'kcrash' => '',
    'kdoctools' => '',
    'ki18n' => '',
    'kwallet' => '',
    'knotifications' => '',
    'kservice' => '',

    ### And all others
    'attica' => '',
    'kbookmarks' => '',
    'kconfigwidgets' => '',
    'kde4support' => '',
    'kdesignerplugin' => '',
    'kemoticons' => '',
    'kglobalaccel' => '',
    'kiconthemes' => '',
    'kinit' => '',
    'kio' => '',
    'knewstuff' => '',
    'knotifyconfig' => '',
    'kparts' => '',
    'kprintutils' => '',
    'kpty' => '',
    'kross' => '',
    'ktexteditor' => '',
    'ktextwidgets' => '',
    'kunitconversion' => '',
    'kxmlgui' => ''
);

my $upstream_url = "http://download.kde.org/unstable/frameworks/4.97.0/";
my $upstream_suffix = "-4.97.0.tar.xz";
my $brew_prefix = `brew --cache`;

if ($? != 0) {
    die "Unable to call brew -cache: $!";
}

chomp($brew_prefix);

for my $package (keys %frameworks) {
    my $upstream = $frameworks{$package};
    if ($upstream eq '') {
        $upstream = $package;
    }

    my $formula = "kf5-$package.rb";
    my $package_upstream_url = "$upstream_url$upstream$upstream_suffix";

    if (! -e $formula) {
        print("Formula $formula does not exist!\n");
        next;
    }

    my $cached_file = "$brew_prefix/kf5-$package$upstream_suffix";

    if (! -e $cached_file) {
        `curl -L -s -o "$cached_file" "$package_upstream_url"`;
        if ($? != 0) {
            die "Unable to download $package_upstream_url: $!";
        }
    }

    if (! -e $cached_file) {
        die "$cached_file not available!";
    }

    open(CACHED_FILE, "<", $cached_file);
    my $ctx = Digest::SHA1->new;
    $ctx->addfile(*CACHED_FILE);
    my $sha1 = $ctx->hexdigest;
    close(CACHED_FILE);

    # print("$cached_file: $sha1\n");

    open(FORMULA, "<", $formula) or die $!;

    open(NEW_FORMULA, ">", "$formula.new") or die $!;

    while (<FORMULA>) {
        my $line = $_;

        if ($line =~ /^\s*url\s+\"(.*)\"\s*$/) {
            next;
        }
        if ($line =~ /^\s*sha1\s+\"(.*)\"\s*$/) {
            next;
        }

        print NEW_FORMULA $line;

        if ($line =~ /^\s*class\s+(.*?)\s*<\s*Formula/) {
            print NEW_FORMULA "  url \"$package_upstream_url\"\n";
            print NEW_FORMULA "  sha1 \"$sha1\"\n";
        }
    }

    close FORMULA;
    close NEW_FORMULA;

    move("$formula.new", "$formula") or die $!;

    print "Updated $formula\n";
}
