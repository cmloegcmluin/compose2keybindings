#!/usr/bin/perl

# REVISION 8
no strict 'refs';

use warnings;

# REVISION 4
use experimental 'smartmatch';

use 5.010;

our $composekey = 0xf710; # F13

our %Keysyms;

use charnames ();
use List::MoreUtils qw(firstidx);
use X11::Keysyms '%Keysyms', ('MISCELLANY', 'XKB_KEYS', '3270', 'LATIN1', 'LATIN2', 'LATIN3', 'LATIN4', 'KATAKANA', 'ARABIC', 'CYRILLIC', 'GREEK', 'TECHNICAL', 'SPECIAL', 'PUBLISHING', 'APL', 'HEBREW', 'THAI', 'KOREAN');

# REVISION 10
$Keysyms{'Abelowdot'} = 0x1001ea0;  # U+1EA0 LATIN CAPITAL LETTER A WITH DOT BELOW
$Keysyms{'abelowdot'} = 0x1001ea1;  # U+1EA1 LATIN SMALL LETTER A WITH DOT BELOW
$Keysyms{'Ahook'} = 0x1001ea2;  # U+1EA2 LATIN CAPITAL LETTER A WITH HOOK ABOVE
$Keysyms{'ahook'} = 0x1001ea3;  # U+1EA3 LATIN SMALL LETTER A WITH HOOK ABOVE
$Keysyms{'Acircumflexacute'} = 0x1001ea4;  # U+1EA4 LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND ACUTE
$Keysyms{'acircumflexacute'} = 0x1001ea5;  # U+1EA5 LATIN SMALL LETTER A WITH CIRCUMFLEX AND ACUTE
$Keysyms{'Acircumflexgrave'} = 0x1001ea6;  # U+1EA6 LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND GRAVE
$Keysyms{'acircumflexgrave'} = 0x1001ea7;  # U+1EA7 LATIN SMALL LETTER A WITH CIRCUMFLEX AND GRAVE
$Keysyms{'Acircumflexhook'} = 0x1001ea8;  # U+1EA8 LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND HOOK ABOVE
$Keysyms{'acircumflexhook'} = 0x1001ea9;  # U+1EA9 LATIN SMALL LETTER A WITH CIRCUMFLEX AND HOOK ABOVE
$Keysyms{'Acircumflextilde'} = 0x1001eaa;  # U+1EAA LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND TILDE
$Keysyms{'acircumflextilde'} = 0x1001eab;  # U+1EAB LATIN SMALL LETTER A WITH CIRCUMFLEX AND TILDE
$Keysyms{'Acircumflexbelowdot'} = 0x1001eac;  # U+1EAC LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND DOT BELOW
$Keysyms{'acircumflexbelowdot'} = 0x1001ead;  # U+1EAD LATIN SMALL LETTER A WITH CIRCUMFLEX AND DOT BELOW
$Keysyms{'Abreveacute'} = 0x1001eae;  # U+1EAE LATIN CAPITAL LETTER A WITH BREVE AND ACUTE
$Keysyms{'abreveacute'} = 0x1001eaf;  # U+1EAF LATIN SMALL LETTER A WITH BREVE AND ACUTE
$Keysyms{'Abrevegrave'} = 0x1001eb0;  # U+1EB0 LATIN CAPITAL LETTER A WITH BREVE AND GRAVE
$Keysyms{'abrevegrave'} = 0x1001eb1;  # U+1EB1 LATIN SMALL LETTER A WITH BREVE AND GRAVE
$Keysyms{'Abrevehook'} = 0x1001eb2;  # U+1EB2 LATIN CAPITAL LETTER A WITH BREVE AND HOOK ABOVE
$Keysyms{'abrevehook'} = 0x1001eb3;  # U+1EB3 LATIN SMALL LETTER A WITH BREVE AND HOOK ABOVE
$Keysyms{'Abrevetilde'} = 0x1001eb4;  # U+1EB4 LATIN CAPITAL LETTER A WITH BREVE AND TILDE
$Keysyms{'abrevetilde'} = 0x1001eb5;  # U+1EB5 LATIN SMALL LETTER A WITH BREVE AND TILDE
$Keysyms{'Abrevebelowdot'} = 0x1001eb6;  # U+1EB6 LATIN CAPITAL LETTER A WITH BREVE AND DOT BELOW
$Keysyms{'abrevebelowdot'} = 0x1001eb7;  # U+1EB7 LATIN SMALL LETTER A WITH BREVE AND DOT BELOW
$Keysyms{'Ebelowdot'} = 0x1001eb8;  # U+1EB8 LATIN CAPITAL LETTER E WITH DOT BELOW
$Keysyms{'ebelowdot'} = 0x1001eb9;  # U+1EB9 LATIN SMALL LETTER E WITH DOT BELOW
$Keysyms{'Ehook'} = 0x1001eba;  # U+1EBA LATIN CAPITAL LETTER E WITH HOOK ABOVE
$Keysyms{'ehook'} = 0x1001ebb;  # U+1EBB LATIN SMALL LETTER E WITH HOOK ABOVE
$Keysyms{'Etilde'} = 0x1001ebc;  # U+1EBC LATIN CAPITAL LETTER E WITH TILDE
$Keysyms{'etilde'} = 0x1001ebd;  # U+1EBD LATIN SMALL LETTER E WITH TILDE
$Keysyms{'Ecircumflexacute'} = 0x1001ebe;  # U+1EBE LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND ACUTE
$Keysyms{'ecircumflexacute'} = 0x1001ebf;  # U+1EBF LATIN SMALL LETTER E WITH CIRCUMFLEX AND ACUTE
$Keysyms{'Ecircumflexgrave'} = 0x1001ec0;  # U+1EC0 LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND GRAVE
$Keysyms{'ecircumflexgrave'} = 0x1001ec1;  # U+1EC1 LATIN SMALL LETTER E WITH CIRCUMFLEX AND GRAVE
$Keysyms{'Ecircumflexhook'} = 0x1001ec2;  # U+1EC2 LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND HOOK ABOVE
$Keysyms{'ecircumflexhook'} = 0x1001ec3;  # U+1EC3 LATIN SMALL LETTER E WITH CIRCUMFLEX AND HOOK ABOVE
$Keysyms{'Ecircumflextilde'} = 0x1001ec4;  # U+1EC4 LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND TILDE
$Keysyms{'ecircumflextilde'} = 0x1001ec5;  # U+1EC5 LATIN SMALL LETTER E WITH CIRCUMFLEX AND TILDE
$Keysyms{'Ecircumflexbelowdot'} = 0x1001ec6;  # U+1EC6 LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND DOT BELOW
$Keysyms{'ecircumflexbelowdot'} = 0x1001ec7;  # U+1EC7 LATIN SMALL LETTER E WITH CIRCUMFLEX AND DOT BELOW
$Keysyms{'Ihook'} = 0x1001ec8;  # U+1EC8 LATIN CAPITAL LETTER I WITH HOOK ABOVE
$Keysyms{'ihook'} = 0x1001ec9;  # U+1EC9 LATIN SMALL LETTER I WITH HOOK ABOVE
$Keysyms{'Ibelowdot'} = 0x1001eca;  # U+1ECA LATIN CAPITAL LETTER I WITH DOT BELOW
$Keysyms{'ibelowdot'} = 0x1001ecb;  # U+1ECB LATIN SMALL LETTER I WITH DOT BELOW
$Keysyms{'Obelowdot'} = 0x1001ecc;  # U+1ECC LATIN CAPITAL LETTER O WITH DOT BELOW
$Keysyms{'obelowdot'} = 0x1001ecd;  # U+1ECD LATIN SMALL LETTER O WITH DOT BELOW
$Keysyms{'Ohook'} = 0x1001ece;  # U+1ECE LATIN CAPITAL LETTER O WITH HOOK ABOVE
$Keysyms{'ohook'} = 0x1001ecf;  # U+1ECF LATIN SMALL LETTER O WITH HOOK ABOVE
$Keysyms{'Ocircumflexacute'} = 0x1001ed0;  # U+1ED0 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND ACUTE
$Keysyms{'ocircumflexacute'} = 0x1001ed1;  # U+1ED1 LATIN SMALL LETTER O WITH CIRCUMFLEX AND ACUTE
$Keysyms{'Ocircumflexgrave'} = 0x1001ed2;  # U+1ED2 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND GRAVE
$Keysyms{'ocircumflexgrave'} = 0x1001ed3;  # U+1ED3 LATIN SMALL LETTER O WITH CIRCUMFLEX AND GRAVE
$Keysyms{'Ocircumflexhook'} = 0x1001ed4;  # U+1ED4 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND HOOK ABOVE
$Keysyms{'ocircumflexhook'} = 0x1001ed5;  # U+1ED5 LATIN SMALL LETTER O WITH CIRCUMFLEX AND HOOK ABOVE
$Keysyms{'Ocircumflextilde'} = 0x1001ed6;  # U+1ED6 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND TILDE
$Keysyms{'ocircumflextilde'} = 0x1001ed7;  # U+1ED7 LATIN SMALL LETTER O WITH CIRCUMFLEX AND TILDE
$Keysyms{'Ocircumflexbelowdot'} = 0x1001ed8;  # U+1ED8 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND DOT BELOW
$Keysyms{'ocircumflexbelowdot'} = 0x1001ed9;  # U+1ED9 LATIN SMALL LETTER O WITH CIRCUMFLEX AND DOT BELOW
$Keysyms{'Ohornacute'} = 0x1001eda;  # U+1EDA LATIN CAPITAL LETTER O WITH HORN AND ACUTE
$Keysyms{'ohornacute'} = 0x1001edb;  # U+1EDB LATIN SMALL LETTER O WITH HORN AND ACUTE
$Keysyms{'Ohorngrave'} = 0x1001edc;  # U+1EDC LATIN CAPITAL LETTER O WITH HORN AND GRAVE
$Keysyms{'ohorngrave'} = 0x1001edd;  # U+1EDD LATIN SMALL LETTER O WITH HORN AND GRAVE
$Keysyms{'Ohornhook'} = 0x1001ede;  # U+1EDE LATIN CAPITAL LETTER O WITH HORN AND HOOK ABOVE
$Keysyms{'ohornhook'} = 0x1001edf;  # U+1EDF LATIN SMALL LETTER O WITH HORN AND HOOK ABOVE
$Keysyms{'Ohorntilde'} = 0x1001ee0;  # U+1EE0 LATIN CAPITAL LETTER O WITH HORN AND TILDE
$Keysyms{'ohorntilde'} = 0x1001ee1;  # U+1EE1 LATIN SMALL LETTER O WITH HORN AND TILDE
$Keysyms{'Ohornbelowdot'} = 0x1001ee2;  # U+1EE2 LATIN CAPITAL LETTER O WITH HORN AND DOT BELOW
$Keysyms{'ohornbelowdot'} = 0x1001ee3;  # U+1EE3 LATIN SMALL LETTER O WITH HORN AND DOT BELOW
$Keysyms{'Ubelowdot'} = 0x1001ee4;  # U+1EE4 LATIN CAPITAL LETTER U WITH DOT BELOW
$Keysyms{'ubelowdot'} = 0x1001ee5;  # U+1EE5 LATIN SMALL LETTER U WITH DOT BELOW
$Keysyms{'Uhook'} = 0x1001ee6;  # U+1EE6 LATIN CAPITAL LETTER U WITH HOOK ABOVE
$Keysyms{'uhook'} = 0x1001ee7;  # U+1EE7 LATIN SMALL LETTER U WITH HOOK ABOVE
$Keysyms{'Uhornacute'} = 0x1001ee8;  # U+1EE8 LATIN CAPITAL LETTER U WITH HORN AND ACUTE
$Keysyms{'uhornacute'} = 0x1001ee9;  # U+1EE9 LATIN SMALL LETTER U WITH HORN AND ACUTE
$Keysyms{'Uhorngrave'} = 0x1001eea;  # U+1EEA LATIN CAPITAL LETTER U WITH HORN AND GRAVE
$Keysyms{'uhorngrave'} = 0x1001eeb;  # U+1EEB LATIN SMALL LETTER U WITH HORN AND GRAVE
$Keysyms{'Uhornhook'} = 0x1001eec;  # U+1EEC LATIN CAPITAL LETTER U WITH HORN AND HOOK ABOVE
$Keysyms{'uhornhook'} = 0x1001eed;  # U+1EED LATIN SMALL LETTER U WITH HORN AND HOOK ABOVE
$Keysyms{'Uhorntilde'} = 0x1001eee;  # U+1EEE LATIN CAPITAL LETTER U WITH HORN AND TILDE
$Keysyms{'uhorntilde'} = 0x1001eef;  # U+1EEF LATIN SMALL LETTER U WITH HORN AND TILDE
$Keysyms{'Uhornbelowdot'} = 0x1001ef0;  # U+1EF0 LATIN CAPITAL LETTER U WITH HORN AND DOT BELOW
$Keysyms{'uhornbelowdot'} = 0x1001ef1;  # U+1EF1 LATIN SMALL LETTER U WITH HORN AND DOT BELOW
$Keysyms{'Ybelowdot'} = 0x1001ef4;  # U+1EF4 LATIN CAPITAL LETTER Y WITH DOT BELOW
$Keysyms{'ybelowdot'} = 0x1001ef5;  # U+1EF5 LATIN SMALL LETTER Y WITH DOT BELOW
$Keysyms{'Yhook'} = 0x1001ef6;  # U+1EF6 LATIN CAPITAL LETTER Y WITH HOOK ABOVE
$Keysyms{'yhook'} = 0x1001ef7;  # U+1EF7 LATIN SMALL LETTER Y WITH HOOK ABOVE
$Keysyms{'Ytilde'} = 0x1001ef8;  # U+1EF8 LATIN CAPITAL LETTER Y WITH TILDE
$Keysyms{'ytilde'} = 0x1001ef9;  # U+1EF9 LATIN SMALL LETTER Y WITH TILDE
$Keysyms{'Ohorn'} = 0x10001a0;  # U+01A0 LATIN CAPITAL LETTER O WITH HORN
$Keysyms{'ohorn'} = 0x10001a1;  # U+01A1 LATIN SMALL LETTER O WITH HORN
$Keysyms{'Uhorn'} = 0x10001af;  # U+01AF LATIN CAPITAL LETTER U WITH HORN
$Keysyms{'uhorn'} = 0x10001b0;  # U+01B0 LATIN SMALL LETTER U WITH HORN

binmode(STDIN, ':utf8'); binmode(STDOUT, ':utf8'); binmode(STDERR, ':utf8');

my %keys;
my %seen;
my @cocoa_modifier_keys = (0x5E, 0x5C, 0x7E, 0x40, 0x23, 0x34);
# REVISION 1
my %replace_map = (
    '<@>' => '<at>',
    '<!>' => '<exclam>',
    '<">' => '<quotedbl>',
    '<\'>' => '<apostrophe>',
    '<(>' => '<parenleft>',
    '<)>' => '<parenright>',
    '<*>' => '<asterisk>',
    '<+>' => '<plus>',
    '<->' => '<minus>',
    '<.>' => '<period>',
    '</>' => '<slash>',
    '<;>' => '<semicolon>',
    '<=>' => '<equal>',
    '<?>' => '<question>',
    '<[>' => '<bracketleft>',
    '<\\>' => '<backslash>',
    '<]>' => '<bracketright>',
    '<^>' => '<asciicircum>',
    '<_>' => '<underscore>',
    '<{>' => '<braceleft>',
    '<|>' => '<bar>',
    '<}>' => '<braceright>',
    '<#>' => '<numbersign>',
    '<~>' => '<asciitilde>',
    '<,>' => '<comma>',
    '<`>' => '<grave>',
    '<&>' => '<ampersand>',
    '<%>' => '<percent>',
    '<$>' => '<dollar>',
    '<:>' => '<colon>'
);

while( my $line = <STDIN> ){
	parseline($line);
}

output(\%keys);

exit 0;

sub parseline {
	my $line = shift;

	chomp($line);

	# REVISION 1
	foreach my $replace_key (keys %replace_map) {
        $line =~ s/\Q$replace_key\E/$replace_map{$replace_key}/g;
    }

	# REVISION 5
	$line =~ s/>(:)/> $1/g;  # Insert a space between > and :
	$line =~ s/(:)"/$1 "/g;  # Insert a space between : and "

	#
	# Parse line
	#

	my @tokens = $line =~ /\"[^\"]+\"|\S+/g;

	# Strip comments
	for my $i ( 0 .. $#tokens ){
		if( $tokens[$i] =~ /^#/ ){
			splice(@tokens, $i);
			last;
		}
	}

	# Return for commented out lines, etc.
	return unless @tokens;
			
	my $colonidx = firstidx { $_ eq ':' } @tokens;

	my @events = @tokens[0 .. $colonidx-1];
	my @results = @tokens[$colonidx+1 .. $#tokens];

	#
	# Decode events
	#
	# Skip all but combinations starting with multi_key (dead keys)
	# REVISION 8
	return unless @events && $events[0] eq '<Multi_key>';

	# Skip all combinations involving dead keys
	return if grep { /^<dead_/ } @events;

	@events = map { /<Multi_key>/ ? $composekey : $_ } @events;
	@events = map { /<U([0-9a-fA-F]+)>/ ? hex($1) : $_ } @events;
	@events = map { /<(.*)>/ ? $Keysyms{$1} // $_ : $_ } @events;

	# REVISION 1
	# If there are any unknown keysyms, report them:
	if( grep { /^</ } @events ){
		die "\nError! Compose key file contains unknown keysyms: \n\n", join(', ', do { my %seen; grep { !$seen{$_}++ } map { /<([^>]+)>/ } @events }), "\n\nPlease replace these with their X11 Keysym name and try again.\n\n";
	}

	@events = map { chr } @events;

	#
	# Decode results
	#

	my $result;
	if( $results[0] =~ /^"(.*)"$/ ){
		$result = $1;
		$result =~ s/\\([0-7]+)/oct($1)/ge;
		$result =~ s/\\(0x[0-9a-zA-Z]+)/oct($1)/ge;
	}
	else {
		die 'unimplemented case';
	}

	#
	# Put into output structure
	#

	# REVISION 7
	my ($comment) = $line =~ /[^<](#.*)/;
	$comment //= '';
	$comment = ' '.$comment;
	my $ref = \%keys;
	for my $i (0 .. $#events) {
		my $event = $events[$i];

		# REVISION 9
		if (ref $ref ne 'HASH') {
			die "\nError! This compose rule:\n\n", $line, "\n\nwill never work, because another compose rule is intercepting it.\nFind the intercepting rule and change it to end with a <space>.\n\n"
		} else {
			if ($i == $#events) { 
				if (exists $ref->{$event} && ref $ref->{$event} eq 'HASH') {
					die "\nError! This compose rule will intercept existing compose rules:\n\n", $line, "\n\ni.e. it will prevent some existing compose rules from ever resolving, since the user's key sequence will match this one first.\nEither remove it or extend it so it no longer conflicts with the existing ruels whose sequences extend it.\n\n";
				} elsif (exists $ref->{$event} && ref $ref->{$event} eq 'ARRAY' && defined $ref->{$event}->[0] && $ref->{$event}->[0] ne $result) {
					die "\nError! This compose rule uses a sequence already used by an earlier rule, but inserts a different result:\n\n", $line, "\n\nFind the conflicting rule that inserts this result and comment:\n\n", $ref->{$event}->[0], "\n", defined $ref->{$event}->[1] && $ref->{$event}->[1], "\n\nand either delete one of them or modify of their key sequences.\n\n";
				} elsif (exists $ref->{$event} && ref $ref->{$event} eq 'ARRAY' && defined $ref->{$event}->[0] && $ref->{$event}->[0] eq $result && defined $ref->{$event}->[1] && $ref->{$event}->[1] ne $comment) {
					$ref->{$event} = [$result, ($ref->{$event}->[1]).$comment];
				} else {
					$ref->{$event} = [$result, $comment];
				}
			} else {
				$ref->{$event} = {} unless exists $ref->{$event};
				$ref = $ref->{$event};
			}
		}
	}
}

sub output {
	my $data = shift;
	my @stack = @_;

	my $indent = @stack;

	# REVISION 7
	if( ref $data eq 'HASH' ){
		print "{\n";
		foreach my $key ( sort keys %$data ){
			my $indent = $indent + 1;
			print "\t" x $indent;
			# REVISION 6
			(ord($key) == 63248) 
				? printf('"^$\UF710" = ') 
				: printf(
					# REVISION 4
					(ord($key) ~~ @cocoa_modifier_keys)
						? '"\\\\\U%04X" = ' 
						: '"\U%04X" = ', ord($key)
				);			

			output($data->{$key}, @stack, $key);
		}

		# Closing brace except for root dictionary where
		# that's a syntax error
		if( $indent ){
			print "\t" x $indent;
			print "};\n";
		}
		else {
			print "}\n";
		}
	}
	else {
		# REVISION 2
		printf '("insertText:", "%s");', 
			join '', 
			map {
				my $ord = ord($_);
				# REVISION 3
				if ($ord > 0xFFFF) {
					my $high_surrogate = 0xD800 + (($ord - 0x10000) >> 10);
					my $low_surrogate = 0xDC00 + ($ord & 0x03FF);
					sprintf("\\U%04X\\U%04X", $high_surrogate, $low_surrogate);
				} else {
					sprintf "\\U%04X", $ord;
				}
			} split //, $data->[0];		
		print ' /* ';
		print join(', ', map { ord $_ == $composekey ? 'Compose' : charnames::viacode(ord $_) // 'unknown' } @stack);
		print ':';
		# REVISION 7
		if ($data->[1] =~ /\S/) {
			print $data->[1];
		} else {
			my $named_results = join ', ', map { charnames::viacode(ord) } split //, $data->[0];
			if ($named_results =~ /[\x{0020}-\x{D7FF}\x{E000}-\x{FFFD}]/) {
				print " ", $named_results;
			} else {
				print " (unknown result)";
			}
		}
		print ' */';
		print "\n";
	}
}	