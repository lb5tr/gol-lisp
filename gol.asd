(defpackage #:gol
  (:use :cl :asdf)
  (:export "create-world"))

(in-package :gol)

(push "/home/kubov/code/gol/" asdf:*central-registry*)

(defsystem gol
  :name "gol"
  :version "0.0.0"
  :maintainer "Jakub Kubiak"
  :author "Jakub Kubiak"
  :serial t
  :components ((:file "functions")))

(asdf:operate 'asdf:load-op 'gol)
