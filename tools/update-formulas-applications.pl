#!/usr/bin/env perl

use File::Copy;
use Digest::SHA  qw(sha256_hex);

use strict;
use warnings;

my %applications = (

    'dolphin' => '',
    'kate' => '',
    'konsole' => '',
    'okteta' => '',
    'okular' => '',

    'kimap' => '',
    'kmime' => '',
    'libalkimia' => '',
    'libkexiv2' => '',
    'libkomparediff2' => '',

);

my $version = "17.08.3";
my $upstream_url = "https://download.kde.org/stable/applications/${version}/src/";

my $applications_upstream_suffix = "-${version}.tar.xz";
my $brew_prefix = `brew --cache`;

if ($? != 0) {
    die "Unable to call brew -cache: $!";
}

chomp($brew_prefix);

sub updatePackage($) {

    my $package = $_[0];

    my $upstream_suffix = $applications_upstream_suffix;

    my $upstream = $applications{$package};
    if ($upstream eq '') {
        $upstream = $package;
    }

    my $formula = "$package.rb";
    my $package_upstream_url = "$upstream_url$upstream$upstream_suffix";

    if (! -e $formula) {
        print("Formula $formula does not exist!\n");
        return;
    }

    my $cached_file = "$brew_prefix/$package$upstream_suffix";

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
    my $ctx = Digest::SHA->new(256);
    $ctx->addfile(*CACHED_FILE);
    my $sha = $ctx->hexdigest;
    close(CACHED_FILE);

    # print("$cached_file: $sha1\n");

    open(FORMULA, "<", $formula) or die $!;

    open(NEW_FORMULA, ">", "$formula.new") or die $!;

    while (<FORMULA>) {
        my $line = $_;

        if ($line =~ /^\s*url\s+\"(.*)\"\s*$/) {
            next;
        }
        if ($line =~ /^\s*sha256\s+\"(.*)\"\s*$/) {
            next;
        }

        print NEW_FORMULA $line;

        if ($line =~ /^\s*class\s+(.*?)\s*<\s*Formula/) {
            print NEW_FORMULA "  url \"$package_upstream_url\"\n";
            print NEW_FORMULA "  sha256 \"$sha\"\n";
        }
    }

    close FORMULA;
    close NEW_FORMULA;

    move("$formula.new", "$formula") or die $!;

    print "Updated $formula\n";
}

for my $package (keys %applications) {
    updatePackage($package);
}
