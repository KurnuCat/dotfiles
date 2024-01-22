;; Performance --------------------------------------------------------------------------------

(setq gc-cons-threshold most-positive-fixnum) ; Minimize garbage collection during startup

(setq comp-deferred-compilation t)            ; Enable Deferred compilation

;; Package manager configuration --------------------------------------------------------------

;; Initialize package sources
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Install use-package because that installs everything else
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(setq use-package-always-ensure t) ; Always ensure packages

;; Performance --------------------------------------------------------------------------------

(setq comp-deferred-compilation t) ; Enable Deferred compilation

;; Basic UI configuration ---------------------------------------------------------------------

(setq visible-bell t)  ; Set up the visible bell

(tool-bar-mode -1)     ; Disable the toolbar
(scroll-bar-mode -1)   ; Disable visible scrollbar
(tooltip-mode -1)      ; Disable tooltips
(set-fringe-mode 10)   ; Give some breathing room

(menu-bar-mode -1)     ; Disable the menu bar

(global-display-line-numbers-mode 1) ; Display line numbers in every buffer
(load-theme 'manoj-dark t)           ; theme

;; Font configuration --------------------------------------------------------------------------

(set-face-attribute 'default nil :height 125)                   ; Set font size
(set-face-attribute 'default nil :font "Monospace" :height 120) ; Set the font

;; Packages and package configuration ----------------------------------------------------------

;; ---------- evil-mode related stuff ----------

;; Download Evil and related packages
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :config
  (evil-collection-init))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :config
  (evil-commentary-mode 1))

(use-package key-chord
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state))

;; ---------- Programming, project management, version control and autocompletion ----------

;; Company mode
(use-package company
  :config
  (global-company-mode t))

;; Eglot, more minimal alternative to lsp-mode that is included with newer versions of emacs
(use-package eglot
  :hook
  ((python-mode-hook . eglot-ensure)
   (html-mode-hook . eglot-ensure)
   (css-mode-hook . eglot-ensure)
   (js-mode-hook . eglot-ensure)
   (sh-mode-hook . eglot-ensure)
   (markdown-mode-hook . eglot-ensure)))

(use-package magit)      ; magit 

(use-package project)    ; Built-in alternative to projectile.el

;; Treemacs
(use-package treemacs)
(use-package treemacs-evil)

;; Rainbow-delimiters
(use-package rainbow-delimiters
  :hook (prog-mode-hook . rainbow-delimiters-mode))

(add-hook 'prog-mode-hook 'electric-pair-mode) ; autopairs in programming modes with the built-in electric-pairs

;; rainbow-mode for CSS
(use-package rainbow-mode
  :hook
  (html-mode-hook . rainbow-mode)
  (css-mode-hook . rainbow-mode)
  (js-mode-hook . rainbow-mode))

;; icomplete, an out of the box alternative for ivy or helm
(use-package icomplete
  :config
  (icomplete-mode t))

;; ---------- File, document management and work ----------

;; dired
(use-package dired
  :ensure nil
  :hook
  (dired-mode . evil-local-mode)
  :config
  (evil-define-key 'normal dired-mode-map "l" 'dired-find-alternate-file)
  (evil-define-key 'normal dired-mode-map "h" 'dired-up-directory))
(use-package image-dired+)

;; Open videos with mpv
(defun open-in-mpv ()
  (interactive)
  (let ((file (dired-get-filename)))
    (start-process "mpv" nil "mpv" file)))
(eval-after-load "dired"
  '(define-key dired-mode-map (kbd "C-c C-o") 'open-in-mpv))

;; markdown-mode
(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :mode ("\\.md\\'" . markdown-mode)
  :init (setq markdown-command "multimarkdown"))

;; doc-viewer
(use-package doc-view)
(setq doc-view-continuous t) ; continuous scrolling of pdf documents
(setq pdf-viewer "zathura")  ; set the pdf viewer to zathura 

;; writeroom-mode
(use-package writeroom-mode
  :config
  :hook
  (markdown-mode-hook . writeroom-mode)
  (org-mode . writeroom-mode))

;; auctex
(use-package auctex
  :config
  (setq TeX-view-program-list '(("zathura" "zathura %o")))
  (setq TeX-view-program-selection '((output-pdf "zathura"))))

;; ---------- org related stuff ----------

;; org 
(use-package org
  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture)))

(setq org-agenda-files '("~/sync/org")) ;; org-agenda file path

;; Define custom agenda views
(setq org-agenda-custom-commands
      '(("s" "Saved agenda view" tags "+CATEGORY=\"Saved\""
         ((agenda "")
          (alltodo "")))))

;; Set agenda start day to today
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-start-day 0)

;; org-mode theme
(use-package org-modern
  :hook
  ('org-mode . org-modern-mode)) 

;; ---------- Other packages ----------

;; which-key
(use-package which-key
  :config
  (which-key-mode))

;; For moving text
(use-package move-text
  :config
  (global-set-key (kbd "M-k")   'move-text-up)
  (global-set-key (kbd "M-j") 'move-text-down))

;; Dashboard
(use-package dashboard
  :config
  (setq dashboard-banner-logo-title "Welcome to Moisio Emacs!")
  (setq dashboard-startup-banner 1)
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents  . 5)
                          (bookmarks . 5)
                          (projects . 5)
                          (agenda . 5)))
  (setq dashboard-projects-backend 'project-el)

  (setq dashboard-show-shortcuts t)
  (dashboard-setup-startup-hook))
;; Value can be 1, 2, 3 or nil
;; - nil to display no banner
;; - 'official which displays the official emacs logo
;; - 'logo which displays an alternative emacs logo
;; - 1, 2 or 3 which displays one of the text banners
;; - "path/to/your/image.gif", "path/to/your/image.png", "path/to/your/text.txt" or "path/to/your/image.xbm" which displays whatever gif/image/text/xbm you would prefer
;; - a cons of '("path/to/your/image.png" . "path/to/your/text.txt")


;; Performance --------------------------------------------------------------

;; lower threshold back to 0 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold (expt 2 23))))
 
;; custom -------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(icomplete-mode t)
 '(ispell-dictionary nil)
 '(org-agenda-files nil)
 '(package-selected-packages
   '(org-modern which-key evil-commentary auctex evil-surround move-text rainbow-mode writeroom-mode treemacs-evil key-chord markdown-mode dashboard rainbow-delimiters eglot image-dired+ magit evil-collection treemacs ## company evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
