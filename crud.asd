(defsystem "crud"
  :version "0.1.0"
  :author "Lily Appee"
  :license "MIT"
  :depends-on ("mito"
               "ningle"
               "log4cl"
               "clack"
               "jonathan")
  :components ((:module "src"
                :components
                ((:file "models")
                (:file "main" :depends-on ("routes"))
                (:file "routes" :depends-on ("db" "models"))
                (:file "db" :depends-on (models)))))
  :description 
  "My Trying into build simple rest crud in the cutest language of the all universe")
