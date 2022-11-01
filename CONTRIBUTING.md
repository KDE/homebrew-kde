# Simple mass-bamp with helper script
For new releases of frameworks, gear of plasam there is a helper scripts under `tools` subdirectory.
The main script is `tools/update-formulas-common.pl`, there is also three scripts for different kinds of packages:
- `tools/update-formulas-frameworks.sh`
- `tools/update-formulas-gear.sh`
- `tools/update-formulas-plasma.sh`

They just call main script passing argument of packages kind for bump.
E.g. for bumping frameworks update `frameworks_version` in `tools/update-formulas-common.pl` and invoke `$(brew --repo kde-mac/kde)/tools/update-formulas-frameworks.sh`. Same logic is for gear and plasma, just update corresponding variable with version and run corresponding script. We use gpg keys for verifying downloaded tarballs, so you may need to import corresponding gpg key of releaser if you see missing key error. For other formulas, i.e. those with own release cycle you may use brew's livecheck, e.g. `brew livecheck --newer-only --tap kde-mac/kde`. Then commit your changes on a new branch. We strongy recommend verifyig your changes locally by installing / upgrading all our packages from our shipped `Brewfile`, i.e. `brew bundle --verbose --file "$(brew --repo kde-mac/kde)/Brewfile"`.

# Creating new formula
Please check official Homebrew [documentation](https://docs.brew.sh/Adding-Software-to-Homebrew). Mostly all rules apply to our tap. You may want to start from `brew create --cmake --tap kde-mac/kde --set-name <formula-name> <url-to-tarball>`. Where `<formula-name>` is some custom formula name, e.g. we are prefixing framework names with `kf5-`. Just to make sure that formula doens't pick some non-mentioned dependency automaticall, we recommend uninstalling all existing kde formulas by uninstall script, i.e. `"$(brew --repo kde-mac/kde)/tools/uninstall.sh"`. The most essential dependecies for all formulas in our tap is the following:
```ruby
  depends_on "cmake" => :build # should be already added by `brew create`
  depends_on "extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "qt@5"
```
Replace the generated install method with the following snippet:
```ruby
def install
	system "cmake", *kde_cmake_args
	system "cmake", "--build", "build"
	system "cmake", "--install", "build"
 	prefix.install "build/install_manifest.txt"
 end
```
To speedup process of getting required and optional dependecies list you may want to consult some Linux distribution package specs, e.g. I consult with ArchLinux, so I search for corresponding package on [this page](https://archlinux.org/packages/) and examine package's source code. Just make sure to adapt dependencies names to our convention, e.g. add `kf5-` prefix for frameworks. Then starts the hard process: making sure that cmake is happy, e.g. found all required and maybe also optional depencies.

I recommend running install process by adding `-vd` options for brew, e.g. `brew install -vd <new_formula_name>`. Where `-v` stand for `--verbose` and `-d` stands for `--debug`. So if you encounter some error it will be printed to you. You may also want to use brew's debug menu in case of error, e.g. to launch a shell to examine build directory state.

In case of GUI app there may be also required to add some quircks, e.g. adding Qt plugin search path. Please review current GUI apps formulas for common quircks. In case of GUI apps it is also required to add a `caveat` block for making symlink for a binary for easy launch. Please also add this caveat at the end of `tools/do-caveats.sh` file. 

Last step is to update `Brewfile` that we ship in the root of our repo, this process is automated, so you only need to run a script `"$(brew --repo kde-mac/kde)/tools/update-brewfile.sh`.

Don't be affraid that your formula has build or runtime issues, if you reach dead end, feel free to file a drat MR, maybe someone will pick it up and finish. For some reason Invent notifications is broken for me, so please drop an email to yurii.kolesnykov@kdemail.net, so I can review your MR and/or help.
