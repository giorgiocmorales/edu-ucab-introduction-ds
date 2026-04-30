---
name: problem-set-create
description: Create Canvas-ready problem sets and question banks from lecture material, with instructor-only answer keys and runnable R review scripts aligned to what was taught in class.
---

# Problem Set Create

Use this skill when creating Canvas-ready problem sets, question banks, or
assessment material from lecture materials.

## Goal

Produce assessment-ready content that can be copied into Canvas with minimal
manual cleanup. Keep instructor-only answers, explanations, and validation code
separate from student-facing prompts.

Elaborate coding problems should have corresponding runnable R scripts for
instructor review.

## Artifact Policy

Use these labels consistently:

- script problem set: `.R` assignment scaffold
- rendered problem set: `.qmd` assignment scaffold
- Canvas-ready question bank: instructor-facing assessment content with answer
  keys and validation code
- review script: runnable R code used by the instructor to validate coding
  answers

Tracked source material should live under `problem-sets/`.

Canvas-ready and instructor-only generated outputs should live under
`outputs/problem-sets/` and should not be committed unless the instructor
explicitly asks. GitHub should track source files and reproducible scripts, not
final Canvas exports.

## Core Assessment Philosophy

- Questions must be based on what was actually taught in the lecture material.
- Do not assume students know functions, syntax, or methods that were not
  covered in class.
- If a question requires a new function or operation not explicitly taught, the
  question itself must explicitly introduce it and state how to use it.
- Question banks should be internally consistent in style and difficulty.
- Randomization should not create major difficulty variation across students.
- Questions should reward understanding, not trivia or ambiguous wording.

## Inputs to Gather

Before writing questions, identify and review:

- the target lecture or lectures
- associated handouts
- code examples used in class
- problem-set templates or prior assessments in the repo
- course conventions for wording, notation, and difficulty
- Canvas formatting constraints

If key source material is missing, state clearly what is missing before
proceeding.

## Required Output Types

### 1. True / False Bank

Create a True / False bank with these properties:

- at least 10 to 12 questions in the bank
- the platform will draw 4 questions at random
- easy difficulty
- broad coverage of the lecture material
- questions should collectively cover the full lecture rather than cluster on
  one narrow point

### 2. Multiple-Choice Banks

Create multiple-choice banks with these properties:

- exactly 4 options per question
- medium difficulty
- divide the lecture into isolated subsections
- create one bank per subsection
- at least 3 subsections/banks
- each subsection bank should contain at least 5 questions
- the platform will draw 1 to 2 questions from each bank
- distractors should be plausible but clearly inferior to the correct answer
- avoid trick questions

### 3. Coding Question

Create at least one coding question with these properties:

- use a base R or `dslabs` dataset unless the lecture clearly taught another
  dataset
- require a few lines of code
- require actual reasoning, not just one obvious command
- final answer must be machine-checkable:
  - a number
  - an integer
  - or a precise string
- the question must be solvable using material taught in class
- if a new function is needed, explicitly introduce it in the prompt and explain
  its use briefly
- specify which datasets and packages the student must use to answer the
  question
- include a corresponding runnable R review script for instructor validation

## Alignment Rules

- All questions must be anchored in the lecture material.
- Use the wording, methods, and concepts actually taught in class.
- Do not silently escalate beyond lecture level.
- Do not test material that appeared only in passing unless the question is
  clearly low stakes and unambiguous.
- For coding questions, prefer functions, datasets, and workflows already
  familiar to students from class.

## Difficulty Rules

### True / False

- Easy to moderate
- Concept checks grounded directly in lecture content
- Direct interpretation of lecture concepts and code shown in slides
- Include both theoretical and code-understanding items if both were taught
- Avoid subtle wording tricks

### Multiple Choice

- Moderate
- Require discrimination between similar concepts or procedures
- May combine conceptual understanding with interpretation of short code
  snippets if consistent with class material
- Distractors should reflect realistic student misunderstandings

### Coding Question

- Hard but fair
- Should require several lines of code and deliberate thought
- Should still be feasible using only code patterns taught in class
- Should not depend on debugging obscure syntax
- If a necessary helper function might need revision, the prompt should name it
  and briefly state what students should review before solving

## Bank Design Rules

- Within each bank, maintain consistent style and difficulty.
- Avoid near-duplicate questions.
- Ensure that random draws still produce a fair and representative assessment.
- For multiple-choice, define subsection boundaries clearly before writing the
  banks.
- If the lecture structure is unclear, infer reasonable subsections and state
  them explicitly.

## Required Instructor Materials

For every question created, provide:

- the correct answer
- a short explanation of why it is correct
- for coding questions, runnable R code that produces the answer
- when useful, runnable code for checking or revising non-coding answers

The instructor materials should be easy to audit and revise.

## Preferred Output Structure

### Section A: Source Basis

- Lecture(s) used
- Subsection structure used for banks
- Any assumptions made

### Section B: Canvas-Ready Student Content

For each bank or problem:

- bank name or problem title
- student-facing prompt
- answer options where applicable
- expected final answer format for coding questions

### Section C: Instructor Key

For each question:

- correct answer
- short explanation
- notes on difficulty or coverage

### Section D: R Review Script

For each elaborate coding question:

- runnable R solution code
- expected output
- package and dataset requirements

### Section E: Instructor Audit Notes

- coverage notes
- difficulty notes
- Canvas formatting notes
- any items that may need manual adjustment

## Workflow

1. Read the lecture material carefully before writing any questions.
2. Identify the full set of concepts, examples, functions, and code patterns
   actually taught.
3. Divide the lecture into meaningful subsections for multiple-choice banks.
4. Write the True / False bank to cover the lecture broadly.
5. Write the multiple-choice banks by subsection, keeping each bank internally
   consistent.
6. Write the coding question using a taught dataset or a base R/`dslabs`
   dataset, ensuring the final answer is machine-checkable.
7. Produce the answer key and runnable R review code.
8. Check every question against the lecture material for alignment.
9. Remove or revise any question that depends on unstated knowledge.
10. Place generated Canvas-ready and instructor-only outputs under
    `outputs/problem-sets/` unless the instructor asks for another location.
11. Summarize any assumptions or places where instructor review is especially
    important.

## Quality Checks

Before finishing, verify that:

- True / False bank has at least 10 to 12 items
- each multiple-choice bank has at least 5 items
- multiple-choice questions have exactly 4 options
- difficulty is consistent within each bank
- coding questions use datasets and packages available to students
- coding answers are machine-checkable
- every question is supported by lecture content, unless new usage is
  explicitly introduced in the prompt
- answer keys are complete
- runnable R review code is provided for elaborate coding questions
- wording is clear and Canvas-ready
- instructor-only material is not mixed into student-facing prompts

## Output Style

Write in clean instructor-ready format, suitable for later transfer to Canvas.

Do not provide only rough ideas. Produce the full banks, complete answer keys,
and the runnable code needed for instructor validation.
