;; MAC ONLY 

;; don't have emacs open a file in each frame
;; when running emacs file1 file2 file3 on the commandline
(setq ns-pop-up-frames nil)

;; cmd is the new meta
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(provide 'mac)
