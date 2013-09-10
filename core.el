;; Start emacsserver for emacsclient
(server-start)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mac preferences
(require 'mac)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Bar Cursor configuration (I don't like the box cursor)
(require 'bar-cursor)
(bar-cursor-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Specify a new place to store temp files to avoid cluttering up your workspace
(require 'temp-files)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Keyboard shortcuts
(global-set-key "\C-c;" 'comment-region)
(global-set-key "\C-c'" 'uncomment-region)
(global-set-key "\C-x\C-a" 'find-file-at-point)
(global-set-key [(control shift ?s)] 'list-matching-lines)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; custom-set-variables
;;
;; These were variables once set by custom set variables.
;; Now these are "defaults" that will be used unless you customize
;; your own.

(setq column-number-mode t)
(setq delete-selection-mode t)
(setq global-whitespace-mode t)
(setq global-hl-line-mode nil)
(setq erc-modules
      (quote
       (autojoin button completion fill irccontrols
                 list match menu move-to-prompt netsplit
                 networks noncommands readonly ring services stamp track)))
(setq indent-tabs-mode nil)
(setq inhibit-startup-screen t)
(setq save-place t nil (saveplace))
(setq scroll-bar-mode (quote right))
;;
;; show me what I'm marking
;;
(setq show-paren-mode t)
(setq size-indication-mode t)
(setq text-mode-hook (quote (text-mode-hook-identify)))
;;
;; show me what I'm marking
;;
(setq transient-mark-mode t)
(setq visible-cursor t)
;; enables the indication of whitespace
(setq global-whitespace-mode t)
(setq whitespace-style
      ;; turn off showing the following characters
      (quote
       (face tabs trailing line space-before-tab
             newline empty space-after-tab tab-mark)))
;;
;; iswitchb = makes C-x b awesome
;;
(iswitchb-mode 1)
;;
;; C-c left undoes window config changes
;;
(winner-mode)
;;
;; Change windows with S-<arrow>
;;
(windmove-default-keybindings)
;;
;; line wrapping
;;
(setq truncate-partial-width-windows nil)
;;
;; show colored ls output in shell
;;
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;
;; visible bell
;;
(setq visible-bell t)
;; allows you to do M-x erase-buffer, but
;; if your buffer is too big, undo won't bring
;; it back
(put 'erase-buffer 'disabled nil)
;;
;; Avoids jerky scrolling when using a mouse wheel
;; so you don't lose your place as you scroll
;;
(setq scroll-step 1)
(put 'narrow-to-region 'disabled nil)
(setq cursor '((t nil)))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Frame Transparency
;;
;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
;; example:
;; (set-frame-parameter (selected-frame) 'alpha '(95 80))
;; (add-to-list 'default-frame-alist '(alpha 95 80))
(eval-when-compile (require 'cl))
(defun toggle-transparency ()
  (interactive)
  (if (/= (cadr (frame-parameter nil 'alpha)) 100)
      (set-frame-parameter nil 'alpha '(95 100))
    (set-frame-parameter nil 'alpha '(85 80))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

;;
;; hide passwords in the shell
;;
(defvar comint-password-prompt-regexp "\\(\\([Oo]ld \\|[Nn]ew \\|'s \\|login \\|Kerberos \\|CVS \\|UNIX \\| SMB \\|^\\|Enter \\)[Pp]assword\\( (again)\\)?\\|pass phrase\\|\\(Enter\\|Repeat\\|Bad\\) passphrase\\)\\(?:, try again\\)?\\(?: for [^:]+\\)?:\\s *\\'")
;; stop shell from echoing commands
(defun my-comint-init ()
  (setq comint-process-echoes t))
(add-hook 'comint-mode-hook 'my-comint-init 'comint-watch-for-password-prompt)
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Macros
;;; Set up a three column window
(fset 'three-column-disp
   [?\C-x ?1 ?\C-x ?3 ?\C-x ?3 ?\M-x ?b ?a ?l ?a tab return ?\C-x ?2 ?\C-x ?o ?\C-x ?o ?\C-x ?o ?\C-x ?2])
(global-set-key (kbd "C-c 3") 'three-column-disp)
(fset 'two-one-one
   [?\C-x ?1 ?\C-x ?3 ?\C-x ?3 ?\M-x ?b ?a ?l ?a ?n ?c ?e ?- tab return ?\C-x ?2])
(global-set-key (kbd "C-c 2") 'two-one-one)
(fset 'two-one
   "\C-x1\C-x3\C-x2")
(global-set-key (kbd "C-c 1") 'two-one)
(put 'three-column-disp 'kmacro t)
(put 'two-one-one 'kmacro t)
(put 'two-one 'kmacro t)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Editor identity reminders.  (try ESC : wq<RET>)
(setq w   "This is not vi, you klutz!")
(setq q   "vi is THAT OTHER editor, not THIS ONE.")
(setq w!  "This is not vi!  Don't do that!")
(setq q!  "That command wou¯ld be great if you were in vi.")
(setq wq  "This is not vi, dumbass!")
(setq wq! "This is EMACS you sleepyhead, not vi!")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; dired

;;; Load Dired-x when Dired is loaded.
(add-hook 'dired-load-hook '(lambda () (require 'dired-x)))

;; Enable toggling of uninteresting files.
(setq dired-omit-files-p t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; git
;; From https://github.com/tsgates/git-emacs
(require 'vc-git)
(add-to-list 'load-path (concat (getenv "HOME") "/.emacs.d/git-emacs"))
(require 'git-emacs)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; HTML

;;; Use html-helper-mode (not PSGML!)
(add-to-list 'auto-mode-alist '("\\.html?$" . html-mode))

;;; jsp
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . html-mode))

;;; javascript
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SQL
(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (rename-buffer (concat "*SQL:" sql-user "@" sql-database "*"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Java
(modify-coding-system-alist 'file "\\.java\\'" 'utf-8)
(modify-coding-system-alist 'file "\\.properties\\'" 'utf-8)
(modify-coding-system-alist 'file "\\.scm\\'" 'utf-8)
(modify-coding-system-alist 'file "\\.jsp\\'" 'utf-8)
(modify-coding-system-alist 'file "\\.js\\'" 'utf-8)






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lisp Support

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If you have            (foo (bar baz))
;; Placing the cursor here    ^
;; and calling `remove-outer-expression` yields (bar baz)
(setq remove-outer-expression
   [?\C-\M-k right C-M-left ?\C-y ?\C-\M-k])
(global-set-key "\C-x\C-l" remove-outer-expression)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Scheme
(require 'scheme-indent)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Clojure
(require 'clojure-mode)


(setq compile-command "lein jar")

;; To get syntax highlighting in your repl buffer, use this elisp:
(add-hook 'slime-repl-mode-hook
          (defun clojure-mode-slime-font-lock ()
            (require 'clojure-mode)
            (let (font-lock-mode)
              (clojure-mode-font-lock-setup))))

;;; Compojure formatting
(define-clojure-indent
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PHP
;; php mode sucks. Pretty much.
(require 'php-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Color Theme

(add-to-list 'load-path (expand-file-name "~/.emacs.d/color-theme-6.6.0"))
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     ;; set the color theme here
     ;; to change it on the fly, M-x color-theme-<tab> for the list
     ;; (color-theme-standard) is the same as saying "nothing"
     (color-theme-hober)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Markdown mode
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md$" . gfm-mode))
(add-hook 'gfm-mode-hook 'turn-on-auto-fill)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; YAML mode
(add-to-list 'load-path (expand-file-name "./yaml-mode"))
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Packages for Emacs
;;; You can make use of this by doing `M-x package-install [RET] nrepl [RET]`
;;; You can update your package list by `M-x package-refresh-contents [RET]`
;;;
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; nREPL
;;;
;;; Some additional configuration options as prescribed here:
;;; https://github.com/kingtim/nrepl.el
(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Ruby
;;;
;;; From emacs starter kit24 for ruby
(eval-after-load 'ruby-mode
  '(progn
     ;; work around possible elpa bug
     (ignore-errors (require 'ruby-compilation))
     (setq ruby-use-encoding-map nil)
     (add-hook 'ruby-mode-hook 'inf-ruby-keys)
     (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
     (define-key ruby-mode-map (kbd "C-M-h") 'backward-kill-word)
     (define-key ruby-mode-map (kbd "C-c l") "lambda")))

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))

(add-to-list 'completion-ignored-extensions ".rbc")

(defun pcomplete/rake ()
  "Completion rules for the `ssh' command."
  (pcomplete-here (pcmpl-rake-tasks)))

(defun pcmpl-rake-tasks ()
   "Return a list of all the rake tasks defined in the current
projects.  I know this is a hack to put all the logic in the
exec-to-string command, but it works and seems fast"
   (delq nil (mapcar '(lambda(line)
			(if (string-match "rake \\([^ ]+\\)" line) (match-string 1 line)))
		     (split-string (shell-command-to-string "rake -T") "[\n]"))))

(defun rake (task)
  (interactive (list (completing-read "Rake (default: default): "
                                      (pcmpl-rake-tasks))))
  (shell-command-to-string (concat "rake " (if (= 0 (length task)) "default" task))))
