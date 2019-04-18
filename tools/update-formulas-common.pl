#!/usr/bin/env perl

use File::Copy;
use Digest::SHA qw(sha256_hex);
use Getopt::Long;

use strict;
use warnings;

my $frameworks_version   = "5.57";
my $applications_version = "18.12.3";

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

my %applications = (

        'dolphin'         => '',
        'kate'            => '',
        'kolourpaint'     => '',
        'konsole'         => '',
        'okular'          => '',
        'kimap'           => '',
        'kmime'           => '',
        'libkexiv2'       => '',
        'libkomparediff2' => '',
        'kio-extras'      => '',
        'lokalize'        => '',
        'poxml'           => '',
        'kdenlive'        => '',
        'analitza'        => '',
        'kcalc'           => '',
        );

my $tmp_dir = '/tmp/kde';
mkdir "${tmp_dir}";
chomp($tmp_dir);

sub update_frameworks {
	for my $package ( keys %frameworks ) {
		my $upstream_suffix = "-${frameworks_version}.0.tar.xz";
		my $upstream_url =
			"https://download.kde.org/stable/frameworks/${frameworks_version}/";

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
		my $upstream_url =
			"https://download.kde.org/stable/applications/${applications_version}/src/";

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

sub download_and_update($$$) {
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

	open( CACHED_FILE, "<", $cached_file );
	my $ctx = Digest::SHA->new(256);
	$ctx->addfile(*CACHED_FILE);
	my $sha = $ctx->hexdigest;
	close(CACHED_FILE);

# print("$cached_file: $sha1\n");

	open( FORMULA, "<", $formula ) or die $!;

	open( NEW_FORMULA, ">", "$formula.new" ) or die $!;

	while (<FORMULA>) {
		my $line = $_;

		next if ( $line =~ /^\s*^  url\s+\"(.*)\"\s*$/ );
		next if ( $line =~ /^\s*^  sha256\s+\"(.*)\"\s*$/ );
		next if ( $line =~ /^\s*^  revision\s+\d$/ );

		print NEW_FORMULA $line;

		if ( $line =~ /^\s*^  homepage\s+(.*)\"/ ) {
			print NEW_FORMULA "  url \"$package_upstream_url\"\n";
			print NEW_FORMULA "  sha256 \"$sha\"\n";
		}
	}

	close FORMULA;
	close NEW_FORMULA;

	move( "$formula.new", "$formula" ) or die $!;

	print "Updated $formula\n";
}

GetOptions(
		'applications' => \&update_applications,
		'frameworks'   => \&update_frameworks
	  );
