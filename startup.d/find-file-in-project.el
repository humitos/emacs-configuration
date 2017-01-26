;; this is a requirement for elpy, but I'm not using it now
(require 'find-file-in-project)
(setq ffip-find-options "-not -iwholename '*~' -not -iwholename '*.pyc' -not -iwholename '*flymake*' -not -iwholename '*#' -not -iwholename '*.git/*'")
