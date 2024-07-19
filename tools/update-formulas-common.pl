#!/usr/bin/perl

use File::Copy;
use Digest::SHA qw(sha256_hex);
use Getopt::Long;

use strict;
use warnings;

my %frameworks = (

### Updated list in https://api.kde.org/frameworks/
### Tier 1
    'attica'              => '',
    'breeze-icons'        => '',
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
    'qqc2-desktop-style'  => '',
    'solid'               => '',
    'sonnet'              => '',
    'syntax-highlighting' => '',

### Tier 2
    'kactivities'     => '',
    'kauth'           => '',
    'kcompletion'     => '',
    'kcrash'          => '',
    'kfilemetadata'   => '',
    'kimageformats'   => '',
    'kjobwidgets'     => '',
    'knotifications'  => '',
    'kpackage'        => '',
    'kpeople'         => '',
    'kpty'            => '',
    'kunitconversion' => '',

### Tier 3
    'kbookmarks'       => '',
    'kcmutils'         => '',
    'kconfigwidgets'   => '',
    'kdeclarative'     => '',
    'kded'             => '',
    'kemoticons'       => '',
    'kglobalaccel'     => '',
    'kiconthemes'      => '',
    'kinit'            => '',
    'kio'              => '',
    'knewstuff'        => '',
    'knotifyconfig'    => '',
    'kparts'           => '',
    'kservice'         => '',
    'ktexteditor'      => '',
    'ktextwidgets'     => '',
    'kwallet'          => '',
    'kxmlgui'          => '',

### Tier 4
    'frameworkintegration' => '',
);

my %meta_frameworks = (
    'tier1-frameworks'       => '',
    'tier2-frameworks'       => '',
    'tier3-frameworks'       => '',
    'tier4-frameworks'       => '',
    'portingaids-frameworks' => '',
);

my %gear = (
    'analitza'        => '',
    'dolphin'         => '',
    'elisa'           => '',
    'kate'            => '',
    'kcalc'           => '',
    'kdeconnect-kde'  => '',
    'kdenlive'        => '',
    # https://bugs.kde.org/show_bug.cgi?id=448152
    'kdev-php'        => '',
    'kdev-python'     => '',
    'kdevelop'        => '',
    'kdialog'         => '',
    'kimap'           => '',
    'kio-extras'      => '',
    'kmime'           => '',
    'kolourpaint'     => '',
    'konsole'         => '',
    'konversation'    => '',
    'libkexiv2'       => '',
    'libkomparediff2' => '',
    'lokalize'        => '',
    'okular'          => '',
    'poxml'           => '',
    'umbrello'        => '',

    # https://bugs.kde.org/show_bug.cgi?id=430896
    # 'ktorrent'        => '',
    # 'libktorrent'     => '',
);

my %plasma = (
    'libksysguard' => '',
);

my $tmp_dir = '/tmp/kde';
mkdir "${tmp_dir}";
chomp($tmp_dir);

sub update_frameworks {
    die "Function takes excatly one argument, frameworks version " unless @_ != 1;
    my $frameworks_version = $_[1];

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

    update_meta_frameworks( $frameworks_version );
}

sub update_meta_frameworks {
    my $frameworks_version = $_[0];

    for my $package ( keys %meta_frameworks ) {
        my $formula = "Formula/kf5-$package.rb";

        open my $FORMULA,     '<', $formula       or die $!;
        open my $NEW_FORMULA, '>', "$formula.new" or die $!;

        while ( my $line = <$FORMULA> ) {
            next if ( $line =~ /^\s*^  version\s+\"(.*)\"\s*$/ );
            next if ( $line =~ /^\s*^  revision\s+\d$/ );

            print $NEW_FORMULA $line;

            if ( $line =~ /^\s*^  url\s+(.*)\"/ ) {
                print $NEW_FORMULA "  version \"${frameworks_version}.0\"\n";
            }
        }

        close $FORMULA;
        close $NEW_FORMULA;

        move( "$formula.new", "$formula" ) or die $!;

        print "Updated $formula\n";
    }
}

sub update_gear {
    die "Function takes excatly one argument, gear version " unless @_ != 1;
    my $gear_version = $_[1];

    for my $package ( keys %gear ) {
        my $upstream_url
            = "https://download.kde.org/stable/release-service/${gear_version}/src/";

        my $upstream_suffix = "-${gear_version}.tar.xz";

        my $upstream = $gear{$package};
        if ( $upstream eq '' ) {
            $upstream = $package;
        }

        my $formula              = "Formula/$package.rb";
        my $package_upstream_url = "$upstream_url$upstream$upstream_suffix";
        my $cached_file          = "$tmp_dir/$package$upstream_suffix";
        download_and_update( $formula, $package_upstream_url, $cached_file );
    }
}

sub update_plasma {
    die "Function takes excatly one argument, plasma version " unless @_ != 1;
    my $plasma_version = $_[1];

    for my $package ( keys %plasma ) {
        my $upstream_url
            = "https://download.kde.org/stable/plasma/${plasma_version}/";

        my $upstream_suffix = "-${plasma_version}.tar.xz";

        my $upstream = $plasma{$package};
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

    print("$package_upstream_url\n");
    `aria2c --allow-overwrite=true --continue=true --file-allocation=none --max-tries=2 --max-connection-per-server=16 --max-file-not-found=5 --min-split-size=1M --no-conf --remote-time=true --timeout=5 --split=16 --dir=/ --out "$cached_file" "$package_upstream_url"`;
    if ( $? != 0 ) {
        die "Unable to download $package_upstream_url: $!";
    }

    my $package_sig_upstream_url = "$package_upstream_url.sig";
    my $cached_file_sig          = "$cached_file.sig";

    print("$package_sig_upstream_url\n");

    `aria2c --allow-overwrite=true --continue=true --file-allocation=none --max-tries=2 --max-connection-per-server=16 --max-file-not-found=5 --min-split-size=1M --no-conf --remote-time=true --timeout=5 --split=16 --dir=/ --out "$cached_file_sig" "$package_sig_upstream_url"`;
    if ( $? != 0 ) {
        die "Unable to download $package_sig_upstream_url: $!";
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

    open my $FORMULA,     '<', $formula       or die $!;
    open my $NEW_FORMULA, '>', "$formula.new" or die $!;

    while ( my $line = <$FORMULA> ) {
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
    'gear=s'       => \&update_gear,
    'frameworks=s' => \&update_frameworks,
    'plasma=s'     => \&update_plasma
);
