;;; elisp-tutorial.el --- An Interactive Introduction to Emacs Lisp -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Welcome to the Elisp Tutorial!
;;
;; This is an interactive tutorial that will teach you Emacs Lisp (Elisp)
;; through hands-on examples. Like the Emacs tutorial, you'll learn by
;; doing.
;;
;; HOW TO USE THIS TUTORIAL:
;; 1. Open this file in Emacs
;; 2. Read the instructions carefully
;; 3. Try the examples by placing your cursor after expressions and pressing C-x C-e
;; 4. Experiment! Break things! That's how you learn!
;;
;; Throughout this tutorial, you'll see expressions like this:
;;   (+ 2 3)
;; Place your cursor right after the closing parenthesis and press C-x C-e
;; to evaluate it. The result will appear in the minibuffer at the bottom.
;;
;; Ready? Let's begin!

;;; Code:

;; ============================================================================
;; LESSON 1: Your First Elisp Expression
;; ============================================================================

;; In Elisp, everything is an expression that returns a value.
;; The most basic expressions are just values themselves.

;; Try evaluating each of these (cursor after, then C-x C-e):

42                              ; A number
"Hello, Elisp!"                 ; A string
'symbol                         ; A symbol (note the quote)
t                              ; True
nil                            ; False (and also empty list)

;; Elisp uses prefix notation (operator first).
;; Try this:
(+ 2 3)

;; What happened? You should see 5 in the minibuffer!
;; Now try:
(* 4 5)
(- 10 3)
(/ 15 3)

;; You can nest expressions:
(+ 1 (* 2 3))

;; EXERCISE 1: Calculate (4 + 5) * 3
;; Write your answer here:


;; ============================================================================
;; LESSON 2: Variables and Binding
;; ============================================================================

;; Let's create some variables. In Elisp, we use 'setq' for global variables:

(setq my-name "Elisp Learner")
(setq my-age 25)

;; Now evaluate the variable names to see their values:
my-name
my-age

;; You can use variables in expressions:
(setq greeting (concat "Hello, " my-name "!"))
greeting

;; For local variables, we use 'let':
(let ((x 10)
      (y 20))
  (+ x y))

;; The variables x and y only exist inside the let block.
;; Try evaluating this to see they don't exist outside:
;; x  ; This will cause an error! (Uncomment to try)

;; You can also use let*:
(let* ((a 5)
       (b (* a 2)))  ; b can reference a because we used let*
  (+ a b))

;; EXERCISE 2: Create a let binding with your favorite number
;; and calculate its square
;; Write your answer here:


;; ============================================================================
;; LESSON 3: Functions - The Heart of Elisp
;; ============================================================================

;; Functions are created with 'defun':

(defun say-hello ()
  "Say hello to the world."
  (message "Hello, World!"))

;; Call it:
(say-hello)

;; Functions can take arguments:
(defun greet (name)
  "Greet someone by NAME."
  (message "Hello, %s!" name))

(greet "Emacs User")

;; Functions return the value of their last expression:
(defun add-ten (n)
  "Add 10 to N."
  (+ n 10))

(add-ten 5)

;; You can have multiple parameters:
(defun calculate-area (width height)
  "Calculate area of a rectangle with WIDTH and HEIGHT."
  (* width height))

(calculate-area 4 5)

;; Functions can have optional parameters:
(defun greet-formally (name &optional title)
  "Greet NAME with optional TITLE."
  (if title
      (message "Hello, %s %s!" title name)
    (message "Hello, %s!" name)))

(greet-formally "Smith")
(greet-formally "Smith" "Dr.")

;; EXERCISE 3: Write a function that takes two numbers
;; and returns the larger one
;; Write your answer here:


;; ============================================================================
;; LESSON 4: Lists - The Foundation of Lisp
;; ============================================================================

;; Lists are fundamental in Lisp (LISt Processing)

;; Create a list with 'list' or quote it:
(setq my-list '(1 2 3 4 5))
(setq another-list (list 'a 'b 'c))

;; Access elements:
(car my-list)                   ; First element (Contents of Address Register)
(cdr my-list)                   ; Rest of list (Contents of Decrement Register)
(cadr my-list)                  ; Second element (car of cdr)
(nth 2 my-list)                 ; Third element (0-indexed)

;; Build lists:
(cons 0 my-list)                ; Add to front
(append my-list '(6 7))         ; Combine lists

;; Check list properties:
(length my-list)
(member 3 my-list)              ; Returns sublist starting with 3 if found

;; Process lists with mapcar:
(mapcar (lambda (x) (* x 2)) my-list)

;; Filter lists:
(seq-filter (lambda (x) (> x 2)) my-list)

;; EXERCISE 4: Create a list of your favorite fruits and
;; use mapcar to uppercase them all
;; Hint: use the 'upcase' function
;; Write your answer here:


;; ============================================================================
;; LESSON 5: Conditionals and Control Flow
;; ============================================================================

;; The basic conditional is 'if':
(if (> 5 3)
    "5 is greater"
  "5 is not greater")

;; For multiple conditions, use 'cond':
(setq temperature 75)

(cond ((< temperature 32) "Freezing!")
      ((< temperature 60) "Cold")
      ((< temperature 80) "Nice")
      (t "Hot!"))                ; t is the default case

;; 'when' is like if with no else clause:
(when (> temperature 70)
  (message "It's warm!")
  'warm)                         ; Can have multiple expressions

;; 'unless' is the opposite of when:
(unless (< temperature 50)
  'not-cold)

;; Combine conditions with 'and' and 'or':
(and (> 5 3) (< 10 20))         ; Both must be true
(or (> 5 10) (< 10 20))         ; At least one must be true

;; EXERCISE 5: Write a function that takes a number and returns
;; "positive", "negative", or "zero"
;; Write your answer here:


;; ============================================================================
;; LESSON 6: Working with Buffers
;; ============================================================================

;; Buffers are where text lives in Emacs. Let's manipulate them!

;; Get current buffer:
(current-buffer)
(buffer-name)

;; Create a new buffer and switch to it:
(defun tutorial-create-buffer ()
  "Create a tutorial practice buffer."
  (interactive)
  (switch-to-buffer "*Elisp Practice*")
  (erase-buffer)
  (insert "Welcome to your practice buffer!\n")
  (insert "Type something here: "))

;; Try it:
(tutorial-create-buffer)

;; Insert text at point:
(defun insert-timestamp ()
  "Insert current timestamp."
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S")))

;; Move around in buffer:
(defun demo-movement ()
  "Demonstrate buffer movement."
  (interactive)
  (goto-char (point-min))       ; Beginning of buffer
  (forward-line 2)               ; Move down 2 lines
  (end-of-line)                  ; End of current line
  (insert " [I was here!]"))

;; Work with buffer text:
(defun count-words-in-buffer ()
  "Count words in current buffer."
  (interactive)
  (message "Word count: %d" 
           (count-words (point-min) (point-max))))

;; EXERCISE 6: Write a function that inserts your name
;; at the current cursor position
;; Write your answer here:


;; ============================================================================
;; LESSON 7: Interactive Commands
;; ============================================================================

;; Interactive functions can be called with M-x

(defun tutorial-hello-interactive (name)
  "Greet NAME interactively."
  (interactive "sWhat's your name? ")  ; 's' means read a string
  (message "Nice to meet you, %s!" name))

;; Try: M-x tutorial-hello-interactive

;; Different interactive codes:
(defun tutorial-math-interactive (n)
  "Square a number N interactively."
  (interactive "nEnter a number: ")    ; 'n' means read a number
  (message "The square of %d is %d" n (* n n)))

;; Work with regions:
(defun tutorial-uppercase-region (start end)
  "Uppercase the selected region."
  (interactive "r")                    ; 'r' means use region
  (upcase-region start end))

;; Multiple arguments:
(defun tutorial-repeat-string (str n)
  "Repeat STR N times."
  (interactive "sString to repeat: \nnHow many times? ")
  (dotimes (_ n)
    (insert str)))

;; Add keyboard shortcuts:
(defun tutorial-insert-date ()
  "Insert today's date."
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

;; Bind it to a key (uncomment to activate):
;; (global-set-key (kbd "C-c d") 'tutorial-insert-date)

;; EXERCISE 7: Create an interactive function that asks for
;; your favorite color and displays it
;; Write your answer here:


;; ============================================================================
;; LESSON 8: Hooks and Advice
;; ============================================================================

;; Hooks let you run code when events happen:

(defun tutorial-startup-message ()
  "Show a startup message."
  (message "Welcome to Emacs! Today is %s" 
           (format-time-string "%A")))

;; Add to a hook (uncomment to activate):
;; (add-hook 'emacs-startup-hook 'tutorial-startup-message)

;; Mode-specific hooks:
(defun tutorial-prog-mode-setup ()
  "Setup for programming modes."
  (show-paren-mode 1)           ; Highlight matching parens
  (electric-pair-mode 1))       ; Auto-insert closing parens

;; Add to programming mode hook:
;; (add-hook 'prog-mode-hook 'tutorial-prog-mode-setup)

;; Advice lets you modify existing functions:
(defun tutorial-advice-save (orig-fun &rest args)
  "Advice to run before saving."
  (message "Saving file...")
  (apply orig-fun args)
  (message "File saved!"))

;; Add advice (uncomment to activate):
;; (advice-add 'save-buffer :around #'tutorial-advice-save)

;; Remove advice:
;; (advice-remove 'save-buffer #'tutorial-advice-save)

;; EXERCISE 8: Create a hook function that displays
;; "Good coding!" when entering a programming mode
;; Write your answer here:


;; ============================================================================
;; LESSON 9: Regular Expressions and Text Processing
;; ============================================================================

;; Elisp has powerful regex support:

;; Search for patterns:
(defun tutorial-find-emails ()
  "Find all email addresses in buffer."
  (interactive)
  (let ((emails '()))
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward 
              "\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}\\b" 
              nil t)
        (push (match-string 0) emails)))
    (message "Found emails: %s" emails)))

;; Replace text:
(defun tutorial-replace-placeholder (placeholder replacement)
  "Replace PLACEHOLDER with REPLACEMENT in buffer."
  (interactive "sPlaceholder: \nsReplacement: ")
  (save-excursion
    (goto-char (point-min))
    (while (search-forward placeholder nil t)
      (replace-match replacement))))

;; Work with matches:
(when (string-match "\\([0-9]+\\)" "I have 42 apples")
  (match-string 1 "I have 42 apples"))  ; Returns "42"

;; EXERCISE 9: Write a function that counts how many times
;; the word "the" appears in the current buffer
;; Write your answer here:


;; ============================================================================
;; LESSON 10: Final Project - Build Your Own Command
;; ============================================================================

;; Let's build something useful! A function to create a simple todo list:

(defvar tutorial-todos '()
  "List of todo items.")

(defun tutorial-add-todo (item)
  "Add ITEM to todo list."
  (interactive "sWhat do you need to do? ")
  (push item tutorial-todos)
  (message "Added: %s" item))

(defun tutorial-show-todos ()
  "Display all todos."
  (interactive)
  (if tutorial-todos
      (with-output-to-temp-buffer "*My Todos*"
        (princ "Your TODO List:\n")
        (princ "==============\n\n")
        (dolist (item (reverse tutorial-todos))
          (princ (format "[ ] %s\n" item))))
    (message "No todos yet! Use tutorial-add-todo to add some.")))

(defun tutorial-clear-todos ()
  "Clear all todos."
  (interactive)
  (when (yes-or-no-p "Clear all todos? ")
    (setq tutorial-todos '())
    (message "All todos cleared!")))

;; Try it out:
;; 1. M-x tutorial-add-todo (add a few items)
;; 2. M-x tutorial-show-todos
;; 3. M-x tutorial-clear-todos

;; FINAL EXERCISE: Enhance the todo system!
;; Ideas:
;; - Add priority levels
;; - Save todos to a file
;; - Mark todos as complete
;; - Add due dates
;; Write your enhancement here:


;; ============================================================================
;; CONGRATULATIONS!
;; ============================================================================

;; You've completed the Elisp Tutorial! You now know:
;; - Basic Elisp syntax and evaluation
;; - Variables and functions
;; - Lists and list processing
;; - Control flow
;; - Buffer manipulation
;; - Interactive commands
;; - Hooks and advice
;; - Text processing
;;
;; Where to go from here:
;; 1. Read the Emacs Lisp Reference Manual: C-h i m Elisp RET
;; 2. Explore existing packages: M-x list-packages
;; 3. Start customizing your init.el file
;; 4. Build your own packages!
;;
;; Remember: The best way to learn is by doing. 
;; Keep experimenting and have fun with Elisp!

;; Pro tip: Use C-h f to describe any function
;; Use C-h v to describe any variable
;; Use C-h k to describe any key binding

;;; elisp-tutorial.el ends here