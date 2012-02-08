#!/usr/bin/perl -w

# chowkaze.pl
# Copyright 2011 Magnus Enger

# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This file is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this file; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

use Modern::Perl;
use Template;
use YAML::Syck qw'LoadFile';
use Getopt::Long;
use Pod::Usage;
use File::Basename;
use Data::Dumper;

my ($yaml, $debug) = get_options();

print "\nStarting chowkaze.pl\n" if $debug;

# Check that the YAML file actually exists
if (!-e $yaml) {
  die "Couldn't find YAML file $yaml\n";
}
print "YAML: $yaml\n" if $debug;

# Read the YAML file
my ($settings, $menu, $pages) = LoadFile($yaml);

print Dumper $settings if $debug;
print Dumper $pages    if $debug;
print Dumper $menu     if $debug;

# The destination directory will be the directory the YAML file is in
my($filename, $destdir, $suffix) = fileparse($yaml);
print "Destination dir: $destdir\n" if $debug;

# TODO Delete .html files from the target directory

my $tt = Template->new({
    INCLUDE_PATH => '.',
    INTERPOLATE  => 1,
}) || die "$Template::ERROR\n";

process_page($menu);

print "\n";

sub process_page {

  my $menu  = shift;

  foreach my $menuitem ( @{$menu} ) {
    while ( my ($page, $submenu) = each( %$menuitem ) ) {
      print "* ", get_page_title($page), "\n" if $debug;
      my @localmenu;
      foreach my $submenuitem ( @{$submenu} ) {
        while ( my ($subpage, $subsubmenu) = each( %$submenuitem ) ) {
          my %m;
          $m{'slug'}  = $subpage;
          $m{'title'} = get_page_title($subpage);
          push(@localmenu, \%m);
        }
      }
      my $vars = {
        settings => $settings, 
        slug     => $page, 
        page     => $pages->{$page},
        menu     => \@localmenu,
      };
      my $outfile = $destdir . $page . ".html";
      print "$outfile\n";
      $tt->process('page.tt', $vars, $outfile) || die $tt->error(), "\n";
      my $pageimage = $destdir . "img/" . $page . ".png";
      if ( !-e $pageimage ) {
        print "ERROR: $pageimage not found\n";
      }
      process_page($submenu);
    }
  }
  
}

sub get_page_title {
  my $slug = shift;
  if ($pages->{$slug}{'title'}) {
    return $pages->{$slug}{'title'};
  } else {
    return $slug;
  }
}

# Get commandline options
sub get_options {
  my $yaml = '';
  my $debug = '';
  my $help = '';

  GetOptions("y|yaml=s" => \$yaml,
             "d|debug!" => \$debug,
             'h|?|help' => \$help
             );
  
  pod2usage(-exitval => 0) if $help;
  pod2usage( -msg => "\nMissing Argument: -y, --yaml\n", -exitval => 1) if !$yaml;

  return ($yaml, $debug);
}

__END__

=head1 NAME

chowkaze.pl - Read a YAML structure, output a web-app for tablets

=head1 SYNOPSIS

chowkaze.pl -y /home/koha/presentation/koha.yaml

=head1 OPTIONS

=over 8

=item B<-y, --yaml>

Full path to YAML file.

=item B<-d, --debug>

Extra output for debugging.

=item B<-h, -?, --help>

Prints this help message and exits.

=back

=cut
