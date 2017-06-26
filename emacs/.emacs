;;; .emacs-custom.el --- customisations
;; This is your default customistions file.
;; The emacs customize interace will append to this file.

;;; Commentary:
;; Here are some handy functions:
;; (standard-display-ascii ?\t "^I")  ;; show tabs
;; (setq-default indent-tabs-mode nil)   ;; turn off tabs
;;

;;; Code:


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(eval-when-compile
  (require 'use-package))

(setq custom-theme-directory (locate-user-emacs-file "themes"))
(setq diary-file "/Users/prezoladesigner/Sync/diary")

(ido-mode t)
(exec-path-from-shell-initialize)
(global-flycheck-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'python-mode-hook '(lambda ()
          (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'sgml-mode-hook '(lambda ()
(define-key
         sgml-mode-map
         (kbd "RET") 'newline-and-indent)))
(global-set-key (kbd "C-x r r") 'revert-buffer)
(global-set-key (kbd "<kp-3>") 'call-last-kbd-macro)

;; Turn off UI clutter
(mapc #'apply `((menu-bar-mode -1) (tool-bar-mode -1) (scroll-bar-mode -1)))

;; Misc settings.
(setq-default indent-line-function 'insert-tab)
(setq indent-tabs-mode nil)
(setq tab-always-indent nil)

;; Scrolling - do not add newlines when cursoring past last line in file
(setq scroll-step 1)
(setq next-line-add-newlines nil)

;; Display
(global-linum-mode 0)
(setq transient-mark-mode t)
(setq column-number-mode t)
(setq inhibit-startup-message t)
(setq search-highlight t)
(setq query-replace-highlight t)

;; Annoyance factor
(fset 'yes-or-no-p 'y-or-n-p)
(setq redisplay-dont-pause t)
(setq font-lock-verbose nil)
(setq confirm-nonexistent-file-or-buffer nil)

;; Un-disable some 'dangerous!' commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;(define-key netsight-keymap (kbd "C-x p") 'netsight-other-window-back)
;; (define-key netsight-keymap (kbd "M-d") 'kill-word)
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)
(setq diary-european-date-forms t)

(use-package emacs-lisp-mode
  :mode (("*scratch*" . emacs-lisp-mode)
	 ("\\.el$" . emacs-lisp-mode)))

(use-package flycheck
  :bind ("<kp-7>" . flycheck-next-error)
  :preface
  (declare-function flycheck-next-error flycheck nil)
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
  (fringe-mode (quote (4 . 0)))
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (setq flycheck-python-flake8-executable "flake8")
  (setq flycheck-flake8-maximum-line-length 79)
  (setq flycheck-highlighting-mode 'lines))

(use-package sgml-mode
  :config
  (setq sgml-basic-offset 4)
  (add-hook 'sgml-mode-hook
	    (lambda ()
	      (setq indent-tabs-mode nil)))
  :mode (("\\.pt$" . sgml-mode)
         ("\\.cpt$" . sgml-mode)
         ("\\.html" . sgml-mode)
         ("\\.htm" . sgml-mode)))

(use-package nxml-mode
  :mode (("\\.xml$" . nxml-mode)
         ("\\.zcml$" . nxml-mode))
  :config
  (add-hook 'nxml-mode-hook
	    (lambda ()
	      (setq indent-tabs-mode nil))))

(defun py-insert-debug ()
  "Insert python debug commands.
Quick-Insert python debug mode."
  (interactive)
  (declare-function python-nav-end-of-statement python nil)
  (let ((pdb-text "import pdb; pdb.set_trace()"))
    (python-nav-end-of-statement)
    (newline-and-indent)
    (insert pdb-text)))

(use-package python
  :bind (("<kp-5>" . py-insert-debug)
         ("<f9>" . py-insert-debug))
  :mode (("\\.py$" . python-mode)
         ("\\.cpy$" . python-mode)
         ("\\.vpy$" . python-mode))
  :config
  (declare-function py-insert-debug netsight nil)
  (setq fill-column 79)
  (setq-default flycheck-flake8rc "~/.config/flake8rc")
  (setq python-check-command "flake8")
  (setq tab-width 4))

;; some custom functions

(defun cheej-ide-mode ()
  "Set up 2 column layout fullscreen."
  (interactive)
  (split-window-horizontally)
  (toggle-fullscreen))


;; open prezola github
(defun prezola-github ()
  (interactive)
  (call-process "open" nil 0 nil "https://github.com/prezola/prezola")
)

;; search github
(defun github-search (url)
  (interactive "sSearch for: ")
  (call-process "open" nil 0 nil (concat "http://github.com/search?q=" url))
  )

;; open github
(defun open-github (org project)
  "Open a github project page.  ORG - organisation PROJECT - the actual project."
  (interactive "sOrganisation: \nsProject: ")
  (call-process "open" nil 0 nil (concat "http://github.com/" org "/" project))
  )

;; Toggle full screen
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(defun buffer-name-to-clipboard ()
  "Put the current buffer name on the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))


;; twitter
(setq twittering-use-master-password t)


;;; .emacs-custom.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit flymake flycheck-color-mode-line flymake-python-pyflakes flycheck use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
