(require 'racket-mode)
(add-hook 'racket-mode-hook  #'enable-paredit-mode)
(add-hook 'racket-repl-mode-hook  #'enable-paredit-mode)
(add-hook 'racket-mode-hook  #'parinfer-mode)
(add-hook 'racket-repl-mode-hook  #'parinfer-mode)

(provide 'lang-racket)
