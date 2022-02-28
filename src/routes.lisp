(in-package :cl-user)
(defpackage crud.routes
  (:use :cl
        :ningle
        :log4cl
        :crud.db
        :crud.models
        :jonathan)
  (:export :*app*))
(in-package :crud.routes)

(defvar *app*  (make-instance 'ningle:<app>))

(defmethod %to-json ((crud.models:note note))
  (with-object 
    (write-key-value "id"      (slot-value note 'MITO.DAO.MIXIN::id))
    (write-key-value "text"    (slot-value note 'CRUD.MODELS::note-text))
    (write-key-value "creator" (slot-value note 'CRUD.MODELS::creator-name))))

(defun get-by-assoc (param where)
  (cdr (assoc param where :test #'string=)))

(setf (ningle:route *app* "/") 
  ; app/ GET => "CUTE CRUD API!" | just root of the app
  (progn (log:info "Request on address /")
  "CUTE CRUD API!"))

(setf (ningle:route *app* "/create" :method :PUT) 
      ; app/create PUT {creator: "LappeeLy", text: "Cute cute cute lily!"} 
      ; => {id: "", text: "", creator: ""} | will create note of this text and creator
      #'(lambda (params)
          (progn (log:info "On /create: " params)
            (let* ((text    (get-by-assoc "text"    params))
                   (creator (get-by-assoc "creator" params))
                   (db-response (crud.db:add-note text creator)))
                     (to-json db-response)))))

(setf (ningle:route *app* "/read/:id" :method :GET)
      ; app/read/<note-id> GET => give you a note of this id or []
      ; app/read/all       GET => give you a list of all notes in DB
      #'(lambda (params) 
          (progn (log:info "On /read: " params)
            (let* ((id (get-by-assoc :id params))
                   (all-json-notes (mapcar #'to-json (get-all)))
                   (json-array (mapcar #'parse all-json-notes)))
              (if (string= id "all") (jonathan:to-json json-array)
                (to-json (find-note (parse-integer id))))))))

(setf (ningle:route *app* "/update" :method :PATCH)
      ; app/update PATCH {id: "<updated-note-id>", text: "<text-for-update>"}
      ; => {status: "OK"} | will update text of note with selected id 
      #'(lambda (params)
          (progn (log:info "On /update: " params)
            (let* ((id (get-by-assoc "id" params))
                   (text (get-by-assoc "text" params)))
              (crud.db:update-note-text id text))
            (jonathan:to-json (list :|status| "OK")))))

(setf (ningle:route *app* "/delete" :method :DELETE)
      ; app/delete DELETE {id: "<updated-note-id>"}
      ; => {status: "OK"} | will delete note of picked id
      #'(lambda (params) 
          (progn (log:info "On /delete: " params)
            (crud.db:remove-note (get-by-assoc "id" params))
                  (jonathan:to-json (list :|status| "OK")))))

