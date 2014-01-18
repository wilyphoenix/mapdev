# activestate perl for windows
#!/usr/bin/perl

# UrT 4.2

###################################################################################################################################
## Author:  Dan Barrett a.k.a. wily duck (wilyduck@gmail.com)
## Date:    6/8/2011 (original)
## Program: versioneer.pl
## Purpose: Automatically progress or fork a map version.
##
## Important: This script is a README, manual, and script all-in-one. Read it through so you know
##            exactly what's going on! It's really not that hard, but I make sure that you're sure.
##
## Requirements: You need perl to execute this script. For windows, get activestate perl at:
##               http://www.activestate.com/activeperl/downloads
##               Once installed, you don't need to do anything else to configure perl. Automagic!
##
## Notes:   1. Read the "Info" and "Instructions" section. This script is pretty well documented.
##          2. It does NOT search for shader dependencies, nor does it reference external shaders -
##             meaning that this script works great for stand-alone maps. If your map does reference
##             external resources, you can optionally specify them in Section 2 per instructions, or
##             leave them be if you want them to continue referencing their current resource.
##          3. The versioneer only copies files - except for copysame() which rewrites a file.
##          4. No undo, so worse case, you'll end up with a new map you didn't want. Won't overwrite
##             an existing .map - in fact we'll abort if you accidentally specified an existing .map.
##             that already exists. You should be backing up your .map's anyway! Daily!
##          5. Can be re-run immediately if say a folder didn't copy correctly and you fixed
##             that folder. Delete the new .map created and re-run the versioneer.
##          6. Built for perl on windows. Easily portable to *nix if you DIY. :)
##          7. I trust this script for my maps, so you should have some faith the versioneer won't
##             break your maps either. Even if you Do It Wrong, you'll end up with extra files, maybe
##             a shaderlist.txt with an extra line. Not horrible.
##          8. When the versioneer packages a map, it does not create a final pk3 file. It bundles all files
##             that it copies into a package directory for you to verify, Zip, and rename to .pk3 yourself.
##          9. You will need to recompile your .bsp to match resources in your new map.
##
## Version: v1.8 - 12262013.0 - Changed strings for 4.2. Updated some error checking for paths.
##          v1.7.1 - 12162013.0 - Uploaded to GitHub. Modifying some documents. Limited line width to no longer than 132 chars.
##          v1.7 - 12052013.0 - Adding model name output. Still can't copy models (yet).
##          v1.6 - 11262013.0 - Changed map1/map2 variables to better describe old_map/new_map. Updated docs.
##          v1.5 - 04072013.2 - Added automatic model migration for making your map more stand-alone.
##          v1.4 - 04072013.1 - Added packaging logic. No longer need to specify $path with all functions.
##                              Made copying more safe (against overwrites if recopying to a new map).
##          v1.3 - 04062013.0 - Added a bunch more comments for other users that might find the
##                              versioneer useful! Added more logic to copysame(). Now uses
##                              $path so the versioneer can live anywhere on your system you like.
##                              Added all sorts of user-friendliness and yet more logic!
##          v1.2 - 06142011.0 - Added safety check to verify if new map already exists. Copying
##                              the .map file is now the last action.
##          v1.1 - 06112011.0 - Restructured the configuration sections. Lots more commenting.
##                              Added second arg to &copydir. No longer need to double backslash
##                              folder names.
##          v1.0 - 06082011.1 - Works just fine. Should have made this years ago.
##          v0.0 - 06082011.0 - Starting new script from newscript template 03262010.2
##
## Bugs:    #0 - 06082011.0 - None.
##
## To-do:   1. None.
##
## Warranty: None! You're on your own! /legaldisclaimer
##
## Support: Send me an email if you have questions. I'll usually get back to you within 48 hours. Not
##          guaranteed of course!
##
## License: Open source, freely redistributable, modifications and forks are expected. Give me credit
##          as the original author including name and email.
##
## Usage:   perl versioneer.pl
###############################################################



###  Info!  ###

# Really handy script to fork a copy of your map as a new stand-alone map. Great for beta's, new point releases,
# or trying something new. For example, ut4_yourmap is released, now you want to move on to ut4_yournew_map.
# The versioneer will copy the resources of ut4_yourmap to ut4_yournew_map, so you won't mess with the
# original map. Even better, say you have ut4_yourmap_beta, and you want to create a new map that doesn't
# conflict with old shaders/textures/etc. Fork a ut4_yourmap_beta2! All new, _completely independent_ of
# the first map. You should remove that old pk3 from q3ut4 eventually though. Remember UrT/Q3 has
# to parse every pk3 each time you load UrT! Having too many pk3s slows down loading maps.

# The versioneer really appreciates when you treat your map as a stand-alone map, free of referencing
# shaders/textures/sounds/models/etc from UrT pack files or other maps. This way, you have complete control
# over your maps' resources. You also don't inadvertantly squash someone else's textures/shaders. It's
# good practice. It's also fun to play your map in a completely different mod, like excessive or padman!
# If you don't know how to build an independent map, it's simple. Don't use anyone else's resources.
# Don't call any other shaders than say "textures/ut4_yourmap/shadername" in your ut4_yourmap.shader file.
# All models you use reside in models/mapobjects/ut4_yourmap/modelname". Textures reside in
# textures/ut4_yourmap/texture.tga  Etc!

# If you "borrow" from other pk3's to achieve independence, and want to preserve knowing what resources
# have been borrowed, try creating a substructure like say textures/ut4_yourmap/depends/ut_sidmap/rabidcows_tex.jpg
# Then in the versioneer, you'd set the function to copy the depends/ dir recursively. Easy!

# The output is somewhat verbose, with most lines beginning with op> for operations, cmd> for actual commands executed,
# and Info: for delineating tasks. The versioneer will ask to "press any key" first before getting to business.



###  Instructions!  ###

# The versioneer lives in your q3ut4/ directory by default, but as long as you specify $path, anywhere is fair game.
#
# 1. Modify variables in Section 1. Specify the source map being copied, and new map being created.
#
# 2. If your map references external resources, like shaders that do not match your source map name,
#    or any one-offs that should be addressed, you can have the script pull in these one-offs and merge
#    them into the new map. There are many examples of functions in Section 2 to guide you. Control-S to save.
#
# 3. Execute cmd or run from explorer: perl versioneer.pl
#
# 4. Validate your new map. Review the versioneer output. Check folders/files manually if needed.
#    Within radiant, reload textures/shaders (Textures -> Flush and reload), then open your new map.



###  Note of safety!  ###

# Your original map resources will not be harmed! We copy from, never write to - with the exception of
# the copysame() function, normally used for shaderlist.txt which must be overwritten (but will be backed
# up first).





# ===================== #
#       Section 1       #
# ===================== #


### ===================================================================== ###
### IMPORTANT!!!!! Use / forward slashes in all cases, not \ backslashes! ###  <-- really important
### ===================================================================== ###


# FIRST: Where is your Urban Terror exe?
$path =   "E:/Games/FPS/UrbanTerror42_dev";	# suffix slash / not necessary. we'll fix it if you demand to append it
$urtexe = "Quake3-UrT.exe";      		# name of the UrT exe file to make sure $path is specified correctly
$q3ut4 =  "q3ut4";                   		# game assets and resources folder

# SECOND: Specify your old and new map:
$old_map = "ut4_yacht";		# Copy from old_map...
$new_map = "ut4_cmmcontest_a1";	# and create new_map. Specify same name as old_map when packaging.


# THIRD: This is optional.
# We can create the preliminary pk3 package resource dir. You review it, then zip to a pk3. Beats finding all map resources
# yourself! Models are a different story. At the moment, you can set review_models to see what models to copy, as well as
# auto-copy them into a package. Cloning models isn't supported yet.

$package = "no";
                    # Options: [yes|force|'']       ('' = null, no quotes)
                    # Specify "yes" if you want to create $new_map resources in q3ut4/$packdir/$new_map/ for package bundling.
                    # We'll copy all map resources to the $packdir dir rather than the standard q3ut4 dir.
                    # I like to use q3ut4/dev/ut4_thismap/ for example to place my textures/, maps/, env/, etc. folders that
                    # will make up the contents of the map pk3 for zip'ing.
                    # $package won't update shaderlist.txt in q3ut4/scripts/ if set to "yes", so set to "force" if you need it to.

$packdir = "dev/";
                    # Options: specify "dirname/"
                    # If $package is "yes", this will tell us where to place the package files.
                    # Output path: $path/q3ut4/$packdir/$new_map/

$dotmap = "create";
                    # Options: [create|move|none]
                    # Standard copy migration behavior of the versioneer migrates your [old_map].map to [new_map].map. However,
                    # activating $package will inherently copy your .map to the packaging dir. If you don't want to expose your
                    # .map source file in the package, specify "move" here to store the newly created [new_map].map file in
                    # q3ut4/maps/ instead of in the packaging dir. Specify "none" if you do not want to create a [new_map].map
                    # whatsoever. Not recommended.

$review_models = "yes";
                    # Options: [yes|no]
                    # This will list all models found (de-duplicated) if set to "yes". If activating the next option, $copy_model,
                    # $review_model must be active.

$package_models = "yes";
                    # Options: [yes|no]
                    # If $package and $review_models is active, during the process we can copy models into the package dir. This
                    # does not clone models for independent map use. Next option, $clone_models, is intended to do that.

$clone_models = "no";
                    # ** Don't use. Technique is not sound. This function must be re-assessed. Including for historical reasons.
                    # Set to "yes" for converting all references of models/mapobjects/ to models/mapobjects/$new_map/ within
                    # the .map file. Requires $review_models above to be set to "yes". Super useful to copy out shared models
                    # into an isolated environment where you can shader them without inadvertantly affecting other maps.


#### ================ ####
#### End of Section 1 ####
#### ================ ####

## Move ahead one space to Section 2. Nothing to do here.

&startup();  # Prepare our environment.
&primary();  # Do the normal copy stuff first.


#  | Go this way!
#  |
#  |
#  |
#  V


# ===================== #
#       Section 2       #
# ===================== #


## Specify additional actions here. Function definitions are described below.
## General usage is ([source_dir],[dest_dir]) where your map name is spliced between source and dest.


&copydir("env/","");  # Used for skyboxes. Will copy/create env/yourmap/skybox_up.jpg etc

&copydir("textures/","/editor");  # Radiant editor stuff I use for shader reference.

&copydir("sound/","recursive");  # Overriding default copydir. Copy all old_map dirs, example: sound/ut4_yourmapname/*/*





###
### /// *EXAMPLE* real-world functions/actions used with other maps. 
###

# &copydir("levelshots/","");  # Animated levelshot! Has its own dir for levelshot frames.
# &copydir("textures/ducktextures/","literal");  # Example function that demands resources outside of textures/$new_map/
# &createfile("scripts/","-ss_b1-models.shader");  # This will rename all $old_map instances, leaving "ut4_ss_b1" shader names
                                                   # alone.
# &copysame("scripts/shaderlist.txt","add","-ss_b1-models") if $package ne "yes";  # Don't forget to update shaderlist! If not
                                                                                   # bundling.
# &copydir("models/mapobjects/","recursive");  # Not the whole mapobjects dir lol! this path gets appended with $new_map during
                                               # copy.
# &copyfile("maps/",".bsp") if $package eq "yes";  # remember to recompile after versioneer'ing to a new map.
# &copydir("textures/","/raid_drops");  # Subdir with a group of textures.
# &copydir("textures/","/raid_drops2");

### More examples of additional actions when I migrated ut4_temple2_alpha to ut4_temple2_beta
# &createfile("scripts/","-plant.shader");  # needed to progress ut4_temple2_alpha-plant.shader to ut4_temple2_beta-plant.shader
# &copysame("scripts/shaderlist.txt","-plant.shader");  # ...and needed to update shaderlist.txt accordingly
# &copydir("textures/","/tf1");  # had additional textures in textures/ut4_temple2_alpha/tf1/ that needed to migrate




## ==================== ##
## Function definitions ##
## ==================== ##

# createfile ([dir],[file_suffix]) - reads the mapname text within a file and copies the new mapname text to a new mapname
#                                    file [primarily for .map, .shader]
#                                    Note, this is a global search and replace, and if $old_map happens to be inadvertantly
#                                    a partial map name for a name that exists within the file (rare), you may have a problem!
#                                    i.e. $old_map = "ut4_yourmap" but your file contains "ut4_yourmaprocks" ... well you'll
#                                    find all sorts of $new_map in there like "ut4_newmaprocks". Make sure $old_map and $new_map
#                                    are EXACTLY what you want to find and replace if you think there is a conflict!

# copyfile ([dir],[file_suffix]) - copies old mapname file to new mapname file [primarily for minimap, levelshot]

# copydir ([dir],[leaf]) - copies old mapname folder in a dir to new mapname in the same folder, and leaf folders
#                          under that dir if specified [primarily for textures/, sound/]
#                          Be sure to specify the prefix / in [leaf], i.e. "/foldername".
#                          Specify "recursive" for [leaf] if you want all subfolders copied as-is. This will overwrite
#                          destination files.
#                          Specify "literal" for [leaf] to skip appending $new_map to [dir].

# copysame ([file],[action],[suffix]) - subs mapname text within a file and rewrites that file [primarily for shaderlist.txt]
#                              copysame() will ONLY copy within q3ut4/, not a packaging path. Thus best for shaderlist.txt.
#                              If [action] is "add" or null (default), copysame will simply insert $new_map into [file],
#                              preferably after $old_map.
#                              If [action] is "strict", copysame will only replace instances where the line begins and
#                              ends with $old_map as the text with $new_map.
#                              If [action] is "global", copysame will globally search and replace all instances of $old_map
#                              with $new_map within [file].
#                              [suffix] allows for appending shader names, like mapname + suffix, i.e. ut4_yourmap-surfaces

## Arguments:
# ..where [file_suffix] is any text after the mapname, i.e. ut4_yourmap[.txt] to take action on ut4_yourmap.txt
# ..where [dir] is a dir that can either be blank to specify the default maps/ dir, or specified like ../scripts/
# ..where [file] is the dir and file name, i.e. $path/scripts/shaderlist.txt
# ..where [leaf] is a folder path suffix of a mapname dir, i.e. for textures/yourmap/editor you specify ("../textures/","/editor")






##############################################
#### End of standard script configuration ####
##############################################

&finish();

exit;  # cause it looks better to have an obvious exit.
























# That means go away or prepare to wield your sword of +3 Perling!

###################################################################################################################################
# =============================================================================================================================== #
###################################################################################################################################

# From here down is code that you shouldn't mess with, unless you have a reason to.
# Reasonably commented where code behavior isn't obvious.









################################################
#### SUBS - no modifications required below ####
################################################

sub startup {

  if (! -e "$path/$urtexe") {
    print "Your path doesn't seem right. Can't find UrT executable said to exist here:\n$path/$urtexe\n\n";
    print "Make sure you haven\'t put backslashes \'\\\' in your path. You MUST use regular forward slashes! \'\/\'\n\n";
    print "Press a key to exit (and fix the config)...\n";

    <STDIN>;
    exit;
  }

  $path .= "/" if $path !~ /\/$/;  # Add a / suffix if none specified
  $path .= "$q3ut4/";

# Sanity check
  die "Check your map name and try again. $path/maps/$old_map.map\n" if ! -e "$path/maps/$old_map.map";
# Safety check
  die "New .map file already exists! Aborting as a precaution. $destpath/maps/$new_map.map\n" if -e "$destpath/maps/$new_map.map";

  if ($package eq "yes") {
    $destpath = $path . $packdir . "$new_map/";
    $abbr_path = "$q3ut4/" . $packdir . "$new_map/";  # For pretty abbreviated output

  } else {  # ensure copy-from path then matches copy-to path if we're not packaging
    $destpath = $path;
  }

  print "\nInitial checks complete, ready to begin.\n";
  print "\nThe versioneer will copy $old_map to $new_map";
  print " as a \npackage bundle in $abbr_path" if $package eq "yes";
  print " and models found will be listed upon conclusion of the versioneer" if $review_models eq "yes";
  print " with models copied to the package bundle" if $package_models eq "yes" && $package eq "yes";

  print ".\n";

  print "\nReady! Press enter to begin! (or control-C to abort)\n\n";
  <STDIN>;

## Unfortunately the next runcommand() executes no matter what, even when control-C is pressed. This is a work-around.
  &runcommand("echo", "The Versioneer");

  return 0;

}




### Primary copy actions ###

sub primary {

  if ($package eq "yes") {
    &op("Creating package bundle directory $destpath");

    if (-d "$destpath") {
      print " ** SKIPPING ** copying because the directory exists:\n$destpath\n";
    } else {
      &runcommand("mkdir", "$destpath");
    }
  }

  &createfile("scripts/",".shader");

  &createfile("scripts/",".arena");

  if ($package ne "yes") {  # setting $package to "force" will trigger this
    &copysame("scripts/shaderlist.txt","add");  # Inject $new_map into shaderlist.txt
  }

  &copyfile("levelshots/",".tga");  # Looks for ut4_yourmap.tga, turns into ut4_newmap.tga

  &copydir("sound/","");

  &copydir("textures/","");

  &copyfile("maps/",".tga");

## Handle the .map action. Any mapper knows this is touchy business.
  if ($dotmap ne "none") {
     &op("Creating $new_map.map");

    if ($dotmap eq "move") {  # It's necessary to move the map after creation because by the function, it will be created
                              # in $destpath, so we must move it back to $path specifically.

      if (! -e "$path/maps/$new_map.map") {  # Check the .map doesn't already exist in the source map/ directory.
        &createfile("maps/",".map");

        &op("Returning $destpath/maps/$new_map.map back to $path");
        &runcommand("move", "$destpath/maps/$new_map.map", "$path/maps/$new_map.map");

      } else {  ## If this happens, you could delete the package dir resources and start again.
        print " ** SKIPPING ** creating the .map, because the destination .map already exists:\n$path" . "maps/$new_map.map\n";
      }

    } else {
      &createfile("maps/",".map");
    }

  }

# remember to recompile after versioneer'ing to a new map.
  &copyfile("maps/",".bsp") if $package eq "yes";


  print "\n\nInfo: Primary functions complete. Additional functions next.\n";

  return 0;

}



sub finish {

   my $line, $modelpath = "";

## If we want to migrate the .map to a standalone version that does not reference global models
  if ($review_models) {

    foreach $line (@newmodel) {

      $line =~ s/^\"model\" \"//;  # scrub the line
      $line =~ s/\"\s*$//;

      $models{$line}++;  # remove duplicates with a hash

    }

    print "\nList of models found:\n";

    foreach $model_entity (sort keys %models) {  # show what models we modified in the .map

## strip the model file name from the path
      $modelpath = $model_entity;
      $modelpath =~ s/^(\S+)\/.*?$/$1/;

      if ($clone_models eq "yes") {  # insert new_map into the model path
        $modelpath =~ s/mapobjects\//mapobjects\/$new_map\//;

        &runcommand("xcopy /E /Y","$path$modelpath/*","$destpath$modelpath/*");

      } else {
        print "$modelpath\n";
      }

      &copydir("$modelpath","recursive") if $package_models eq "yes" && $package eq "yes";

    }

    print "No external shared models to copy.\n" if ! $modelpath;

  }

  print "\nComplete. The versioneer aims to please. Press any key to continue.\n"; `pause`;

  exit;

}



######################
## Function actions ##
######################

sub copydir {

  my ($dir,$leaf,$copydir_source,$copydir_dest) = ();
  my ($dir,$leaf) = @_;


  $dir .= "/" if $dir !~ /\/$/;  # add a / suffix if not specified
  $leaf =~ s/\/$//;  # need to lose the suffixed / to copy properly

  $copydir_source = "$dir$old_map";
  $copydir_dest = "$dir$new_map";

## Detect if this is a model resource
  if ($dir =~ /^models\/mapobjects/) {
    if ($clone_models eq "no") {
      $copydir_source = $dir;
      $copydir_source =~ s/\/$//;
      $copydir_dest = $dir;
      $copydir_dest =~ s/\/$//;
    }
  }

  if ($leaf eq "recursive") {  # xcopy has /Y set, so it will overwrite destination files

    &op("copydir recursive $copydir_dest");

    &runcommand("mkdir", "$destpath$copydir_dest");
    &runcommand("xcopy /E /Y", "$path$copydir_source", "$destpath$copydir_dest");

  } else {

    &op("copydir $copydir_dest$leaf");

    if (-d "$destpath$copydir_dest$leaf") {
      print " ** SKIPPING ** copying because the directory exists:\n$destpath$copydir_dest$leaf\n";
      return 0;
    }

    &runcommand("mkdir", "$destpath$copydir_dest$leaf");
    &runcommand("copy", "$path$copydir_source$leaf/*", "$destpath$copydir_dest$leaf/*");

  }

}


sub copyfile {

  my ($dir,$suf) = ();
  my ($dir,$suf) = @_;

  $dir .= "/" if $dir !~ /\/$/;  # add a / suffix if not specified

  &op("copyfile $dir$new_map$suf");

  if (! -e "$path$dir$old_map$suf") {
    print " ** SKIPPING ** copying because the source file doesn't exist:\n$path$dir$old_map$suf\n";
    return 0;
  }

  if (-e "$destpath$dir$new_map$suf") {
    print " ** SKIPPING ** copying because the destination file exists:\n$destpath$dir$new_map$suf\n";
    return 0;
  }

  &runcommand("mkdir", "$destpath$dir") if ! -d "$destpath$dir";
  &runcommand("copy", "$path$dir$old_map$suf", "$destpath$dir$new_map$suf");

}


sub createfile {

  my ($dir,$suf) = ();
  ($dir,$suf) = @_;

  $dir .= "/" if $dir !~ /\/$/;  # add a / suffix if not specified

  &op("createfile $dir$new_map$suf");

  if (! -e "$path$dir$old_map$suf") {
    print " ** SKIPPING ** creating file because the source doesn't exist:\n$path$dir$old_map$suf\n";
    return 0;
  }

  &op("Directory $destpath$dir needs to be created") if ! -d "$destpath$dir";
  &runcommand("mkdir", "$destpath$dir") if ! -d "$destpath$dir";

  if (-e "$destpath$dir$new_map$suf") {
    print " ** SKIPPING ** copying because the destination file exists:\n$destpath$dir$new_map$suf\n";
    return 0;
  }

  open (NEW, ">$destpath$dir$new_map$suf") || die "Could not write $destpath$dir$new_map$suf\n$!";
  open (MAP, "$path$dir$old_map$suf") || die "Could not read $path$dir$old_map$suf\n$!";
  while ($line = <MAP>) {
    $line =~ s/$old_map/$new_map/g;  # globally replaces instances of $old_map with $new_map

## Here we can make all models stand-alone
    if ($review_models) {
      if ($line =~ /^\"model\"/) {  # we're likely parsing a .map file, so let's look for models

        push (@newmodel, $line);  # track what models have been modified

        if ($clone_models eq "yes") {  # Clone the model to a new independent model
          $line =~ s/mapobjects\//mapobjects\/$new_map\//;  # insert new_map into the model path

        }
      }
    }

    print NEW $line;

  }

  close MAP;
  close NEW;

}


sub copysame {

  my ($file,$action,$suffix,$line) = ();
  ($file,$action,$suffix) = @_;

  $action = "add" if ! $action;  # set default action to add

  my $find = $old_map . $suffix;
  my $replace = $new_map . $suffix;

  &op("copysame $replace $action");

  if (! -e "$path$dir$file") {
    print " ** SKIPPING ** copying because the source doesn't exist:\n$path$dir$file\n";
    return 0;
  }

  my @contents = ();

  open (FILE, "$path$file") || (warn ("Couldn't read $path$file\n$!") && return 1);  # We will ONLY copy in and out of q3ut4/, not
                                                                                     #  a packaging path
  while ($line = <FILE>) {
    $line =~ s/\s+$//;  # strip whitespace from end of line

    if ($action eq "global") {  # global string find and replace
      $line =~ s/$find/$replace/g;      

    } elsif ($action eq "strict") {  # only replaces lines that begin and end with the string
      if ($line eq $find) {
        $line = $replace;
      }

    } else {  # action is [add] or null
      if ($line eq $find) {
        $line .= "\n$replace";
        $action = "added";
      }

      if ($line eq $replace) {  # shouldn't see new_map in shaderlist.txt already - so don't dupe it
        print " ** SKIPPING ** Duplicate $replace is already in $file\n";
        @contents = ();

        return 0;
      }

    }

    push (@contents, $line);

  }
  close FILE;

  if ($action eq "add") {  # didn't find old_map? Then append new_map to end of file
    push (@contents, $replace);
  }

  print "Info: Creating backup version of $file first ...\n";
  &runcommand("copy", "$path$file", "$path$file.old");  # keep the old file just in case!

## Write out the file
  open (FILE, ">$path$file") || (warn ("Couldn't write $path$file\n$!") && return 1);
  foreach $line (@contents) {
    next if $line !~ /\S+/;  # skip blank lines
    print FILE "$line\n";
  }
  close FILE;

  print "Info: $path$file updated ...\n";

  @contents = ();

}


## Reformats commands to work in the DOS cmd environment, then runs the command.
sub runcommand {

  my ($cmd,$arg1,$arg2) = ();
  ($cmd,$arg1,$arg2) = @_;

  $arg1 =~ s/\/$// if $cmd eq "mkdir";  # irritating DOS quirk, mkdir doesn't like trailing /

  $arg1 =~ s/\//\\/g;  # Replace /'s with \'s (and double backslash the \'s)
  $arg2 =~ s/\//\\/g if $arg2;

  $arg1 = "\"$arg1\"";
  $arg2 = "\"$arg2\"" if $arg2;

  $cmd .= " $arg1";
  $cmd .= " $arg2" if $arg2;

  print "cmd> $cmd\n";

  `$cmd`;  # run the command via cmd shell

  return 0;

}


## For making output more readable/sane
sub op {

  my $line = $_[0];

  print "\nop> $line ...\n";

  return 0;

}

