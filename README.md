# Elm Bootstrap User Documentation

This repository contains the project for generating the User documentation for the [Elm Bootstrap]
(https://github.com/rundis/elm-bootstrap) package.



## Contributing
Pull requests are certainly more than wellcome. Check out the next section for how to get the docs site up and running locally.



## Running locally
To run the docs site locally, you need to clone elm-boostrap **and** elm-bootstrap.info.


The description below assumes you have installed Elm and node/npm.

```bash
# First we clone elm-bootstrap, because the docs site refers directly to sources from this repo
$> git clone https://github.com/rundis/elm-bootstrap.git

$> cd elm-bootstrap

# you might want to fork the repo and clone your fork if you want to submit pull requests !
$> git clone https://github.com/rundis/elm-bootstrap.info.git

$> cd elm-bootstrap.info

# Initial set up of webpack stuff used to run the site
$> npm install

# Start a dev server with hot reloading to serve the site
$> npm run dev

# Open a browser
$> open http://localhost:5000

```



You should end up with a folder structure like follows;
* elm-bootstrap
  * elm-bootstrap.info
    * src
    * elm-package.json
    * ...
  * src
  * test
  * elm-package.json

**NOTE**: elm-bootstrap.info is a subdirectory of elm-bootstrap in this setup.



## License
The code is licensed BSD-3 and the documentation is licensed CC BY 3.0.
