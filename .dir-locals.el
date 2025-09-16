((java-mode
  (c-basic-offset . 2)
  (indent-tabs-mode . nil)
  (eval . (progn
            (require 'lsp-java)
            (lsp)))))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package flycheck-javac
  :ensure t
  :after flycheck
  :hook (java-mode . flycheck-mode))

