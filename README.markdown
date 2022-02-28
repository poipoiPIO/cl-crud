# Common lisp CRUD  
My trying into JSON CRUD API in Super Cute Language

Simple note json api app which could perform following things:
> Create new note
> Read all notes from DB or read note by id
> Update text of note selected by id
> Delete note from database

## Dependences: 
* [Mito](https://github.com/fukamachi/mito)
* [Ningle](https://github.com/fukamachi/ningle)
* [Log4cl](https://github.com/7max/log4cl)
* [Clack](https://github.com/fukamachi/clack)
* [Jonathan](https://github.com/Rudolph-Miller/jonathan)

## Usage
  ```
  app/ GET => "CUTE CRUD API!" | just root of the app
  ```
### Create: 
  ```curl
  app/create PUT {creator: "LappeeLy", text: "Cute cute cute lily!"} 
  => {id: "", text: "", creator: ""} | will create note of this text and creator
  ```
  
### Read:
  ```curl
  app/read/<note-id> GET => give you a note of this id or []
  app/read/all       GET => give you a list of all notes in DB
  ```
  
### Update:
  ```curl
  app/update PATCH {id: "<updated-note-id>", text: "<text-for-update>"}
  => {status: "OK"} | will update text of note with selected id 
  ```
  
### Delete:
  ```curl
  app/delete DELETE {id: "<updated-note-id>"}
  => {status: "OK"} | will delete note of picked id
  ```
  
## How to run?
In project folder open the repl and run following commands: 
``` common-lisp
> (ql:quickload :crud)
> (crud:main <port>)
```
