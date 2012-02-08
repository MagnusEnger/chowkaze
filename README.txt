chowkaze.pl

Read a specially formatted YAML file and output static HTML-pages that
form a web-app (using jQuery Mobile) in the same directory as the YAML
file. 

Run "perl chowkaze.pl -h" for script options. 

*** Page layout

The script generates pages with a uniform layout. From top to bottom:

- An introduction in one paragprah
- The rest of the page is split in two columns:
-- Left column:
--- A list of bullet-points
--- A list of underlying pages
-- Right column
--- An image, e.g. a screenshot from a software project

*** Installation

- Create a target directory
- Create a sub-directory called "img", this will hold your images
- Link the directory "static" that comes with the script into the 
  target directory, eg:
  ln -s /home/user/scripts/chowkaze/static/ /home/user/output/
- Create a YAML file in the target directory, you choose the name

*** Run the script

perl chowkaze.pl -y /home/user/output/my-yaml-file.yaml
  
This will generate .html files in /home/user/output/

*** Format of the YAML file

See the file example.yaml

*** Licence

Copyright 2011 Magnus Enger

This is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This file is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this file; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
