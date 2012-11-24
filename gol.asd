(in-package :asdf)

(defsystem :gol-sys
  :name "gol"
  :version "0.0.0"
  :maintainer "Jakub Kubiak"
  :author "Jakub Kubiak"
  :serial t
  :depends-on (:hunchentoot :cl-json :cl-who)
  :components (
    (:file "functions")))

