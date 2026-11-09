#!/usr/bin/env bash
# Instala tus 47 skills como plugins remotos (desde GitHub, nada copiado a mano).
# REMOTE_SKILLS: dónde está el marketplace "remote-skills" (este repo).
set -uo pipefail
REMOTE_SKILLS="${REMOTE_SKILLS:-tiagomedi/claude-skills}"

# 0. (Opcional) quitar el marketplace local de la versión anterior, si lo llegaste a añadir
claude plugin marketplace remove agents-skills 2>/dev/null || true

# 1. Marketplaces
claude plugin marketplace add anthropics/claude-plugins-official   # suele venir ya añadido
claude plugin marketplace add addyosmani/agent-skills              # -> addy-agent-skills
claude plugin marketplace add pbakaus/impeccable                   # -> impeccable
claude plugin marketplace add dietrichgebert/ponytail              # -> ponytail
claude plugin marketplace add "$REMOTE_SKILLS"                     # -> remote-skills

# 2. Plugins publicados por sus autores (33 de tus skills)
claude plugin install mattpocock-skills@claude-plugins-official    # 27 skills de Matt Pocock
claude plugin install frontend-design@claude-plugins-official
claude plugin install agent-skills@addy-agent-skills               # code-review-and-quality, interview-me, test-driven-development (+ otras de Addy)
claude plugin install impeccable@impeccable
claude plugin install ponytail@ponytail

# 3. Skills sin plugin publicado (14), servidas desde su repo original
for p in chief-of-staff bg-handoff loop-me setup-ts-deep-modules writing-beats writing-fragments writing-shape \
         git-guardrails migrate-to-shoehorn scaffold-exercises setup-pre-commit \
         find-skills design-mobile-apps security-audit; do
  claude plugin install "$p@remote-skills"
done
