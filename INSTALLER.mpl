#################################################################################
#
# Filename: INSTALLER.mpl
# 
# Copyright (c) 2018 Temur 
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
##################################################################################    

restart;

with(FileTools, Exists, IsDirectory, MakeDirectory, Basename, ListDirectory):
with(LibraryTools, Create):
with(StringTools, FormatTime):


_package_name := "MapleToolx":

_d := kernelopts(dirsep):
_lib_dir := cat(kernelopts(homedir), _d, "maple", _d, "toolbox", _d, _package_name, _d, "lib"):
_lib_archive := cat(_lib_dir, _d, "maple.mla"):


printf("\n### Installing Package: \"%s\"  @  %s\n\n", _package_name, FormatTime("%Y-%m-%d_%X"));


if Exists(_lib_dir) and Exists(_lib_archive) and not IsDirectory(_lib_archive) then
    printf("  - Old installation is found in the system. Skipping library installation...\n");
else
    printf("  - Old installation was NOT found. Installing fresh one...\n");
    printf("  - libname_OLD: %q\n", libname);

    MakeDirectory(_lib_dir, 'recurse');
    Create(_lib_archive);
end if;

if not evalb(_lib_dir in [libname]) then
    printf("  - Temporarily adding library directory to libname paths...\n");
    printf("    ##  Please restart Maple after installation!!!\n");

    libname := _lib_dir, libname:

    printf("  - libname_NEW: %q", libname);
else
    printf("  - Library Directory is already in OLD libname paths...\n");
end if;

_source_dir := currentdir():

if evalb(Basename(_source_dir) = _package_name) then

    for source_file in ListDirectory(_source_dir, absolute = false, returnonly = "mod*.mpl")
        do
            _module_name := substring(Basename(source_file), 4 .. -1);
            _file_path := cat(_source_dir, _d, source_file);

            printf("\n\n  - Updating module: \"%s\":\n", _module_name);
            printf("    < from source file:  \"%s\"\n", _file_path);
            printf("    > into the library archive: \"%s\"\n\n", _lib_archive);

            read _file_path;
            savelib(convert(_module_name, name), _lib_archive);
        end do;

    printf("\n### Done! All modules are installed/updated...\n\n");
else
    printf("  - Current dirrectory is NOT a source directory, installation can NOT be continued!!!\n");
    printf("\n### Failed! PLEASE RUN THIS INSTALLER FROM IT'S DIRECTORY!\n\n");
end if;


##################################################################################    
#
# End of File: INSTALLER.mpl
#
##################################################################################    

