#!/usr/bin/env perl

my %tier1 = (
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
    'kitemmodels' => ''
);

for my $package (keys %tier1) {
    $upstream = $tier1{$package};
    if ($upstream eq '') {
        $upstream = $package;
    }

    print "$upstream\n";

    $formula = "kf5-$package.rb";

    if (! -e $formula) {
        print("Formula $formula does not exist!\n");
        next;
    }
}
