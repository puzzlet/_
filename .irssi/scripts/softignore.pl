# Web page:
#   http://github.com/gnuvince/irssi-softignore
#
# Installation:
#   Copy in your ~/.irssi/scripts/ directory.
#
# Usage:
#   /softignore_add <nick>: add a nickname to the softignore list
#   /softignore_remove <nick>: remove a nickname from the softignore list
#   /softignore_list: View ignored nicks
#
# 0.02
#   * Added support for ACTION messages
# 0.01:
#   * break out of the search loop when a match is found

use strict;
use warnings;

use Irssi qw(command_bind signal_add signal_continue command);

# Irssi globals
our $VERSION = "0.02";
our %IRSSI = (
    authors     => "Vincent Foley",
    contact     => "vfoleybourgon at yahoo dot ca",
    name        => "Soft Ignore",
    description => "Ignore users by putting their messages in a dim color.",
    license     => "MIT",
);

# Soft ignore globals
our $FILENAME = "$ENV{HOME}/.irssi/saved_softignore";
our $COLOR    = 14;
our @ignores  = slurp($FILENAME);

# Read an entire file into a list, returning the empty
# list if the file cannot be read.
sub slurp {
    my ($filename) = @_;

    my $lines;
    {
        local $/;
        open(my $fd, '<', $filename) or return ();
        $lines = <$fd>;
    }
    return split /\n/, $lines;
}

# Write a list of strings into a file, one string
# per line.
sub spit {
    my ($filename, @lines) = @_;

    open(my $fd, '>', $filename) or return;
    for my $line (@lines) {
        print {$fd} $line."\n";
    }
    close($fd);
}

# Remove extra spaces at the beginning and end of a string.
sub trim {
    my ($str) = @_;

    $str =~ s/^\s*(\S+)\s*$/$1/;
    return $str;
}

# Add a new nickname to the soft ignore list and push
# the modified list into the configuration file.
sub softignore_add {
    my ($data, $server, $witem) = @_;

    push(@ignores, trim($data));
    spit($FILENAME, @ignores);
}

# Remove a nickname from the soft ignore list and
# push the modified list into the configuration file.
sub softignore_remove {
    my ($data, $server, $witem) = @_;

    @ignores = grep { $_ ne trim($data) } @ignores;
    spit($FILENAME, @ignores);
}

# Display the nicknames in the soft ignore list.  Works
# only in a channel window, not in the status window.
sub softignore_list {
    my ($data, $server, $witem) = @_;

    if (@ignores == 0) {
        Irssi::print("No soft ignore entries.");
    }
    else {
        Irssi::print("Soft ignore list:");
        for my $ignore (@ignores) {
            Irssi::print("* $ignore");
        }
    }
}

# When a message comes in from a nickname in the soft
# ignore list, colorize the message and display it.
sub softignore_message {
    my ($server, $msg, $nick, $address, $target) = @_;

    for my $ignore (@ignores) {
        if ($nick =~ /$ignore/i) {
            signal_continue($server, "\003$COLOR$msg",
                            $nick, $address, $target);
            last;
        }
    }
}

command_bind softignore_list   => \&softignore_list;
command_bind softignore_add    => \&softignore_add;
command_bind softignore_remove => \&softignore_remove;

signal_add "message public"     => \&softignore_message;
signal_add "message irc action" => \&softignore_message;
