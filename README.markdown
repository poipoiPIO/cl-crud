# Common lisp CRUD  
My trying into JSON CRUD API in Super Cute Language

## Dependences: 
* mito
* ningle
* log4cl
* clack
* jonathan

## Usage
  app/ GET => "CUTE CRUD API!" | just root of the app
### Create: 
  app/create PUT {creator: "LappeeLy", text: "Cute cute cute lily!"} 
  => {id: "", text: "", creator: ""} | will create note of this text and creator
### Read:
  app/read/<note-id> GET => give you a note of this id or []
  app/read/all       GET => give you a list of all notes in DB

### Update:
  app/update PATCH {id: "<updated-note-id>", text: "<text-for-update>"}
  => {status: "OK"} | will update text of note with selected id 

### Delete:
  app/delete DELETE {id: "<updated-note-id>"}
  => {status: "OK"} | will delete note of picked id

## How to run?
In project folder open the repl and run following commands: 
```lisp
  (ql:quickload :crud)
  (crud:main <port>)
```
