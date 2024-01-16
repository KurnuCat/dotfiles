;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Install use-package because that installs everything else
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Enable deferred compilation
(setq comp-deferred-compilation t)

; Turn off some unneeded UI elements
(menu-bar-mode -1)  ; Leave this one on if you're a beginner!
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1) ;; Display line numbers in every buffer
(load-theme 'deeper-blue t) ;; theme

;; doc-viewer
(use-package doc-view
  :ensure t
  )

;; writeroom-mode
(use-package writeroom-mode
  :ensure t
  :config
  (add-hook 'markdown-mode-hook 'writeroom-mode))

(use-package rainbow-mode
  :ensure t
  :hook
  (html-mode-hook . rainbow-mode)
  (css-mode-hook . rainbow-mode)
  (js-mode-hook . rainbow-mode))

(setq pdf-viewer "zathura")

;; project.el
(use-package project
  :ensure t)

;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (setq dashboard-banner-logo-title "Welcome to Moisio Emacs!")
  (setq dashboard-startup-banner 1)
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents  . 5)
                          (bookmarks . 5)
                          (projects . 5)
                          (agenda . 5)
                          (registers . 5)))

  (setq dashboard-show-shortcuts t)
  (dashboard-setup-startup-hook))

;; Value can be 1, 2, 3 or nil
;; - nil to display no banner
;; - 'official which displays the official emacs logo
;; - 'logo which displays an alternative emacs logo
;; - 1, 2 or 3 which displays one of the text banners
;; - "path/to/your/image.gif", "path/to/your/image.png", "path/to/your/text.txt" or "path/to/your/image.xbm" which displays whatever gif/image/text/xbm you would prefer
;; - a cons of '("path/to/your/image.png" . "path/to/your/text.txt")

;; Download Evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package move-text
  :ensure t)

(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state))

;; Company mode
(use-package company
  :ensure t
  :config
  (global-company-mode t))

;; icomplete, an out of the box alternative for ivy or helm
(use-package icomplete
  :ensure t
  :config
  (icomplete-mode t))

;; Ranger.el
(use-package ranger
  :ensure t)

;; org-mode
(use-package org
  :ensure t
  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture)))

(setq org-agenda-files '("~/sync/org")) ;; org-agenda files

;; Define custom agenda views
(setq org-agenda-custom-commands
      '(("s" "Saved agenda view" tags "+CATEGORY=\"Saved\""
         ((agenda "")
          (alltodo "")))))

;; Set agenda start day to today
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-start-day nil)

(use-package org-modern
  :ensure t
  :config
  (add-hook 'org-mode-hook 'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook 'org-modern-mode))

;; Markdown mode
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :mode ("\\.md\\'" . markdown-mode)
  :init (setq markdown-command "multimarkdown"))

;; Eglot, more minimal alternative to lsp-mode that is included with newer versions of emacs
(use-package eglot
  :ensure t
  :hook
  ((python-mode-hook . eglot-ensure)
   (html-mode-hook . eglot-ensure)
   (css-mode-hook . eglot-ensure)
   (js-mode-hook . eglot-ensure)
   (sh-mode-hook . eglot-ensure)
   (markdown-mode-hook . eglot-ensure)))

;; Treemacs
(use-package treemacs
  :ensure t)

(use-package treemacs-evil
  :ensure t)

;; Rainbow-delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode-hook . rainbow-delimiters-mode))

;; Electric-pairs
(add-hook 'prog-mode-hook 'electric-pair-mode)

 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(icomplete-mode t)
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(evil-surround move-text rainbow-mode writeroom-mode treemacs-evil key-chord markdown-mode dashboard rainbow-delimiters eglot image-dired+ magit evil-collection ranger treemacs ## company org-modern evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
