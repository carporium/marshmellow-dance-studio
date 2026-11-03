# Marshmellow Dance Studio — Master Game Design & Technical Specification

**Version:** 1.0 | **Status:** Product scope and engineering blueprint | **Platform:** Android first | **Project:** carporium/marshmellow-dance-studio

> This is the authoritative long-term vision. It is NOT a claim that these features have been implemented. Track delivered functionality against the acceptance criteria below. No other repository or company project is in scope.

## 1. Product vision and design principles

Marshmellow Dance Studio is an original, child-friendly, visually beautiful, offline-first 3D dance-studio builder, dancer-development simulator and choreography game. The player is a studio owner and choreographer: design a studio, recruit students, organise classes, train dancers, build performances, enter competitions, win awards and grow into a respected dance company. The choreography itself is the heart of the game, not a superficial menu activity.

**Core pillars:** (1) real-looking, expressive, appealing articulated 3D dancers; (2) authentic movements across seven disciplines; (3) flexible choreography and formation design; (4) a satisfying, fair studio economy and progression loop; (5) creative freedom, accessibility and safety for children; (6) offline single-player as the default; (7) family and friend sharing without accounts or servers; (8) modular expansion without rewriting the engine.

**Audience:** primarily children approximately 7–12, with deeper systems for older players and parents. **Tone:** imaginative, aspirational, colourful, elegant, never sexualised, with encouraging feedback and no punitive monetisation.

## 2. Platforms, distribution and operation

- Android phones first, including Google Pixel; Android tablets next. Landscape layout recommended for stage, timeline and formations. Support varying aspect ratios, cut-outs, DPI, touch targets and low/mid-range devices.
- Deliver a real installable **APK** for private testing, signed appropriately for test distribution. Later offer an Android App Bundle for store distribution, subject to policy and parental approval.
- Offline first: no internet, sign-in, cloud, telemetry, ads, purchases or multiplayer required to play. All gameplay, asset playback, saving and competition simulation work in airplane mode.
- Distribution to family/friends: parent can send APK via a trusted messaging/file-sharing method where permitted, or share a packaged offline web demo clearly labelled as such. Android sideloading requires deliberate installation permission; explain safety and source trust. Do not promise that every messaging app will accept APK attachments.
- Updates must preserve save-game compatibility. Do not overwrite installed saves; use schema migrations and backups.
- Later optional cross-platform Windows/macOS/iOS builds should reuse game data and gameplay logic, with platform-specific packaging.

## 3. Full gameplay loop

1. Open game; select new or saved studio; optional parent-managed profile; personalise studio name and visual identity.
2. Start with modest virtual funds, a basic practice room, a teacher/player avatar and a small group of students.
3. Recruit/enrol students, choose class disciplines and levels, organise timetables and lesson fees.
4. Train students in technique, timing, expression, strength, flexibility, endurance, teamwork and discipline-specific mastery.
5. Compose routines using a visual choreography timeline; assign dancers, moves, formations, spacing, transitions and costume sets.
6. Rehearse: see a real animated stage preview, adjust counts, tempo, transitions and positions.
7. Enter appropriately ranked competitions, pay fictional entry fees, receive clear judging feedback, placements, trophies, virtual prize money and experience.
8. Upgrade rooms, costumes, props, staff and facilities; enrol more students, unlock advanced classes and Company; repeat with increasingly ambitious productions.

No pay-to-win mechanics. Virtual tuition, competition fees and prizes are transparent, balanced and never tied to real currency.

## 4. Visual direction and experience

- Original 3D art direction: polished, stylised-realistic, warm and expressive, with proportionally credible dancers and readable silhouettes. Roblox-like accessibility/customisation is a usability benchmark, **not** permission to copy Roblox avatars or assets.
- Pastel and jewel-tone palette, clean typographic hierarchy, soft studio lighting, polished floors, believable mirrors and barres, appealing costumes and a stage that is readable on mobile.
- Character editor: names, skin tones, facial features, hair types/colours, body shape variation, accessories, footwear and discipline-appropriate outfits; respectful, inclusive representation.
- Camera modes: orbit/zoom studio, front audience, angled stage, overhead formation editor, dancer focus and rehearsal replay.
- Distinct animation, effects, sound cues and interface feedback for success, progression, awards and unlocking content. Motion settings to reduce flashing and excessive effects.
- Avoid placeholder emoji/flat cards as a substitute for core 3D dance performance in any milestone described as a playable dance game.

## 5. Dance disciplines and authentic movement library

**Mandatory disciplines:** jazz, lyrical, tap, ballet, contemporary, hip hop, acro.

**Full-product baseline:** minimum **64 genuinely distinct usable animated movements per discipline**, at least **448 discipline-specific library entries**, with a long-term content pipeline supporting hundreds per discipline. Do not count labels, recolours, mirrored copies or static poses as unique choreography unless they represent a meaningful, separately authored movement variation. Shared foundational moves may be reused with correct style-specific execution but must be identified as shared rather than inflating distinct counts.

Each movement definition:
- stable id, display name, discipline(s), category, skill level, difficulty, teaching notes, tags;
- skeleton/rig compatibility, source animation asset, root motion policy, loopability, handedness/lead foot, duration in beats, beats-per-minute constraints, start/end stance and facing;
- travel distance, displacement curve, safe floor footprint, body-space envelope, transition compatibility, blend windows, required equipment/partner/acro prerequisites;
- score contribution, mastery thresholds, accessibility notes and asset licence/provenance.

Examples by discipline (illustrative only; validate with experienced teachers):
- Jazz: jazz walks, step-ball-change, kick-ball-change, pas de bourrée, pirouettes, leaps, isolations, jazz squares.
- Lyrical: expressive reaches, sustained turns, extensions, floor transitions, travelling leaps, controlled balances.
- Tap: shuffle, flap, ball change, cramp roll, buffalo, time step, heel/toe patterns, pullback.
- Ballet: plié, tendu, dégagé, relevé, arabesque, assemblé, glissade, pirouette, jeté.
- Contemporary: contraction/release, spiral, suspension, floor roll, off-axis balance, slide, fall/recovery.
- Hip hop: grooves, bounce, rock, body wave, isolations, popping, locking, footwork combinations.
- Acro: safe beginner bridges, cartwheels, handstands, walkovers and other graded skills with proper prerequisites. No instructional depiction that encourages unsafe real-world attempts; add a clear supervision notice.

**Asset pipeline:** rigged 3D character + retargetable skeletal animations; import/validation scripts; motion blending; foot IK/ground contact where feasible; tap-specific sound synchronisation; locomotion/root-motion alignment; metadata validation; LOD/performance profiles. Prefer original or properly licensed assets. Maintain a movement catalogue with statuses planned / captured / imported / validated / shipped.

## 6. Choreography editor — signature feature

- Build, save, duplicate, rename, edit, preview, export/import and delete routines.
- Timeline must support at least **two minutes** of choreography; multiple 8-count phrases, configurable tempo, music alignment, beat grid, snap, zoom, scroll, undo/redo, and copy/paste phrases.
- Per-dancer or group tracks; movement clips with duration, offsets, transitions, facing, timing, stagger and start/end poses.
- Formation editor with draggable dancer tokens on a scaled floor, lines, diagonals, circles, V, stagger, clusters and custom placements. Support formations at timeline keyframes, interpolated travel paths and collision/spacing warnings.
- Multi-dancer playback in sync with camera controls, pause/scrub/slow motion, optional count overlays and rehearsal loop.
- Automatic movement-compatibility checks for impossible transitions, occupied stage space, insufficient preparation or unavailable skill levels; allow creative override with warning where safe.
- Music must be original, commissioned, public domain or appropriately licensed for distribution. Avoid embedding commercial copyrighted tracks.
- Routine evaluation considers musicality, technical difficulty vs dancer skill, synchronisation, variety, formations, transitions and expression. Clearly show why scores change.
- Future: duet/solo/group divisions, lifts with prerequisites, props, alternate stages, video export subject to platform permissions.

## 7. Student, class and Company systems

**Students:** unique local IDs, editable names, visual appearance, age-appropriate fictional skill levels, enrolled disciplines, attendance, fatigue, confidence, motivation, mastered moves, costumes, awards and progress history. No real child information required.

**Classes:** discipline, level (beginner/intermediate/advanced), teacher, capacity, room, schedule, fees, training goals and attendance. Player can add classes as studio expands.

**Progression:** practice yields measured skill improvements with diminishing returns and rest; quality of coaching, room equipment and class match affect results. Mastery unlocks more difficult moves, routines and competition divisions. Clear child-friendly feedback.

**Company:** selective advanced troupe/classes unlocked by studio reputation and student readiness; higher fictional tuition and prestige, more complex routines and higher-tier competitions, but not an irreversible penalty for students who remain recreational.

## 8. Studio construction and customisation

Start with reception and one practice room. Expand into multiple studios, stage/performance space, changing area, costume wardrobe, trophy cabinet and amenities. Place and upgrade mirrors, ballet barres, sprung floors, sound systems, lighting, seating, signage and decorations. Use grid/snap placement with optional free positioning, collision checks, room capacities and budgets. Save room layouts. Decorations should have cosmetic value; functional upgrades should have transparent benefits.

## 9. Economy, competitions and progression

- Virtual currency only; starter grant, class tuition, competition prizes, studio running costs, room construction, costumes and competition entry fees.
- No ads, loot boxes, microtransactions, gambling, real-money purchase prompts or dark patterns in child-facing builds.
- Difficulty tiers: local showcase, regional, state, national and elite invitation events; solo/duo/group and style divisions later.
- Judges evaluate deterministic, explainable factors with limited seeded variation; difficulty balanced against execution. Provide scorecards, rankings, trophies, unlocks and constructive comments.
- Game should remain fun without excessive grinding, loss of progress or forced waiting.

## 10. Family, friends and offline sharing

**Phase 1:** single-player local studio with multiple optional family profiles, each independently saved; parent controls for export/import/reset; no personal account or contact collection.

**Phase 2:** offline shareable packages for routines, costume presets and studio layouts, containing only approved game data. A parent can export a small versioned file via Android share sheet or nearby transfer and another device can import it offline. Include file size limits, schema validation, sanitisation, asset dependency checks, duplicate-ID handling and import preview. Never execute code from imported files.

**Phase 3:** asynchronous friend challenges: share a routine/challenge file, play it on another device, optionally share a scorecard back; no server or real-time multiplayer required. Clearly distinguish a friend-created challenge from a trusted official game event. Avoid public user-generated content feeds.

**Later optional:** same-Wi-Fi local multiplayer or Bluetooth exchange only after security and usability validation; never make this a prerequisite for offline solo play. No stranger chat, location sharing, child profiles in public directories or unmoderated uploads.

## 11. Suggested technical architecture

**Preferred engine:** Godot 4.x with GDScript for open-source tooling, portable Android export and low dependency cost; revisit Unity only with a documented performance/content-pipeline justification.

Modules:
- Boot/AppState, Settings, ProfileManager, SaveManager and MigrationManager.
- StudioWorld, BuildMode, FurnitureCatalogue, EconomyService.
- StudentRoster, SkillService, ClassScheduler, CompanyProgression.
- DanceCatalogue, AnimationController, Retargeting/IK, BeatClock, RoutineTimeline, FormationSolver, StagePlayback.
- CompetitionService, ScoringEngine, Rewards/Unlocks.
- ImportExportService, FeedbackService, AssetValidation and Diagnostics.
- UI: main menu, studio, roster, class management, choreography, rehearsal, competitions, shop, trophies, feedback and parent tools.

**Data:** versioned JSON/resources for static content and local save snapshots; stable IDs; checksums/backups; deterministic simulation seeds; transactional save writes. Keep authored content separate from engine logic. Never trust imported files.

**Performance targets (to validate on devices):** smooth 30 FPS minimum on representative supported Android hardware, 60 FPS preferred on newer phones; responsive touch, bounded memory, appropriate skeletal mesh/texture LOD, batching and culling. Profile multi-dancer scenes on a physical Pixel before finalising content density.

**Security/privacy:** offline by default; minimal Android permissions; no sensitive data collection; child-safe naming and export prompts; no embedded secrets; third-party licence audit.

## 12. Repository layout (target)

```text
/
  project.godot
  README.md
  docs/
    GAME_MASTER_SPEC.md
    RELEASE_PLAN.md
    MOVEMENT_CATALOGUE.md
    ART_DIRECTION.md
    TEST_PLAN.md
  scenes/
    ui/ studio/ dancers/ stage/ competition/
  scripts/
    core/ studio/ dancers/ choreography/ economy/ competition/ sharing/
  assets/
    models/ rigs/ animations/ costumes/ environments/ audio/ ui/
  data/
    movements/ students/ classes/ competitions/ furniture/
  tests/
    unit/ integration/ device/
  .github/workflows/
    validate.yml
    android-build.yml
```

This is a target structure; current repository files may be incomplete.

## 13. Release plan and strict gates

### P0 — Technical foundation
Godot project opens; boot scene, navigation, save/load, Android export configuration, CI validation and reproducible APK build. No claims of an Android release until a real APK artefact exists and installation is verified.

### P1 — First **meaningful** Abi test prototype
One appealing 3D studio room, at least three rigged dancers, initial customisation, enrolment/class creation, **at least eight genuinely animated distinct dance moves**, basic timeline and at least three editable formations, synchronous rehearsal playback, tuition/practice/competition loop, local saving, child-friendly feedback capture, offline Android APK. The editor should accommodate a two-minute routine, while honestly disclosing initial content limitations.

### P2 — Core creative game
Seven disciplines playable; robust choreography editing, improved transition quality, richer stage/studio building, student growth, costume changes, competition feedback, Company progression, tested Android stability.

### P3 — Full movement baseline
64 validated animated movements per discipline (448 total minimum), meaningful skill progression, more formations and stages, choreography variety and optimisation. Verify each shipped movement in the catalogue.

### P4 — Family/friend sharing
Versioned offline exports/imports, parent-mediated file sharing, cross-device save transfer, asynchronous routine challenges and compatibility tests.

### P5 — Polish and distribution
Accessibility, onboarding, full art/audio pass, performance on representative Android devices, privacy/licensing review, crash and regression testing, store-readiness if desired.

## 14. Test and acceptance requirements

**P1 acceptance journey:** install APK on Google Pixel; launch without internet; create a studio; enrol three dancers; choose a discipline; add and preview genuine animated movements; edit formations; save and reopen a routine; practise; enter a competition; earn a score/prize; close/relaunch without losing progress; record feedback locally. No crashes or blank screens.

**Automated tests:** project import/scene parsing; content schema validation; save migration/round-trip; scoring reproducibility; choreography clip constraints; formation bounds/collision; import sanitisation; Android build workflow. **Manual device tests:** touch layout, orientation, startup, animation quality, offline mode, storage, performance, battery/heat, permissions, APK install/update.

**Release evidence:** PR, commit SHA, test report, successful Android CI run, downloadable APK artefact, installed-device test result, known limitations and a feedback log. Never mark a milestone delivered from a mock-up, a screenshot, an HTML page or a passing syntax check alone.

## 15. Feedback programme

In-game feedback suitable for a child: enjoyment rating (emoji scale), favourite activity, confusing moment, desired feature, optional parent note. Store locally, export via parent-controlled share; never transmit automatically. Record issue category, priority, version, reproduction steps and resolution. Prioritise feedback about fun, animation quality and usability before expanding content volume.

## 16. Copilot delivery rules

- Implement working code in small, reviewable PRs with clear acceptance tests; **do not stop at architecture documents**.
- Work on this repository only. Do not touch FRNSH or any other project.
- Prioritise P0 then P1; do not attempt to create all 448 moves before shipping the first real animated prototype.
- Use genuine 3D assets and animation, documenting licensing and provenance. No fake movement counts.
- Run automated checks, produce a real APK, and report build and device verification separately.
- Update README and release notes with implemented vs planned features; do not describe unimplemented features as present.
- Maintain a live implementation matrix (feature, planned, in progress, tested, shipped, blockers).
- Do not merge failing builds, and do not publish a child-facing build without parent review.

## 17. Open design decisions

Final avatar style and quality benchmark; animation sourcing/creation workflow; exact Android minimum OS/device profile; target package size and performance budget; competition scoring calibration; offline export file format and privacy controls; whether future local multiplayer is warranted. Resolve these by short prototypes and observed player feedback, not by silently removing scope.

## 18. Non-goals for initial prototype

No online accounts, real-time multiplayer, public UGC marketplace, monetisation, paid music licences, full 448-move catalogue or photorealistic motion capture requirement for P1. These exclusions apply only to P1, not the stated long-term roadmap.

---
**Source of truth:** this document for the complete game vision; issue #2 for the immediate prototype. In any conflict, preserve this vision while using the release gates to prioritise implementation.
