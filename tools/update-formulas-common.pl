#!/usr/bin/env perl

use File::Copy;
use Digest::SHA qw(sha256_hex);
use Getopt::Long;

use strict;
use warnings;

my $frameworks_version   = "5.76";
my $applications_version = "20.12.0";
my $plasma_version       = "5.20.2";

my %frameworks = (

### Updated list in https://api.kde.org/frameworks/
### Tier 1
    'attica'              => '',
    'breeze-icons'        => '',
    'kapidox'             => '',
    'kcodecs'             => '',
    'kconfig'             => '',
    'kcoreaddons'         => '',
    'kdbusaddons'         => '',
    'kdnssd'              => '',
    'kguiaddons'          => '',
    'kidletime'           => '',
    'kirigami2'           => '',
    'kitemmodels'         => '',
    'kitemviews'          => '',
    'kplotting'           => '',
    'kwidgetsaddons'      => '',
    'kwindowsystem'       => '',
    'solid'               => '',
    'sonnet'              => '',
    'syntax-highlighting' => '',

### Tier 2
    'kactivities'     => '',
    'kauth'           => '',
    'kcompletion'     => '',
    'kcrash'          => '',
    'kdoctools'       => '',
    'kfilemetadata'   => '',
    'kimageformats'   => '',
    'kjobwidgets'     => '',
    'knotifications'  => '',
    'kpackage'        => '',
    'kpty'            => '',
    'kunitconversion' => '',

### Tier 3
    'kbookmarks'       => '',
    'kcmutils'         => '',
    'kconfigwidgets'   => '',
    'kdeclarative'     => '',
    'kded'             => '',
    'kdesu'            => '',
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
    'plasma-framework' => '',

### Tier 4
    'frameworkintegration' => '',
    'qqc2-desktop-style'   => '',

### Porting Aids
    'kdelibs4support' => 'portingAids/kdelibs4support',
    'kdesignerplugin' => 'portingAids/kdesignerplugin',
    'kdewebkit'       => 'portingAids/kdewebkit',
    'khtml'           => 'portingAids/khtml',
    'kjs'             => 'portingAids/kjs',
    'kjsembed'        => 'portingAids/kjsembed',
    'kmediaplayer'    => 'portingAids/kmediaplayer',
    'kross'           => 'portingAids/kross',
    'kxmlrpcclient'   => 'portingAids/kxmlrpcclient'
);

my %applications = (
    'analitza'        => '',
    'dolphin'         => '',
    'elisa'           => '',
    'kate'            => '',
    'kcalc'           => '',
    'kdenlive'        => '',
    'kdialog'         => '',
    'kimap'           => '',
    'kio-extras'      => '',
    'kmime'           => '',
    'kolourpaint'     => '',
    'konsole'         => '',
    'konversation'    => '',
    'ktorrent'        => '',
    'libkexiv2'       => '',
    'libkomparediff2' => '',
    'libktorrent'     => '',
    'lokalize'        => '',
    'okular'          => '',
    'poxml'           => '',
    'umbrello'        => '',
);

my %plasmas = (
    'drkonqi'      => '',
    'ksysguard'    => '',
    'libksysguard' => '',
);

my $tmp_dir = '/tmp/kde';
mkdir "${tmp_dir}";
chomp($tmp_dir);

sub update_frameworks {
    for my $package ( keys %frameworks ) {
        my $upstream_suffix = "-${frameworks_version}.0.tar.xz";
        my $upstream_url
            = "https://download.kde.org/stable/frameworks/${frameworks_version}/";

        my $upstream = $frameworks{$package};
        if ( $upstream eq '' ) {
            $upstream = $package;
        }

        my $formula              = "Formula/kf5-$package.rb";
        my $package_upstream_url = "$upstream_url$upstream$upstream_suffix";

        if ( !-e $formula ) {
            print("Formula $formula does not exist!\n");
            return;
        }

        my $cached_file = "$tmp_dir/kf5-$package$upstream_suffix";

        download_and_update( $formula, $package_upstream_url, $cached_file );
    }
}

sub update_applications {
    for my $package ( keys %applications ) {
        my $upstream_url
            = "https://download.kde.org/stable/release-service/${applications_version}/src/";

        my $upstream_suffix = "-${applications_version}.tar.xz";

        my $upstream = $applications{$package};
        if ( $upstream eq '' ) {
            $upstream = $package;
        }

        my $formula              = "Formula/$package.rb";
        my $package_upstream_url = "$upstream_url$upstream$upstream_suffix";
        my $cached_file          = "$tmp_dir/$package$upstream_suffix";
        download_and_update( $formula, $package_upstream_url, $cached_file );
    }
}

sub update_plasmas {
    for my $package ( keys %plasmas ) {
        my $upstream_url
            = "https://download.kde.org/stable/plasma/${plasma_version}/";

        my $upstream_suffix = "-${plasma_version}.tar.xz";

        my $upstream = $plasmas{$package};
        if ( $upstream eq '' ) {
            $upstream = $package;
        }

        my $formula              = "Formula/$package.rb";
        my $package_upstream_url = "$upstream_url$upstream$upstream_suffix";
        my $cached_file          = "$tmp_dir/$package$upstream_suffix";
        download_and_update( $formula, $package_upstream_url, $cached_file );
    }
}

sub download_and_update {
    my $formula              = $_[0];
    my $package_upstream_url = $_[1];
    my $cached_file          = $_[2];

    if ( !-e $formula ) {
        print("Formula $formula does not exist!\n");
        return;
    }

    if ( !-e $cached_file ) {
        print("$package_upstream_url\n");
        `curl -L -o "$cached_file" "$package_upstream_url"`;
        if ( $? != 0 ) {
            die "Unable to download $package_upstream_url: $!";
        }
    }

    my $package_sig_upstream_url = "$package_upstream_url.sig";
    my $cached_file_sig          = "$cached_file.sig";

    if ( !-e $cached_file_sig ) {
        print("$package_sig_upstream_url\n");

        `curl -L -o "$cached_file_sig" "$package_sig_upstream_url"`;
        if ( $? != 0 ) {
            die "Unable to download $package_sig_upstream_url: $!";
        }
    }

    if ( !-e $cached_file_sig ) {
        die "$cached_file_sig not available!";
    }

    `gpg2 --verify $cached_file_sig`;

    if ( $? != 0 ) {
        die "Unable to verify singnature $cached_file_sig $!";
    }

    open my $CACHED_FILE, "<", $cached_file or die $!;
    my $ctx = Digest::SHA->new(256);
    $ctx->addfile($CACHED_FILE);
    my $sha = $ctx->hexdigest;
    close($CACHED_FILE);

    # print("$cached_file: $sha1\n");

    open my $FORMULA, '<', $formula or die $!;
    open my $NEW_FORMULA, '>', "$formula.new" or die $!;

    while (my $line = <$FORMULA>) {
        next if ( $line =~ /^\s*^  url\s+\"(.*)\"\s*$/ );
        next if ( $line =~ /^\s*^  sha256\s+\"(.*)\"\s*$/ );
        next if ( $line =~ /^\s*^  revision\s+\d$/ );

        print $NEW_FORMULA $line;

        if ( $line =~ /^\s*^  homepage\s+(.*)\"/ ) {
            print $NEW_FORMULA "  url \"$package_upstream_url\"\n";
            print $NEW_FORMULA "  sha256 \"$sha\"\n";
        }
    }

    close $FORMULA;
    close $NEW_FORMULA;

    move( "$formula.new", "$formula" ) or die $!;

    print "Updated $formula\n";
}

GetOptions(
    'applications' => \&update_applications,
    'frameworks'   => \&update_frameworks,
    'plasma'       => \&update_plasmas
);
