#HTTP Request Tool
###Description
- Be able to query, manipulate, and save rows in a database via URLs
- Be able to create an app that uses conditionals to execute different branches of code
- Be able to appropriate format responses
- Be able to handle errors

###Setup
- Fork this repo
- Clone this repo
- Enter the following in the terminal under the path of your cloned directory:

```
$ bundle install
$ rake db:migrate
```
- Now you can run the ruby run file:

```
$ ruby bin/run.rb
```
- You should then be prompted with a query asking for an HTTP request

###Topics
- Become familiar with Active Record and control flow
- Be able to write migrations
- Be able to return requested records from the database given a URL.
- Be able to write a descriptive and accurate README

###Takeaway

- Now have a better grasp of when to call a method on an instance of a model class of to call it on the class itself with Active Record


###Contents of this repo

```
.
├── Gemfile               # Details which gems are required by the project
├── README.md             # This file
├── Rakefile              # Defines `rake generate:migration` and `db:migrate`
├── config
│   └── database.yml      # Defines the database config (e.g. name of file)
├── console.rb            # `ruby console.rb` starts `pry` with models loaded
├── db
│   ├── dev.sqlite3       # Default location of the database file
│   ├── migrate           # Folder containing generated migrations
│   └── setup.rb          # `require`ing this file sets up the db connection
└── lib                   # Your ruby code (models, etc.) should go here
│  └── keep
│  └── todo_list.rb       # model for 'todo_lists' table
│    └── all.rb           # Require this file to auto-require _all_ `.rb` files in `lib`
└── bin
    └── run.rb            # main program code
