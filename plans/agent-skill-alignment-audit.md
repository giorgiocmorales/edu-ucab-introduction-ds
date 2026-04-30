# Agent and Skill Alignment Audit

This audit compares the current `AGENTS.md` and repo-local skills against the
actual lecture materials in `lectures/01-course-intro-r-basics/` and
`lectures/02-data-wrangling-dplyr/`, the lecture templates, handouts, render
scripts, and problem-set scaffold.

## Recommended Additions

- Document the repeated slide arc used by completed lectures:
  - minimal YAML with `title`, `subtitle`, and `format: revealjs`
  - an opening `## Main Message {.main-message}` slide
  - `#` headings for major lecture sections
  - `##` headings for individual slides
  - recurring `## Intervention Space {.intervention-slide}` slides
  - a closing `## Main Message {.main-message}` slide

- Add an explicit convention for intervention slides. The template and both
  completed lectures use a question followed by one or more `::: fragment`
  blocks, usually ending with a revealed answer. This should be promoted as a
  preferred pattern for pauses, checks for understanding, and short in-class
  prompts.

- Add a code-slide convention that matches the completed lectures:
  - introduce the concept in prose before showing code
  - show short R chunks wrapped in `::: fragment` when pacing matters
  - use code comments as visible labels for each conceptual step
  - add short interpretation text after code when students should notice an
    output or consequence
  - use hidden setup chunks with `#| include: false` only for package/data setup
    that is needed for rendering but is not itself the teaching target

- Add an image and asset convention. Current lecture images live in
  lecture-local `assets/` folders and are inserted with explicit widths and
  `fig-alt` text. The contract should say that lecture images should include
  alt text where practical, and reusable course-wide logos/backgrounds belong
  in `lectures/_format/`.

- Add a handout structure convention based on the actual handouts and template:
  - first lines identify lecture number and handout title
  - section headers use the RStudio section marker style, for example
    `# PACKAGES ---------------------------------------------------------------`
  - scripts are short, runnable, and ordered by lecture flow
  - handout numbering is continuous across the course, currently `01` through
    `08` across Lectures 01 and 02
  - handouts may include practice prompts at the end

- Add dependency alignment checks. `scripts/setup_project.R` currently prepares
  `dslabs`, `here`, `knitr`, and `tidyverse`; the lecture skills should ask
  agents to update this script when a lecture introduces a new required package
  for rendering or handouts.

- Add a problem-set mode distinction. The repo currently has:
  - `problem-sets/_templates/problem-set.R`, which is a script assignment
    template
  - `.agents/skills/problem-set-create/SKILL.md`, which is for Canvas/Modulo 7
    question banks
  - `problem-sets/README.md`, which describes `.qmd` assignment folders

  These are three different artifacts and should be named separately in
  `AGENTS.md` and the relevant skill docs.

- Add a skill-discovery rule. `AGENTS.md` says repo-local skills live in
  `.agents/skills/`, but it does not explicitly tell agents to inspect the
  relevant skill before doing lecture creation, lecture review, lecture cleanup,
  or problem-set/question-bank work.

- Add render-output expectations from the export script. The PowerShell helper
  renders from the lecture folder and writes PDFs to
  `outputs/rendered-slides/lectures/NN-short-lecture-name/lecture-NN-slides.pdf`.
  This should be reflected in review and cleanup checks.

## Recommended Deletions

- Remove or soften the `lecture-create` instruction to "use all codes" from
  legacy scripts. The actual lecture practice is selective adaptation into
  smaller pedagogical units, not exhaustive inclusion of every legacy code line.

- Remove the standing instruction to "Make atomic git commits" from
  `AGENTS.md`, or move it behind "when the user asks for commits." The current
  repo practice and agent workflow do not imply committing automatically after
  every logical change.

- Remove the review check saying slide content must not exceed "the upper and
  lower lines lines defined in the shared format" unless the shared format
  defines concrete safe-area rules. As written, it is imprecise and duplicated.
  A better review criterion is that content must fit the slide without
  overlapping footer, logo, slide numbers, or background framing.

- Do not formalize exact lecture length, exact number of fragments, exact number
  of intervention slides, or exact number of assets. Lecture 01 is much longer
  than Lecture 02 because it combines course intro, tools, and first R concepts;
  that should not become the default target.

- Do not elevate the `00-quarto-guide-preview` deck into the lecture standard.
  It is useful as a Quarto reference deck, but the completed lecture pattern is
  better represented by Lectures 01 and 02 plus `lectures/_templates/`.

- Do not make `install.packages()` slides a general lecture requirement.
  Lecture 01 includes package installation because setup is part of that
  lecture's content. Later lectures should usually load required packages in
  hidden setup chunks or handouts rather than teaching installation repeatedly.

- Do not treat the large embedded/background implementation in
  `lectures/_format/slide-backgrounds.html` as an authoring pattern for normal
  lecture files. It is shared format machinery, not slide-writing practice.

- Do not codify the current dirty working tree, untracked assets, or staged
  rename state as repo practice. Those are workflow artifacts, not scaffold
  conventions.

## Recommended Clarifications

- Clarify "all R functions must have short explanatory texts" in `AGENTS.md`.
  The completed lectures explain new student-facing functions and operators
  such as `library()`, `data()`, `$`, `select()`, `filter()`, and `%>%`, but
  they do not provide a separate explanatory text for every repeated call or
  helper function. Recommended wording: explain each new student-facing
  function, operator, or workflow the first time it is taught.

- Clarify that "normally contains only `slides.qmd`, `handouts/`, and
  `assets/`" applies to the root of each lecture folder. It should still allow
  ordinary files inside `assets/` and `handouts/`, and possibly `.gitkeep` files
  where an empty directory must be tracked.

- Clarify that `legacy/`, `references/`, and `data/` may be read as source
  material but should not be reorganized or deleted without explicit
  instruction. `AGENTS.md` currently calls them "source or archival areas,"
  while other docs describe them as local-only content.

- Clarify when plans are required. "For non-trivial tasks" is directionally
  useful, but agents need examples. Suggested trigger: create a plan before
  large lecture creation, structural reorganization, multi-file cleanup, or
  changes to the shared format; no plan needed for small typo fixes or narrow
  path updates.

- Clarify render checks by task type:
  - lecture content changes: render the affected lecture
  - shared format or metadata changes: render at least the preview deck and one
    active lecture, preferably Lectures 01 and 02
  - PDF workflow changes: run `scripts/export_lecture_pdf.ps1` for one lecture
    if Edge is available

- Clarify output naming. README/SETUP mention lecture-numbered exports, while
  the normal Quarto render remains `slides.html`. Skills should distinguish
  normal render output from shareable HTML/PDF naming.

- Clarify problem-set terminology. Use separate labels such as:
  - script problem set: `.R` assignment scaffold
  - rendered problem set: `.qmd` assignment scaffold
  - Canvas/Modulo 7 question bank: instructor-facing assessment bank with
    answer keys

- Clarify the `problem-set-create` coding-question dataset rule. The skill says
  a coding question may use a base R or `dslabs` dataset, but the workflow later
  says to use a base R dataset. The completed lectures use `dslabs::murders`
  and `dslabs::gapminder` heavily, so `dslabs` should remain allowed.

- Clarify whether local assets copied from cheatsheets or screenshots require
  citation or source notes in slides, handouts, or a local references file.
  Lecture 02 has many externally recognizable visual assets, but the agent
  contract does not currently state attribution expectations.

- Clarify whether generated `outputs/` should remain ignored or whether
  selected shareable exports should ever be tracked. Current docs say generated
  artifacts belong under `outputs/`, but the publication policy for final
  student-facing exports is not explicit.

- Fix text quality issues when rewriting the docs later:
  - `apperead` in `AGENTS.md`
  - mojibake in `lecture-create` where it should say `lecture's`
  - mojibake in `problem-set-create` where it should say `Modulo 7`
  - `muts use to asnwer` in `problem-set-create`
  - `Wach question` in `problem-set-create`
  - duplicated "lines lines" in `lecture-review`

## Open Questions for the Instructor

- Should every completed lecture be required to open and close with a
  `Main Message` slide, or is that only the preferred default?

- Should `Intervention Space` slides always include both a prompt and a hidden
  answer, or can some be left as instructor-led discussion prompts without a
  written answer?

- Should agents treat Lecture 01 as one integrated lecture despite its length,
  or should future cleanup split it into separate course-intro, R/RStudio, and
  first-code sessions?

- What is the intended relationship between slide examples and handouts:
  exact runnable mirror, reduced practice script, or expanded script with extra
  examples?

- Should handout numbering remain global for the entire course even if future
  lectures are rearranged, or should numbering be regenerated only at release
  milestones?

- Should problem sets be primarily `.R` scripts, `.qmd` rendered assignments,
  Canvas/Modulo 7 question banks, or all three as separate artifact types?

- Where should Canvas/Modulo 7 question banks live once generated:
  under `problem-sets/`, `outputs/problem-sets/`, `plans/`, or a new
  assessment-specific folder?

- Should question banks be source-controlled, or should they be treated as
  instructor-only/generated artifacts?

- Should external image sources, textbook references, and adapted legacy
  materials be cited in each lecture, in a course bibliography, or only in local
  planning notes?

- Should final shareable HTML/PDF exports ever be committed, or should GitHub
  track only source files and reproducible render scripts?

- Should `scripts/setup_project.R` stay as a lightweight installer, or should
  the course eventually return to a lockfile once the package set stabilizes?
